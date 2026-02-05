object NavigatorFrme: TNavigatorFrme
  Left = 0
  Top = 0
  Width = 640
  Height = 43
  OnCreate = UniFrameCreate
  OnDestroy = UniFrameDestroy
  OnReady = UniFrameReady
  TabOrder = 0
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 640
    Height = 42
    Hint = ''
    Images = UniMainModule.ilImages
    TabOrder = 0
    ParentColor = False
    Color = clBtnFace
    object btnFilter: TUniToolButton
      Left = 390
      Top = 0
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Constraints.MinHeight = 42
      Constraints.MinWidth = 42
      ImageIndex = 0
      Transparency = toFuchsia
      Caption = 'btnFilter'
      IconAlign = iaCenter
      Scale = bbsLarge
      TabOrder = 2
      OnClick = btnFilterClick
    end
    object ctlUniDBNavigator: TUniDBNavigator
      Left = 0
      Top = 0
      Width = 390
      Height = 42
      Hint = ''
      Align = alLeft
      TabOrder = 1
    end
  end
end
