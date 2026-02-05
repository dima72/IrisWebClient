unit Main;

/// ---------------------------------------------------------------------------
///  Rich GUI web application for InterSystems IRIS database.
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
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, uniGUIVars,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniTreeView,
  uniTreeMenu, unimTreeMenu, unimMenu, uniGUImJSForm, unimPanel, uniSplitter,
  Vcl.Menus, uniMainMenu, System.Actions, Vcl.ActnList, uniToolBar, uniGUIFrame,
  uniPanel, Vcl.Imaging.jpeg, uniImage, uniTimer, uniMemo, uniHTMLFrame,
  uniImageList, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uniBasicGrid, uniDBGrid;

type
  TMainForm = class(TUniForm)
    mnuMain: TUniMainMenu;
    File1: TUniMenuItem;
    Exit1: TUniMenuItem;
    alMain: TUniActionList;
    acPersonDict: TAction;
    WorkArea: TUniContainerPanel;
    UniTreeMenu1: TUniTreeMenu;
    UniSplitter1: TUniSplitter;
    UniHTMLFrame1: TUniHTMLFrame;
    acExit: TAction;
    ilMenu: TUniNativeImageList;
    procedure UniFormCreate(Sender: TObject);
    procedure UniTreeMenu1Click(Sender: TObject);
    procedure acExitExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.UniFormCreate(Sender: TObject);
var
  M: TModuleInfo;
  Node: TUniTreeNode;
begin
  UniTreeMenu1.Items.Clear;
  for M in TModuleRegistry.GetModules do begin
    Node := UniTreeMenu1.Items.Add(nil, M.Name);
    Node.ImageIndex := M.IconIndex;  // integer index in UniImageList
    Node.SelectedIndex := M.IconIndex;
    Node.Data := Pointer(M);
  end;
  with UniHTMLFrame1 do
  begin
    Parent := WorkArea;
    Align := alClient;
    HTML.Text :=
      '<div style="padding:20px;font-size:22px;font-weight:bold;color:#003366;"> '+
      'IRIS Web Client<br> <span style="font-size:14px;color:#666;">'+
      'This application demonstrates the implementation of<br>'+
      'CRUD operations (Create, Read, Update, Delete) and<br>'+
      'insert/update of referential class properties, e.g. Person->Spouse, Employee->Company.<br>'+
      '<br>'+
      '<br>'+
      'It also demonstrates data filtering using IRIS implicit JOIN,<br>'+
      'allowing the recordset to be filtered by referential properties,<br>'+
      'e.g. Person->Spouse->Name, Employee->Company->Name.<br>'+
      '</span> </div>';
  end;
end;

procedure TMainForm.acExitExecute(Sender: TObject);
begin
  UniSession.Terminate('Goodbye');
end;

procedure TMainForm.UniTreeMenu1Click(Sender: TObject);
var
  F: TUniFrame;
  M: TModuleInfo;
  I: Integer;
  Q: TFDQuery;
  G: TUniDBGrid;
begin
  if not Assigned(UniTreeMenu1.Selected) then Exit;

  // 1) Hide all frames currently in WorkArea
  for I := 0 to WorkArea.ComponentCount - 1 do
    if WorkArea.Components[I] is TUniFrame then
      (WorkArea.Components[I] as TUniFrame).Visible := False;

  for I := 0 to UniTreeMenu1.Items.Count-1 do begin
    M := TModuleInfo(UniTreeMenu1.Items[i].Data);
    Q := TFDQuery(UniMainModule.FindComponent(M.MainQuery));
    // Close to use less memory per session
    if Q.Active then
      Q.Close;
  end;

  M := TModuleInfo(UniTreeMenu1.Selected.Data);
  Q := TFDQuery(UniMainModule.FindComponent(M.MainQuery));
  if Assigned(Q) then
  begin
    if not Q.Active then
      Q.Open;
    Q.First;  // reset cursor to avoid “last page”
  end;
  F := UniMainModule.GetFrame(M.Name, WorkArea);
  G := F.FindComponent('grdMain') as TUniDBGrid;

  if Assigned(G) then begin
    ApplyFieldLabelsToGrid(G);
    G.DataSource.DataSet := Q;
  end;
  // using Caption as frame identifier
  F.Caption := M.Name;
  F.Parent := WorkArea;
  F.Align := alClient;
  F.Visible := True;
  F.BringToFront;
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
