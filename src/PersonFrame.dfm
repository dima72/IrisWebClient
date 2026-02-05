object PersonFrme: TPersonFrme
  Left = 0
  Top = 0
  Width = 1116
  Height = 488
  OnCreate = UniFrameCreate
  TabOrder = 0
  object grdMain: TUniDBGrid
    Left = 0
    Top = 43
    Width = 1116
    Height = 445
    Hint = ''
    ClientEvents.ExtEvents.Strings = (
      
        'afterrender=function afterrender(sender, eOpts)'#13#10'{'#13#10'  sender.get' +
        'El().on('#39'contextmenu'#39', function(e){ e.preventDefault(); '#13#10'  });'#13 +
        #10'}')
    DataSource = dsrMain
    LoadMask.Message = 'Loading data...'
    Align = alClient
    TabOrder = 0
    Columns = <
      item
        FieldName = 'ID'
        Title.Caption = 'ID'
        Width = 32
        ReadOnly = True
      end
      item
        FieldName = 'Name'
        Title.Caption = 'Name'
        Width = 136
      end
      item
        WidgetColumn.Enabled = True
        WidgetColumn.Widget = ctlSpouseWidget
        FieldName = 'SpouseName'
        Title.Caption = 'SpouseName'
        Width = 130
        ReadOnly = True
      end
      item
        FieldName = 'Age'
        Title.Caption = 'Age'
        Width = 64
      end
      item
        FieldName = 'DOB'
        Title.Caption = 'DOB'
        Width = 64
        Editor = UniDateTimePicker2
      end
      item
        FieldName = 'SSN'
        Title.Caption = 'SSN'
        Width = 68
      end
      item
        FieldName = 'Home_City'
        Title.Caption = 'Home_City'
        Width = 87
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
        Width = 152
      end
      item
        FieldName = 'Home_Zip'
        Title.Caption = 'Home_Zip'
        Width = 59
      end
      item
        FieldName = 'Office_City'
        Title.Caption = 'Office_City'
        Width = 103
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
  object ctlHiddenPanelCaledar: TUniHiddenPanel
    Left = 152
    Top = 141
    Width = 193
    Height = 201
    Hint = ''
    Visible = True
    object UniDateTimePicker2: TUniDateTimePicker
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
    Left = 390
    Top = 141
    Width = 177
    Height = 201
    Hint = ''
    Visible = True
    object ctlSpouseWidget: TUniButtonWidget
      Left = 32
      Top = 32
      Width = 120
      Hint = ''
      ImageIndex = 0
      OnClick = ctlSpouseWidgetClick
      Caption = 'ctlSpouseWidget'
    end
  end
  inline Navigator: TNavigatorFrme
    Left = 0
    Top = 0
    Width = 1116
    Height = 43
    Align = alTop
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    Background.Picture.Data = {00}
    ExplicitWidth = 1116
    inherited UniToolBar1: TUniToolBar
      Width = 1116
      ExplicitWidth = 1116
      inherited ctlUniDBNavigator: TUniDBNavigator
        DataSource = dsrMain
      end
    end
  end
  object ctlHiddenPanelUSState: TUniHiddenPanel
    Left = 848
    Top = 141
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
      DataField = 'Office_State'
      DataSource = dsrMain
      AnyMatch = True
      TabOrder = 1
      Color = clWhite
      MatchFieldWidth = False
    end
  end
  object ctlHiddenPanelUSState2: TUniHiddenPanel
    Left = 614
    Top = 141
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
    DataSet = UniMainModule.qryPerson
    Left = 40
    Top = 56
  end
  object UniImageListAdapter1: TUniImageListAdapter
    Left = 40
    Top = 128
  end
  object dsrStates: TDataSource
    DataSet = UniMainModule.mtStates
    Left = 112
    Top = 56
  end
end
