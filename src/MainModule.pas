unit MainModule;

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
  System.Generics.Collections, SysUtils, Classes, uniGUIApplication, UniGUIVars,
  UniGUIFrame, uniGUIMainModule, UniDBGrid, uniGUIBaseClasses, uniImageList,
  System.ImageList, Vcl.ImgList, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.ODBC,
  FireDAC.Phys.ODBCDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Stan.StorageBin, FireDAC.Comp.Client,
  Data.DB, FireDAC.Comp.DataSet;

type

  TModuleInfo = class
    Name: string;
    Icon: string;
    IconIndex: Integer;
    FrameClass: TUniFrameClass;
    MainQuery: string;
  end;

  TModuleRegistry = class
  private
    class var FList: TObjectList<TModuleInfo>;
  public
    class constructor Create;
    class destructor Destroy;
    class procedure RegisterModule(const AName: string; AIconIndex: Integer; AFrame: TUniFrameClass; AMainQueryName: string);
    class function GetModules: TObjectList<TModuleInfo>;
    class function FindModule(const AName: string): TModuleInfo;
  end;

  TUniMainModule = class(TUniGUIMainModule)
    FDConnection: TFDConnection;
    qryPerson: TFDQuery;
    qryEmployee: TFDQuery;
    qryCompany: TFDQuery;
    qryEmployeeID: TLargeintField;
    qryEmployeeAge: TIntegerField;
    qryEmployeeDOB: TDateField;
    qryEmployeeFavoriteColors: TStringField;
    qryEmployeeName: TStringField;
    qryEmployeeNotes: TMemoField;
    qryEmployeePicture: TBlobField;
    qryEmployeeSSN: TStringField;
    qryEmployeeSalary: TIntegerField;
    qryEmployeeSpouse: TLargeintField;
    qryEmployeeTitle: TStringField;
    qryEmployeeHome_City: TStringField;
    qryEmployeeHome_State: TStringField;
    qryEmployeeHome_Street: TStringField;
    qryEmployeeHome_Zip: TStringField;
    qryEmployeeOffice_City: TStringField;
    qryEmployeeOffice_State: TStringField;
    qryEmployeeOffice_Street: TStringField;
    qryEmployeeOffice_Zip: TStringField;
    qryEmployeeCompanyName: TStringField;
    qryEmployeeCompany: TLargeintField;
    qryEmployeeSpouseName: TStringField;
    qryPersonID: TLargeintField;
    qryPersonAge: TIntegerField;
    qryPersonDOB: TDateField;
    qryPersonFavoriteColors: TStringField;
    qryPersonName: TStringField;
    qryPersonSSN: TStringField;
    qryPersonSpouse: TLargeintField;
    qryPersonHome_City: TStringField;
    qryPersonHome_State: TStringField;
    qryPersonHome_Street: TStringField;
    qryPersonHome_Zip: TStringField;
    qryPersonOffice_City: TStringField;
    qryPersonOffice_State: TStringField;
    qryPersonOffice_Street: TStringField;
    qryPersonOffice_Zip: TStringField;
    qryPersonSpouseName: TStringField;
    qryPersonDict: TFDQuery;
    qryPersonDictID: TLargeintField;
    qryPersonDictName: TStringField;
    qryPersonDictDOB: TDateField;
    qryPersonDictSSN: TStringField;
    qryPersonDictHome_City: TStringField;
    qryCompanyID: TLargeintField;
    qryCompanyMission: TStringField;
    qryCompanyName: TStringField;
    qryCompanyRevenue: TIntegerField;
    qryCompanyTaxID: TStringField;
    ilImages: TUniImageList;
    mtSQLQueries: TFDMemTable;
    mtSQLQueriesQueryName: TStringField;
    mtSQLQueriesSQL: TStringField;
    mtStates: TFDMemTable;
    mtStatesState: TStringField;
    mtStatesCapital: TStringField;
    procedure UniGUIMainModuleCreate(Sender: TObject);
    procedure UniGUIMainModuleDestroy(Sender: TObject);
    procedure qryEmployeeBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FCache: TObjectDictionary<string, TUniFrame>;
  public
    { Public declarations }
    function GetFrame(const AName: string; AOwner: TComponent): TUniFrame;
  end;


function UniMainModule: TUniMainModule;
procedure CheckError(AYes: Boolean; const AMessage: string);

procedure ApplyFieldLabelsToGrid(Grid: TUniDBGrid);

implementation

{$R *.dfm}

uses
  ServerModule;

procedure CheckError(AYes: Boolean; const AMessage: string);
begin
  if not AYes then
    raise Exception.Create(AMessage);
