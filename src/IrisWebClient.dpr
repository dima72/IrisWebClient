{$define UNIGUI_VCL} // Comment out this line to turn this project into an ISAPI module

{$ifndef UNIGUI_VCL}
library
{$else}
program
{$endif}
  IrisWebClient;

uses
  uniGUIISAPI,
  Forms,
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

begin
{$ifdef UNIGUI_VCL}
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
{$endif}
end.
