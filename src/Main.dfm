object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 648
  ClientWidth = 976
  Caption = 'InterSystems Full Stack Contest 2026'
  OldCreateOrder = False
  Menu = mnuMain
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  TextHeight = 15
  object WorkArea: TUniContainerPanel
    Left = 175
    Top = 0
    Width = 801
    Height = 648
    Hint = ''
    ParentColor = False
    Align = alClient
    TabOrder = 0
    object UniHTMLFrame1: TUniHTMLFrame
      Left = 96
      Top = 40
      Width = 585
      Height = 321
      Hint = ''
    end
  end
  object UniTreeMenu1: TUniTreeMenu
    Left = 0
    Top = 0
    Width = 169
    Height = 648
    Hint = ''
    Items.NodeData = {
      07010000000A5400580054007200650065004E006F00640065001F0000000000
      000000000000FFFFFFFFFFFFFFFF000000000000000000000000000100}
    Items.FontData = {0101000000FFFFFFFF00000000}
    Images = ilMenu
    Color = clBtnFace
    OnClick = UniTreeMenu1Click
  end
  object UniSplitter1: TUniSplitter
    Left = 169
    Top = 0
    Width = 6
    Height = 648
    Hint = ''
    Align = alLeft
    ParentColor = False
    Color = clBtnFace
  end
  object mnuMain: TUniMainMenu
    Left = 152
    Top = 32
    object File1: TUniMenuItem
      Caption = 'File'
      object Exit1: TUniMenuItem
        Action = acExit
      end
    end
  end
  object alMain: TUniActionList
    Left = 56
    Top = 32
    object acPersonDict: TAction
      Caption = 'Person'
    end
    object acExit: TAction
      Caption = 'Exit'
      OnExecute = acExitExecute
    end
  end
  object ilMenu: TUniNativeImageList
    UseGlobalCache = False
    Left = 56
    Top = 104
    Images = {
      03000000FFFFFF1F0609000000757365723B6661733BFFFFFF1F060800000073
      7461723B66613BFFFFFF1F060E0000006C696E652D63686172743B66613B}
  end
end