end;

procedure ApplyFieldLabelsToGrid(Grid: TUniDBGrid);
var
  I: Integer;
  F: TField;
begin
  if not Assigned(Grid.DataSource) then Exit;
  if not Assigned(Grid.DataSource.DataSet) then Exit;

  for I := 0 to Grid.Columns.Count - 1 do
  begin
    F := Grid.DataSource.DataSet.FindField(Grid.Columns[I].FieldName);
    if Assigned(F) then
      Grid.Columns[I].Title.Caption := F.DisplayLabel;
  end;
end;


function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule)
end;

function TUniMainModule.GetFrame(const AName: string;
  AOwner: TComponent): TUniFrame;
var
  Module: TModuleInfo;
begin
  // Return cached instance if exists
  if FCache.TryGetValue(AName, Result) then
    Exit;

  // Look up module by name
  Module := TModuleRegistry.FindModule(AName);
  if Module = nil then
    raise Exception.Create('Unknown module: ' + AName);

  // Create frame dynamically from FrameClass
  Result := Module.FrameClass.Create(AOwner);

  // Cache it
  FCache.Add(AName, Result);
end;

procedure TUniMainModule.qryEmployeeBeforeOpen(DataSet: TDataSet);
begin
  // dependent dataset
  if not qryCompany.Active then
    qryCompany.Open;
end;

procedure TUniMainModule.UniGUIMainModuleCreate(Sender: TObject);
var
  I: Integer;
  Q: TFDQuery;
  RealIP, CID, IP, UA: string;
begin
  try
    {
      connection.ini format
      ----------------------
      DataSource=myCache
      User_Name=...
      Password=...
      ODBCDriver=InterSystems IRIS ODBC35
      Database=CLIENTAPP
      DriverID=ODBC
      ----------------------
    }
    FDConnection.Params.Assign(UniServerModule.TestConnection.Params);
    FDConnection.Connected := True;

    FCache := TObjectDictionary<string, TUniFrame>.Create();
    for I := 0 to ComponentCount - 1 do
      if Components[I] is TFDQuery then
      begin
        Q := TFDQuery(Components[I]);
        //mtSQLQueries is just an SQL text cache so we can use it in FIlterDialog
        if not mtSQLQueries.Locate('QueryName', Q.Name, [loCaseInsensitive]) then begin
          mtSQLQueries.Append;
          mtSQLQueries['QueryName'] := Q.Name;
          mtSQLQueries['SQL'] := Q.SQL.Text;
          mtSQLQueries.Post;
        end;
      end;

    // 1. Try to read existing cookie
    CID := UniSession.UniApplication.Cookies.GetCookie('ClientID');

    // 2. If cookie missing → create one
    if CID = '' then
    begin
      CID := TGUID.NewGuid.ToString;
      UniSession.UniApplication.Cookies.SetCookie('ClientID', CID, Now + 3650); // 10 years
    end;

    RealIP := UniSession.RequestHeader['X-Forwarded-For'];
    if RealIP = '' then
      RealIP := 'RemoteHost: ' + UniSession.RemoteHost + ' RemoteIP: ' + UniSession.RemoteIP; // fallback
    // 3. Log session start
    ClientTracker.LogSessionStart(CID, UniSession.SessionID, RealIP, UniSession.UserAgent);
  except
    on E: Exception do
      UniSession.Terminate(E.Message);
  end;
end;

procedure TUniMainModule.UniGUIMainModuleDestroy(Sender: TObject);
begin
  FCache.Free;
  FCache := nil;
end;

//-----------------------------TModuleRegistry------------------------------------

class constructor TModuleRegistry.Create;
begin
  FList := TObjectList<TModuleInfo>.Create;
end;

class destructor TModuleRegistry.Destroy;
begin
  FList.Free;
end;

class procedure TModuleRegistry.RegisterModule(const AName: string; AIconIndex: Integer; AFrame: TUniFrameClass; AMainQueryName: string);
var
  M: TModuleInfo;
begin
  M := TModuleInfo.Create;
  M.Name := AName;
  M.IconIndex := AIconIndex;
  M.FrameClass := AFrame;
  M.MainQuery := AMainQueryName;
  FList.Add(M);
end;

class function TModuleRegistry.GetModules: TObjectList<TModuleInfo>;
begin
  Result := FList;
end;

class function TModuleRegistry.FindModule(const AName: string): TModuleInfo;
var
  M: TModuleInfo;
begin
  Result := nil;

  for M in FList do
    if SameText(M.Name, AName) then
      Exit(M);
end;


initialization
  RegisterMainModuleClass(TUniMainModule);
end.
