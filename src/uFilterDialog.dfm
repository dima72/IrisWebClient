object frmFilter: TfrmFilter
  Left = 0
  Top = 0
  ClientHeight = 265
  ClientWidth = 476
  Caption = 'Filter Builder'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  FreeOnClose = False
  Layout = 'fit'
  TextHeight = 15
  object gridFilter: TUniDBGrid
    Left = 0
    Top = 42
    Width = 476
    Height = 178
    Hint = ''
    DataSource = dsFilter
    WebOptions.Paged = False
    LoadMask.Message = 'Loading data...'
    Align = alClient
    TabOrder = 0
    Columns = <
      item
        FieldName = 'FieldName'
        Title.Caption = 'FieldName'
        Width = 102
        Editor = UniDBLookupComboBox2
      end
      item
        FieldName = 'Operator'
        Title.Caption = 'Operator'
        Width = 124
        PickList.Strings = (
          'contains'
          'startswith'
          'endswith')
      end
      item
        FieldName = 'Value'
        Title.Caption = 'Value'
        Width = 113
      end
      item
        FieldName = 'Logic'
        Title.Caption = 'Logic'
        Width = 78
        PickList.Strings = (
          'AND'
          'OR')
      end>
  end
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 476
    Height = 42
    Hint = ''
    Images = UniMainModule.ilImages
    TabOrder = 1
    ParentColor = False
    Color = clBtnFace
    object btnAdd: TUniToolButton
      Left = 0
      Top = 0
      Constraints.MinHeight = 42
      Constraints.MinWidth = 42
      Action = acAdd
      ImageIndex = 1
      TabOrder = 1
    end
    object UniToolButton1: TUniToolButton
      Left = 42
      Top = 0
      Constraints.MinHeight = 42
      Constraints.MinWidth = 42
      Action = acDelete
      ImageIndex = 2
      TabOrder = 2
    end
  end
  object UniPanel1: TUniPanel
    Left = 0
    Top = 220
    Width = 476
    Height = 45
    Hint = ''
    Align = alBottom
    TabOrder = 2
    Caption = ''
    ExplicitTop = 205
    DesignSize = (
      476
      45)
    object UniButton2: TUniButton
      Left = 17
      Top = 11
      Width = 75
      Height = 25
      Hint = ''
      Caption = 'Cancel'
      ModalResult = 2
      Anchors = [akLeft, akTop, akBottom]
      TabOrder = 1
    end
    object btnApplyFilter: TUniButton
      Left = 373
      Top = 11
      Width = 79
      Height = 25
      Hint = ''
      Caption = 'Apply Filter'
      TabOrder = 2
      OnClick = btnApplyFilterClick
    end
    object btnClearFilter: TUniButton
      Left = 196
      Top = 11
      Width = 75
      Height = 25
      Hint = ''
      Caption = 'Clear Filter'
      Anchors = [akLeft, akTop, akBottom]
      TabOrder = 3
      OnClick = btnClearFilterClick
    end
  end
  object UniHiddenPanel1: TUniHiddenPanel
    Left = 259
    Top = 67
    Width = 193
    Height = 110
    Hint = ''
    Visible = True
    object UniDBLookupComboBox2: TUniDBLookupComboBox
      Left = 48
      Top = 27
      Width = 113
      Hint = ''
      ListField = 'FieldName'
      ListSource = dsrFieldNames
      KeyField = 'FieldName'
      ListFieldIndex = 0
      DataField = 'FieldName'
      DataSource = dsFilter
      TabOrder = 1
      Color = clWindow
      MatchFieldWidth = False
      ReadOnlyMode = urmNotEditable
    end
  end
  object mtFilter: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 56
    Top = 88
    object mtFilterFieldName: TStringField
      DisplayWidth = 31
      FieldName = 'FieldName'
      Size = 50
    end
    object mtFilterOperator: TStringField
      DisplayWidth = 20
      FieldName = 'Operator'
    end
    object mtFilterValue: TStringField
      DisplayWidth = 200
      FieldName = 'Value'
      Size = 200
    end
    object mtFilterLogic: TStringField
      DisplayWidth = 5
      FieldName = 'Logic'
      Size = 5
    end
  end
  object dsFilter: TDataSource
    DataSet = mtFilter
    Left = 152
    Top = 88
  end
  object mtFieldNames: TFDMemTable
    Active = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 160
    Top = 144
    Content = {
      4144425310000000F4000000FF00010001FF02FF030400180000006D00740046
      00690065006C0064004E0061006D00650073000500180000006D007400460069
      0065006C0064004E0061006D0065007300060000000000070000080032000000
      090000FF0AFF0B0400120000004600690065006C0064004E0061006D00650005
      00120000004600690065006C0064004E0061006D0065000C00010000000E000D
      000F003200000010000111000112000113000114000115000116001200000046
      00690065006C0064004E0061006D006500170032000000FEFEFF18FEFF19FEFF
      1AFEFEFEFF1BFEFF1C1D0004000000FF1EFEFEFE0E004D0061006E0061006700
      650072001E005500700064006100740065007300520065006700690073007400
      7200790012005400610062006C0065004C006900730074000A00540061006200
      6C00650008004E0061006D006500140053006F0075007200630065004E006100
      6D0065000A0054006100620049004400240045006E0066006F00720063006500
      43006F006E00730074007200610069006E00740073001E004D0069006E006900
      6D0075006D004300610070006100630069007400790018004300680065006300
      6B004E006F0074004E0075006C006C00140043006F006C0075006D006E004C00
      6900730074000C0043006F006C0075006D006E00100053006F00750072006300
      65004900440018006400740041006E007300690053007400720069006E006700
      1000440061007400610054007900700065000800530069007A00650014005300
      65006100720063006800610062006C006500120041006C006C006F0077004E00
      75006C006C000800420061007300650014004F0041006C006C006F0077004E00
      75006C006C0012004F0049006E0055007000640061007400650010004F004900
      6E00570068006500720065001A004F0072006900670069006E0043006F006C00
      4E0061006D006500140053006F007500720063006500530069007A0065001C00
      43006F006E00730074007200610069006E0074004C0069007300740010005600
      6900650077004C006900730074000E0052006F0077004C006900730074001800
      520065006C006100740069006F006E004C006900730074001C00550070006400
      61007400650073004A006F00750072006E0061006C0012005300610076006500
      50006F0069006E0074000E004300680061006E00670065007300}
    object mtFieldNamesFieldName: TStringField
      FieldName = 'FieldName'
      Size = 50
    end
  end
  object dsrFieldNames: TDataSource
    DataSet = mtFieldNames
    Left = 64
    Top = 152
  end
  object UniActionList1: TUniActionList
    Left = 224
    Top = 80
    object acAdd: TAction
      Caption = 'Add'
      OnExecute = acAddExecute
    end
    object acDelete: TAction
      Caption = 'Delete'
      OnExecute = acDeleteExecute
    end
  end
end
