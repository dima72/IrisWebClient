unit uFilterDialog;

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
  System.SysUtils, System.Classes, uniGUIBaseClasses, uniGUIClasses,
  uniGUIForm, uniGUIApplication, UniButton, UniDBGrid, UniDBNavigator,
  FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, Vcl.Controls, Vcl.Forms, uniBasicGrid,
  uniToolBar, uniPanel, Variants, FireDAC.Stan.StorageBin, uniMultiItem,
  uniComboBox, uniDBComboBox, uniDBLookupComboBox, System.Actions, Vcl.ActnList,
  uniMainMenu;

type
  TfrmFilter = class(TUniForm)
    mtFilter: TFDMemTable;
    dsFilter: TDataSource;
    gridFilter: TUniDBGrid;
    UniToolBar1: TUniToolBar;
    mtFilterFieldName: TStringField;
    mtFilterOperator: TStringField;
    mtFilterValue: TStringField;
    mtFilterLogic: TStringField;
    UniPanel1: TUniPanel;
    UniButton2: TUniButton;
    btnApplyFilter: TUniButton;
    mtFieldNames: TFDMemTable;
    mtFieldNamesFieldName: TStringField;
    UniHiddenPanel1: TUniHiddenPanel;
    UniDBLookupComboBox2: TUniDBLookupComboBox;
    dsrFieldNames: TDataSource;
    btnAdd: TUniToolButton;
    UniActionList1: TUniActionList;
    acAdd: TAction;
    acDelete: TAction;
    UniToolButton1: TUniToolButton;
    btnClearFilter: TUniButton;
    procedure btnApplyFilterClick(Sender: TObject);
    procedure acAddExecute(Sender: TObject);
    procedure acDeleteExecute(Sender: TObject);
    procedure btnClearFilterClick(Sender: TObject);
  private
    FQuery: TFDQuery;
    function BuildWhere: string;
    function GetOriginalSQL: string;
  public
    constructor Create(AOwner: TComponent; AQuery: TFDQuery; AFilterFields: TStrings);
  end;

implementation

uses MainModule, NavigatorFrame;

{$R *.dfm}

constructor TfrmFilter.Create(AOwner: TComponent; AQuery: TFDQuery; AFilterFields: TStrings);
var
 I: Integer;
begin
  inherited Create(AOwner);
  FQuery := AQuery;
  mtFilter.Active := True;
  mtFieldNames.Active := True;
  if (mtFilter.RecordCount = 0) and (AFilterFields.Count > 0) then begin
    mtFilter.Append;
    mtFilter['FieldName'] := AFilterFields.Strings[0];
    mtFilter['Operator'] := 'contains';
    mtFilter.Post;
  end;
  for I := 0 to AFilterFields.Count-1 do begin
    mtFieldNames.Append;
    mtFieldNames['FieldName'] := AFilterFields.Strings[I];
    mtFieldNames.Post;
  end;
end;

function TfrmFilter.BuildWhere: string;
var
  S, Op, Fld, Val, Lg: string;
  Pnum: Integer;
begin
  Result := '';
  Pnum := 1;
  mtFilter.First;
  while not mtFilter.Eof do
  begin
    Fld := VarToStrDef(mtFilter['FieldName'], '');
    CheckError(Fld <> '', 'Column ''FieldName'' is Empty');
    Op  := VarToStrDef(mtFilter['Operator'], '');
    CheckError(Op <> '', 'Column ''Operator'' is Empty');
    Val := VarToStrDef(mtFilter['Value'], '');
    CheckError(Val <> '', 'Column ''Value'' is Empty');
    Lg  := VarToStrDef(mtFilter['Logic'], '');

    if Op = 'contains' then
      S := Format('%s LIKE :P%d', [Fld, Pnum])
    else if Op = 'startswith' then
      S := Format('%s LIKE :P%d', [Fld, Pnum])
    else if Op = 'endswith' then
      S := Format('%s LIKE :P%d', [Fld, Pnum]);
    Inc(Pnum);
    mtFilter.Next;
    // if not last record
    if not mtFilter.Eof then begin
      CheckError(Lg <> '', 'Column ''Logic'' should be AND/OR');
      Result := Result + S + ' ' + Lg + ' '
    end
    else
      Result := Result + S; // ignore AND/OR
  end;
