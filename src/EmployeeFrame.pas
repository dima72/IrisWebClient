unit EmployeeFrame;

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
  uniGUIClasses, uniGUIFrame, uniDBNavigator, uniGUIBaseClasses, uniToolBar,
  uniBasicGrid, uniDBGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uniDateTimePicker, uniDBDateTimePicker, uniPanel, uniWidgets, NavigatorFrame,
  uniMultiItem, uniComboBox, uniDBComboBox, uniDBLookupComboBox;

type
  TEmployeeFrme = class(TUniFrame)
    grdMain: TUniDBGrid;
    dsrMain: TDataSource;
    ctlHiddenPanelCalendar: TUniHiddenPanel;
    ctlDateTimePicker: TUniDateTimePicker;
    ctlHiddenPanelSpouse: TUniHiddenPanel;
    ctlUniButtonWidget: TUniButtonWidget;
    Navigator: TNavigatorFrme;
    ctlHiddenPanelUSState: TUniHiddenPanel;
    cbUSState: TUniDBLookupComboBox;
    dsrStates: TDataSource;
    ctlHiddenPanelUSState2: TUniHiddenPanel;
    cbUSState2: TUniDBLookupComboBox;
    procedure ctlUniButtonWidgetClick(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses MainModule, PersonDictForm;

procedure TEmployeeFrme.ctlUniButtonWidgetClick(Sender: TObject);
begin
  PersonDictFrm.TargetDataSet := UniMainModule.qryEmployee;
  PersonDictFrm.ShowModal();
end;

procedure TEmployeeFrme.UniFrameCreate(Sender: TObject);
begin
  Navigator.FilterFieldsList.Add('Name');
  Navigator.FilterFieldsList.Add('Spouse->Name');
  Navigator.FilterFieldsList.Add('Company->Name');
  Navigator.FilterFieldsList.Add('Home_City');
  Navigator.FilterFieldsList.Add('Home_State');
  Navigator.FilterFieldsList.Add('Home_Street');
  Navigator.FilterFieldsList.Add('Home_Zip');
  Navigator.FilterFieldsList.Add('Office_City');
  Navigator.FilterFieldsList.Add('Office_Street');
  Navigator.FilterFieldsList.Add('Office_State');
  Navigator.FilterFieldsList.Add('Office_Zip');
end;

initialization;

  TModuleRegistry.RegisterModule('Employee', 1, TEmployeeFrme, 'qryEmployee');

end.
