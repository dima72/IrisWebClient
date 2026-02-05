unit CompanyFrame;

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
  uniGUIClasses, uniGUIFrame, uniDBNavigator, uniGUIBaseClasses, uniToolBar,
  Data.DB, uniDateTimePicker, uniPanel, uniBasicGrid, uniDBGrid, PersonFrame,
  uniMemo, uniDBMemo, uniSplitter, NavigatorFrame;

type
  TCompanyFrme = class(TUniFrame)
    dsrMain: TDataSource;
    grdMain: TUniDBGrid;
    UniSplitter1: TUniSplitter;
    UniDBMemo1: TUniDBMemo;
    Navigator: TNavigatorFrme;
    procedure UniFrameCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses MainModule, ModuleRegistry;

procedure TCompanyFrme.UniFrameCreate(Sender: TObject);
begin
  Navigator.FilterFieldsList.Add('Name');
  Navigator.FilterFieldsList.Add('Revenue');
  Navigator.FilterFieldsList.Add('TaxID');
end;

initialization

  TModuleRegistry.RegisterModule('Company', 2, TCompanyFrme, 'qryCompany');


end.
