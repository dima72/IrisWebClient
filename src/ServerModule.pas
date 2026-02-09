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
  uniGUITypes, uniGUIVars, uIdContext, uIdCookie, uIdCustomHTTPServer, uClientTracker,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client;

type
  TUniServerModule = class(TUniGUIServerModule)
    TestConnection: TFDConnection;
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

  if not FileExists('login.html') then
    raise Exception.Create('Missing login.html. Server cannot be started.');
  with TestConnection do begin
    if FileExists('connection.ini') then
      Params.LoadFromFile('connection.ini')
    else begin
    //supossedly running in a container and using Environment Variables
      Params.Add('DriverID=ODBC');
      Params.Add('ODBCDriver=InterSystems IRIS ODBC35');
      Params.Add('Server=' + GetEnvironmentVariable('IRIS_HOST'));
      Params.Add('Port=' + GetEnvironmentVariable('IRIS_PORT'));
      Params.Add('Database=' + GetEnvironmentVariable('IRIS_NAMESPACE'));
      Params.Add('User_Name=' + GetEnvironmentVariable('IRIS_USER'));
      Params.Add('Password=' + GetEnvironmentVariable('IRIS_PASSWORD'));
    end;
    Connected := True;
    Connected := False;
  end;
  FrameworkFilesRoot :=
  IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'Framework';
  ExtRoot := IncludeTrailingPathDelimiter(FrameworkFilesRoot) + 'uniGUI' +
    PathDelim + 'ext-7.9.0' + PathDelim;
  UniRoot:= IncludeTrailingPathDelimiter(FrameworkFilesRoot) + 'uniGUI' +
    PathDelim + 'uni-1.95.0.1610' + PathDelim;
  UniPackagesRoot := IncludeTrailingPathDelimiter(FrameworkFilesRoot) + 'uniGUI' +
    PathDelim + 'ext-7.9.0' + PathDelim + 'ext-addons' + PathDelim + 'packages' + PathDelim;
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
