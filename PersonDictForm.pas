unit PersonDictForm;

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
  uniGUIClasses, uniGUIForm, uniButton, uniGUIBaseClasses, uniFieldSet,
  uniDBEdit, uniEdit, uniBasicGrid, uniDBGrid, uniPanel, Data.DB, uniToolBar,
  uniGUIFrame, NavigatorFrame;

type
  TPersonDictFrm = class(TUniForm)
    grdMain: TUniDBGrid;
    DataSource1: TDataSource;
    UniPanel1: TUniPanel;
    UniButton2: TUniButton;
    UniButton1: TUniButton;
    Navigator: TNavigatorFrme;
    procedure UniButton1Click(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormReady(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FTargetDataSet: TDataSet;
  public
    { Public declarations }
    property TargetDataSet: TDataSet read FTargetDataSet write FTargetDataSet;
  end;

function PersonDictFrm: TPersonDictFrm;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function PersonDictFrm: TPersonDictFrm;
begin
  Result := TPersonDictFrm(UniMainModule.GetFormInstance(TPersonDictFrm));
end;

procedure TPersonDictFrm.UniButton1Click(Sender: TObject);
begin
  MessageDlg('Assign the Spouse?', mtConfirmation, [mbYes, mbNo],
  procedure(Sender: TComponent; Res: Integer)
    begin
      // Callback: handle the user's choice
      case Res of
        mrYes: begin
          with UniMainModule do begin
            FTargetDataSet.Edit;
            FTargetDataSet['Spouse'] := qryPersonDict['ID'];
            FTargetDataSet.Post;
            FTargetDataSet.Refresh;
            Self.ModalResult := mrOK;
          end;
        end;
      end;
    end
  );
end;

procedure TPersonDictFrm.UniFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  UniMainModule.qryPersonDict.Close;
end;

procedure TPersonDictFrm.UniFormCreate(Sender: TObject);
begin
  Navigator.FilterFieldsList.Add('Name');
  Navigator.FilterFieldsList.Add('Spouse->Name');
  Navigator.FilterFieldsList.Add('Home_City');
end;

procedure TPersonDictFrm.UniFormReady(Sender: TObject);
begin
  with UniMainModule do begin
    if not qryPersonDict.Active then
      qryPersonDict.Open;
  end;
end;

end.
