unit NavigatorFrame;

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
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniToolBar, uniDBNavigator, uniGUIBaseClasses,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.StorageBin, uFilterDialog;

type
  TNavigatorFrme = class(TUniFrame)
    UniToolBar1: TUniToolBar;
    ctlUniDBNavigator: TUniDBNavigator;
    btnFilter: TUniToolButton;
    procedure btnFilterClick(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject);
    procedure UniFrameReady(Sender: TObject);
  private
    { Private declarations }
    FFilterFieldsList: TStringList;
    FfrmFilter: TfrmFilter;
  public
    { Public declarations }
    property FilterFieldsList: TStringList read FFilterFieldsList;
  end;

implementation

{$R *.dfm}

uses MainModule;

procedure TNavigatorFrme.btnFilterClick(Sender: TObject);
begin
  if FFilterFieldsList.Count = 0 then Exit;
  CheckError(Assigned(ctlUniDBNavigator.DataSource) and
    Assigned(ctlUniDBNavigator.DataSource.DataSet), 'Navigator''s Dataset is not assigned');
  if not Assigned(FfrmFilter) then
    FfrmFilter := TfrmFilter.Create(UniApplication, ctlUniDBNavigator.DataSource.DataSet as TFDQuery, FFilterFieldsList);
  FfrmFilter.ShowModal;
end;

procedure TNavigatorFrme.UniFrameCreate(Sender: TObject);
begin
  FFilterFieldsList := TStringList.Create;
  FfrmFilter := nil;
end;

procedure TNavigatorFrme.UniFrameDestroy(Sender: TObject);
begin
  FFilterFieldsList.Free;
  FfrmFilter.Free;
end;

procedure TNavigatorFrme.UniFrameReady(Sender: TObject);
begin
  btnFilter.Enabled := FFilterFieldsList.Count > 0;
end;

end.
