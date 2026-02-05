object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 648
  ClientWidth = 976
  Caption = 'InterSystems Full Stack Contest 2026'
  OnShow = UniFormShow
  OldCreateOrder = False
  Menu = UniMainMenu1
  MonitoredKeys.Keys = <>
  OnAfterShow = UniFormAfterShow
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
    Images = UniNativeImageList1
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
  object UniMainMenu1: TUniMainMenu
    Left = 200
    Top = 64
    object File1: TUniMenuItem
      Caption = 'File'
      object Exit1: TUniMenuItem
        Action = acExit
      end
    end
  end
  object UniActionList1: TUniActionList
    Left = 112
    Top = 64
    object acPersonDict: TAction
      Caption = 'Person'
    end
    object acExit: TAction
      Caption = 'Exit'
      OnExecute = acExitExecute
    end
  end
  object tmrOnShow: TUniTimer
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = tmrOnShowTimer
    Left = 487
    Top = 408
  end
  object UniNativeImageList1: TUniNativeImageList
    UseGlobalCache = False
    Left = 304
    Top = 192
    Images = {
      13000000FFFFFF1F0609000000757365723B6661733BFFFFFF1F060800000073
      7461723B66613BFFFFFF1F060E0000006C696E652D63686172743B66613BFFFF
      FF1F060C0000006E617669636F6E3B66615F3BFFFFFF1F060C0000006F726761
      6E697A653B66613BFFFFFF1F06090000007465616D3B66615F3BFFFFFF1F060B
      0000006465736B746F703B66613BFFFFFF1F060C000000656E76656C6F70653B
      66613BFFFFFF1F0608000000757365723B66613BFFFFFF1F061000000077696E
      646F772D636C6F73653B66613BFFFFFF1F0608000000736176653B66613BFFFF
      FF1F0608000000656469743B66613BFFFFFF1F06070000006375743B66613BFF
      FFFF1F060D0000006261722D63686172743B66613BFFFFFF1F060D0000007069
      652D63686172743B66613BFFFFFF1F060C000000626F6F6B6D61726B3B66613B
      FFFFFF1F060C00000063616C656E6461723B66613BFFFFFF1F06080000006665
      65643B66613BFFFFFF1F06070000006661783B66613B}
  end
end
