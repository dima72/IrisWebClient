unit ServerModule;

/// ---------------------------------------------------------------------------
///  Copyright © 2026 RocketCitySoft LLC
///  https://www.rocketcitysoft.com
///
///  Author: Dmitry Konnov  (konnov72@gmail.com)
///  License: MGPL – Modified GNU Public License
///  This module requires attribution to the original author in derivative works.
///
///  History:
///    Jan 2026 – Initial version
/// ---------------------------------------------------------------------------

interface

uses
  Classes, SysUtils, uniGUIServer, uniGUIMainModule, uniGUIApplication,
  uniGUITypes, uIdContext, uIdCookie, uIdCustomHTTPServer, uClientTracker;

type
  TUniServerModule = class(TUniGUIServerModule)
    procedure UniGUIServerModuleHTTPCommand(ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo; var Handled: Boolean);
    procedure UniGUIServerModuleCreate(Sender: TObject);
    procedure UniGUIServerModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure FirstInit; override;
  public
    { Public declarations }
  end;

function UniServerModule: TUniServerModule;

var
  ClientTracker: TClientTracker;

implementation

{$R *.dfm}

uses
  uniGUIVars;

function UniServerModule: TUniServerModule;
begin
  Result := TUniServerModule(UniGUIServerInstance);
end;

procedure TUniServerModule.FirstInit;
begin
  InitServerModule(Self);
end;

procedure TUniServerModule.UniGUIServerModuleCreate(Sender: TObject);
begin
  ClientTracker := TClientTracker.Create(StartPath + 'clients.ini');
end;

procedure TUniServerModule.UniGUIServerModuleDestroy(Sender: TObject);
begin
  ClientTracker.Free
end;

procedure TUniServerModule.UniGUIServerModuleHTTPCommand(
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo;
  var Handled: Boolean);
var
  C: TIdCookie;
begin
  // read cookie
  C := ARequestInfo.Cookies.Cookie['AUTH',''];

  // already authenticated?
  if Assigned(C) and (C.Value='1') then
    Exit;

  // login POST from login.html
  if (ARequestInfo.Command='POST') and (ARequestInfo.Document='/') then
  begin
    if SameText(ARequestInfo.Params.Values['user'], 'demo') and
       SameText(ARequestInfo.Params.Values['pass'], 'demo') then
    begin
      with AResponseInfo.Cookies.Add do
      begin
        CookieName := 'AUTH';
        Value := '1';
        Domain := '';
        Path := '/';
      end;
      AResponseInfo.Redirect('/');
      Handled := True;
      Exit;
    end;

    AResponseInfo.Redirect('/login.html');
    Handled := True;
    Exit;
  end;

  // any unauthenticated access to app root ? login
  if ARequestInfo.Document='/' then
  begin
    AResponseInfo.Redirect('/login.html');
    Handled := True;
  end;

end;

initialization
  RegisterServerModuleClass(TUniServerModule);
end.
