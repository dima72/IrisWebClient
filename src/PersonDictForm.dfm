object PersonDictFrm: TPersonDictFrm
  Left = 0
  Top = 0
  ClientHeight = 421
  ClientWidth = 712
  Caption = 'Spouse'
  BorderStyle = bsDialog
  OldCreateOrder = False
  OnClose = UniFormClose
  BorderIcons = []
  MonitoredKeys.Keys = <>
  OnReady = UniFormReady
  OnCreate = UniFormCreate
  TextHeight = 15
  object grdMain: TUniDBGrid
    Left = 0
    Top = 43
    Width = 712
    Height = 333
    Hint = ''
    DataSource = dsrMain
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgAutoRefreshRow]
    LoadMask.Message = 'Loading data...'
    Align = alClient
    TabOrder = 0
    Columns = <
      item
        FieldName = 'ID'
        Title.Caption = 'ID'
        Width = 89
        ReadOnly = True
      end
      item
        FieldName = 'Name'
        Title.Caption = 'Name'
        Width = 150
      end
      item
        FieldName = 'DOB'
        Title.Caption = 'DOB'
        Width = 70
      end
      item
        FieldName = 'SSN'
        Title.Caption = 'SSN'
        Width = 152
      end
      item
        FieldName = 'Home_City'
        Title.Caption = 'Home_City'
        Width = 484
      end>
  end
  object UniPanel1: TUniPanel
    Left = 0
    Top = 376
    Width = 712
    Height = 45
    Hint = ''
    Align = alBottom
    TabOrder = 1
    Caption = ''
    DesignSize = (
      712
      45)
    object btnCancel: TUniButton
      Left = 17
      Top = 11
      Width = 75
      Height = 25
      Hint = ''
      Caption = 'Cancel'
      ModalResult = 2
      Anchors = [akLeft, akBottom]
      TabOrder = 1
    end
    object btnOK: TUniButton
      Left = 618
      Top = 6
      Width = 75
      Height = 25
      Hint = ''
      Caption = 'OK'
      Anchors = [akRight, akBottom]
      TabOrder = 2
      OnClick = btnOKClick
    end
  end
  inline Navigator: TNavigatorFrme
    Left = 0
    Top = 0
    Width = 712
    Height = 43
    Align = alTop
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    Background.Picture.Data = {00}
    ExplicitWidth = 712
    inherited UniToolBar1: TUniToolBar
      Width = 712
      ShowHint = True
      ParentShowHint = False
      ExplicitWidth = 712
      inherited btnFilter: TUniToolButton
        Transparency = toNone
        Caption = 'Filter'
      end
      inherited ctlUniDBNavigator: TUniDBNavigator
        ShowHint = True
        DataSource = dsrMain
      end
    end
  end
  object dsrMain: TDataSource
    DataSet = UniMainModule.qryPersonDict
    Left = 56
    Top = 40
  end
end
