unit PersonFrame;

/// ---------------------------------------------------------------------------
///  RocketCitySoft IRIS Contest Module
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
  uniGUIClasses, uniGUIFrame, uniGUIBaseClasses, uniBasicGrid, uniDBGrid,
  Data.DB, uniDBNavigator, uniToolBar, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uniDateTimePicker, uniPanel, uniWidgets, Vcl.Menus,
  System.Actions, Vcl.ActnList, uniMainMenu, System.ImageList,
  uniImageList, NavigatorFrame, Vcl.ImgList, uniMultiItem, uniComboBox,
  uniDBComboBox, uniDBLookupComboBox;

type
  TPersonFrme = class(TUniFrame)
    grdMain: TUniDBGrid;
    dsrMain: TDataSource;
    UniHiddenPanel1: TUniHiddenPanel;
    UniDateTimePicker2: TUniDateTimePicker;
    UniHiddenPanel2: TUniHiddenPanel;
    UniButtonWidget1: TUniButtonWidget;
    UniImageListAdapter1: TUniImageListAdapter;
    Navigator: TNavigatorFrme;
    UniHiddenPanel4: TUniHiddenPanel;
    cbUSState: TUniDBLookupComboBox;
    UniHiddenPanel3: TUniHiddenPanel;
    cbUSState2: TUniDBLookupComboBox;
    dsrStates: TDataSource;
    procedure UniButtonWidget1Click(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses MainModule, ModuleRegistry, PersonDictForm;

procedure TPersonFrme.UniButtonWidget1Click(Sender: TObject);
begin
  with PersonDictFrm, UniMainModule do begin
    TargetDataSet := qryPerson;
    ShowModal();
  end;
end;

procedure TPersonFrme.UniFrameCreate(Sender: TObject);
begin
  Navigator.FilterFieldsList.Add('Name');
  Navigator.FilterFieldsList.Add('Spouse->Name');
  Navigator.FilterFieldsList.Add('Home_City');
  Navigator.FilterFieldsList.Add('Home_State');
  Navigator.FilterFieldsList.Add('Home_Street');
  Navigator.FilterFieldsList.Add('Home_Zip');
  Navigator.FilterFieldsList.Add('Office_City');
  Navigator.FilterFieldsList.Add('Office_Street');
  Navigator.FilterFieldsList.Add('Office_State');
  Navigator.FilterFieldsList.Add('Office_Zip');
end;

initialization
  TModuleRegistry.RegisterModule('Person', 0, TPersonFrme, 'qryPerson');

end.
