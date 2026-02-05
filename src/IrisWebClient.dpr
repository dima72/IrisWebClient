{$define UNIGUI_VCL} // Comment out this line to turn this project into an ISAPI module

{$ifndef UNIGUI_VCL}
library
{$else}
program
{$endif}
  IrisWebClient;

uses
  uniGUIISAPI,
  Winapi.Windows,
  Forms,
  SysUtils,
  FireDAC.Comp.Client,
  ServerModule in 'ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in 'Main.pas' {MainForm: TUniForm},
  PersonFrame in 'PersonFrame.pas' {PersonFrme: TUniFrame},
  EmployeeFrame in 'EmployeeFrame.pas' {EmployeeFrme: TUniFrame},
  CompanyFrame in 'CompanyFrame.pas' {CompanyFrme: TUniFrame},
  PersonDictForm in 'PersonDictForm.pas' {PersonDictFrm: TUniForm},
  uFilterDialog in 'uFilterDialog.pas' {frmFilter: TUniForm},
  NavigatorFrame in 'NavigatorFrame.pas' {NavigatorFrme: TUniFrame},
  uClientTracker in 'uClientTracker.pas';

{$R *.res}

{$ifndef UNIGUI_VCL}
exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;
{$endif}

procedure WinMsg(const Text, Caption: string; Flags: UINT = MB_OK or MB_ICONINFORMATION);
begin
  MessageBoxW(0, PWideChar(Text), PWideChar(Caption), Flags);
end;

begin
{$ifdef UNIGUI_VCL}
  if not FileExists('login.html') then begin
    WinMsg('Missing login.html. Server cannot be started.', 'Critical Error');
    Exit;
  end;
  if not FileExists('connection.ini') then begin
    WinMsg('connection.ini. Server cannot be started.', 'Critical Error');
    Exit;
  end;
  //testing connection to IRIS.
  with TFDConnection.Create(nil) do begin
    try
    Params.LoadFromFile('connection.ini');
    Connected := True;
    Free;
    except
      on E: Exception do begin
        WinMsg('Testing connection to IRIS:' + E.Message, 'Critical Error');
        Exit;
      end;
    end;
  end;
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
{$endif}
end.
