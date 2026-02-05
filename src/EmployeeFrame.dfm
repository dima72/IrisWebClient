object EmployeeFrme: TEmployeeFrme
  Left = 0
  Top = 0
  Width = 1105
  Height = 515
  OnCreate = UniFrameCreate
  TabOrder = 0
  object grdMain: TUniDBGrid
    Left = 0
    Top = 43
    Width = 1105
    Height = 472
    Hint = ''
    DataSource = dsrMain
    LoadMask.Message = 'Loading data...'
    Align = alClient
    TabOrder = 0
    Columns = <
      item
        FieldName = 'ID'
        Title.Caption = 'ID'
        Width = 46
        ReadOnly = True
      end
      item
        FieldName = 'Name'
        Title.Caption = 'Name'
        Width = 138
      end
      item
        WidgetColumn.Enabled = True
        WidgetColumn.Widget = ctlUniButtonWidget
        FieldName = 'SpouseName'
        Title.Caption = 'SpouseName'
        Width = 147
        ReadOnly = True
      end
      item
        FieldName = 'Age'
        Title.Caption = 'Age'
        Width = 64
      end
      item
        FieldName = 'CompanyName'
        Title.Caption = 'CompanyName'
        Width = 154
      end
      item
        FieldName = 'DOB'
        Title.Caption = 'DOB'
        Width = 64
        Editor = ctlDateTimePicker
      end
      item
        FieldName = 'SSN'
        Title.Caption = 'SSN'
        Width = 107
      end
      item
        FieldName = 'Salary'
        Title.Caption = 'Salary'
        Width = 64
      end
      item
        FieldName = 'Title'
        Title.Caption = 'Title'
        Width = 122
      end
      item
        FieldName = 'Home_City'
        Title.Caption = 'Home_City'
        Width = 99
      end
      item
        FieldName = 'Home_State'
        Title.Caption = 'Home_State'
        Width = 68
        Editor = cbUSState
      end
      item
        FieldName = 'Home_Street'
        Title.Caption = 'Home_Street'
        Width = 153
      end
      item
        FieldName = 'Home_Zip'
        Title.Caption = 'Home_Zip'
        Width = 59
      end
      item
        FieldName = 'Office_City'
        Title.Caption = 'Office_City'
        Width = 102
      end
      item
        FieldName = 'Office_State'
        Title.Caption = 'Office_State'
        Width = 67
        Editor = cbUSState2
      end
      item
        FieldName = 'Office_Street'
        Title.Caption = 'Office_Street'
        Width = 134
      end
      item
        FieldName = 'Office_Zip'
        Title.Caption = 'Office_Zip'
        Width = 58
      end>
  end
  object ctlHiddenPanelCalendar: TUniHiddenPanel
    Left = 680
    Top = 104
    Width = 193
    Height = 201
    Hint = ''
    Visible = True
    object ctlDateTimePicker: TUniDateTimePicker
      Left = 48
      Top = 32
      Width = 120
      Hint = ''
      DateTime = 45176.000000000000000000
      DateFormat = 'dd/MM/yyyy'
      TimeFormat = 'HH:mm:ss'
      TabOrder = 1
    end
  end
  object ctlHiddenPanelSpouse: TUniHiddenPanel
    Left = 423
    Top = 104
    Width = 177
    Height = 201
    Hint = ''
    Visible = True
    object ctlUniButtonWidget: TUniButtonWidget
      Left = 32
      Top = 32
      Width = 120
      Hint = ''
      ImageIndex = 0
      OnClick = ctlUniButtonWidgetClick
      Caption = 'Spouse'
    end
  end
  inline Navigator: TNavigatorFrme
    Left = 0
    Top = 0
    Width = 1105
    Height = 43
    Align = alTop
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    Background.Picture.Data = {00}
    ExplicitWidth = 1105
    inherited UniToolBar1: TUniToolBar
      Width = 1105
      ExplicitWidth = 1105
      inherited ctlUniDBNavigator: TUniDBNavigator
        DataSource = dsrMain
      end
    end
  end
  object ctlHiddenPanelUSState: TUniHiddenPanel
    Left = 160
    Top = 104
    Width = 193
    Height = 124
    Hint = ''
    Visible = True
    object cbUSState: TUniDBLookupComboBox
      Left = 16
      Top = 28
      Width = 145
      Hint = ''
      ListField = 'State; Capital'
      ListSource = dsrStates
      KeyField = 'State'
      ListFieldIndex = 0
      DataField = 'Home_State'
      DataSource = dsrMain
      AnyMatch = True
      TabOrder = 1
      Color = clWhite
      MatchFieldWidth = False
    end
  end
  object ctlHiddenPanelUSState2: TUniHiddenPanel
    Left = 160
    Top = 263
    Width = 193
    Height = 124
    Hint = ''
    Visible = True
    object cbUSState2: TUniDBLookupComboBox
      Left = 16
      Top = 28
      Width = 145
      Hint = ''
      ListField = 'State; Capital'
      ListSource = dsrStates
      KeyField = 'State'
      ListFieldIndex = 0
      DataField = 'Office_State'
      DataSource = dsrMain
      AnyMatch = True
      TabOrder = 1
      Color = clWhite
      MatchFieldWidth = False
    end
  end
  object dsrMain: TDataSource
    DataSet = UniMainModule.qryEmployee
    Left = 32
    Top = 56
  end
  object dsrStates: TDataSource
    DataSet = UniMainModule.mtStates
    Left = 104
    Top = 56
  end
end
