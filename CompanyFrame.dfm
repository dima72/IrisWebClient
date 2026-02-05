object CompanyFrme: TCompanyFrme
  Left = 0
  Top = 0
  Width = 640
  Height = 480
  OnCreate = UniFrameCreate
  TabOrder = 0
  object grdMain: TUniDBGrid
    Left = 0
    Top = 43
    Width = 640
    Height = 375
    Hint = ''
    DataSource = dsrMain
    LoadMask.Message = 'Loading data...'
    Align = alClient
    TabOrder = 0
    Columns = <
      item
        FieldName = 'ID'
        Title.Caption = 'ID'
        Width = 51
        ReadOnly = True
      end
      item
        FieldName = 'Name'
        Title.Caption = 'Name'
        Width = 143
      end
      item
        FieldName = 'Revenue'
        Title.Caption = 'Revenue'
        Width = 89
      end
      item
        FieldName = 'TaxID'
        Title.Caption = 'TaxID'
        Width = 88
      end>
  end
  object UniSplitter1: TUniSplitter
    Left = 0
    Top = 418
    Width = 640
    Height = 6
    Cursor = crVSplit
    Hint = ''
    Align = alBottom
    ParentColor = False
    Color = clBtnFace
  end
  object UniDBMemo1: TUniDBMemo
    Left = 0
    Top = 424
    Width = 640
    Height = 56
    Hint = ''
    DataField = 'Mission'
    DataSource = dsrMain
    Align = alBottom
    TabOrder = 2
  end
  inline Navigator: TNavigatorFrme
    Left = 0
    Top = 0
    Width = 640
    Height = 43
    Align = alTop
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    Background.Picture.Data = {00}
    inherited UniToolBar1: TUniToolBar
      inherited ctlUniDBNavigator: TUniDBNavigator
        DataSource = dsrMain
      end
    end
  end
  object dsrMain: TDataSource
    DataSet = UniMainModule.qryCompany
    Left = 104
    Top = 56
  end
end