end;

procedure TfrmFilter.acAddExecute(Sender: TObject);

  function FindNextAvailableFieldName(AListDataSet, AUsedDataSet: TDataSet): string;
  begin
    Result := '';
    try
      AListDataSet.DisableControls;
      AUsedDataSet.DisableControls;
      AListDataSet.First;
      while not AListDataSet.Eof do
      begin
        // check if this FieldName exists in AUsedDataSet
        if not AUsedDataSet.Locate('FieldName',
                                   AListDataSet.FieldByName('FieldName').AsString,
                                   []) then
        begin
          Result := AListDataSet.FieldByName('FieldName').AsString;
          Exit;
        end;

        AListDataSet.Next;
      end;
    finally
      AListDataSet.EnableControls;
      AUsedDataSet.EnableControls;
    end;
  end;

var
  NextFieldName: string;
begin
  try
    CheckError(VarToStrDef(mtFilter['Value'], '') <> '', 'Column ''Value'' is Empty');
//    CheckError(VarToStrDef(mtFilter['Logic'], '') <> '', 'Column ''Logic'' should be AND/OR');
    if VarToStrDef(mtFilter['Logic'], '') = '' then begin
      mtFilter.Edit;
      mtFilter['Logic'] := 'AND';
      mtFilter.Post;
    end;
    NextFieldName := FindNextAvailableFieldName(mtFieldNames, mtFilter);
    mtFilter.DisableControls;
    try
      mtFilter.Append;
      if NextFieldName <> '' then begin
        mtFilter['FieldName'] := NextFieldName;
        mtFilter['Operator'] := 'contains';
      end;
      mtFilter.Post;
    finally
      mtFilter.EnableControls;
    end;
  except
    on E: Exception do
      ShowMessage(e.Message);
  end;
end;

procedure TfrmFilter.acDeleteExecute(Sender: TObject);
begin
  if mtFilter.RecordCount > 1 then
    mtFilter.Delete;
end;

function TfrmFilter.GetOriginalSQL: string;
begin
  with UniMainModule do begin
    mtSQLQueries.First;
    CheckError(mtSQLQueries.Locate('QueryName', FQuery.Name, [loCaseInsensitive]), 'Query not found in mtSQLQueries');
    Result := mtSQLQueries['SQL'];
  end;
end;

procedure TfrmFilter.btnApplyFilterClick(Sender: TObject);
var
  origSQL, Op, Val: string;
  Pnum: Integer;
begin
  try
    origSQL := GetOriginalSQL;
    FQuery.Close;
    FQuery.SQL.Text := origSQL;
    if not mtFilter.IsEmpty then
      FQuery.SQL.Text := origSQL + ' WHERE ' + BuildWhere;

    Pnum := 1;
    mtFilter.First;
    while not mtFilter.Eof do
    begin
      Val := VarToStrDef(mtFilter['Value'], '');
      Op  := VarToStrDef(mtFilter['Operator'], '');
      CheckError(Val <> '', 'Value is Empty');
      if Op = 'contains' then
        FQuery.ParamByName('P' + IntToStr(Pnum)).AsString := '%' + Val + '%'
      else if Op = 'startswith' then
        FQuery.ParamByName('P' + IntToStr(Pnum)).AsString :=  Val + '%'
      else if Op = 'endswith' then
        FQuery.ParamByName('P' + IntToStr(Pnum)).AsString := '%' + Val;
      Inc(Pnum);
      mtFilter.Next;
    end;
    FQuery.Open;
    ModalResult := mrOk;
  except
    on E: Exception do
      ShowMessage(e.Message);
  end;

end;

procedure TfrmFilter.btnClearFilterClick(Sender: TObject);
begin
  FQuery.Close;
  FQuery.SQL.Text := GetOriginalSQL;
  FQuery.Open;
  mtFilter.Last;
  while mtFilter.RecordCount <> 1 do
    mtFilter.Delete;
  ModalResult := mrCancel;
end;

end.
