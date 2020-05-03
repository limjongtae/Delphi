object MainF: TMainF
  Left = 0
  Top = 0
  Caption = #45936#51060#53552' '#45236#48372#45236#44592
  ClientHeight = 797
  ClientWidth = 824
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dxLayoutControl1: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 824
    Height = 797
    Align = alClient
    TabOrder = 0
    object cxGrid1: TcxGrid
      Left = 10
      Top = 28
      Width = 250
      Height = 200
      TabOrder = 0
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = UniDataSource1
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.Indicator = True
        object cxGrid1DBTableView1RecId: TcxGridDBColumn
          DataBinding.FieldName = 'RecId'
          Visible = False
        end
        object cxGrid1DBTableView1Num: TcxGridDBColumn
          DataBinding.FieldName = 'Num'
        end
        object cxGrid1DBTableView1Name: TcxGridDBColumn
          DataBinding.FieldName = 'Name'
        end
        object cxGrid1DBTableView1InputTime: TcxGridDBColumn
          DataBinding.FieldName = 'InputTime'
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object cxMemo1: TcxMemo
      Left = 629
      Top = 28
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 1
      Height = 89
      Width = 185
    end
    object cxProgressBar1: TcxProgressBar
      Left = 48
      Top = 762
      Properties.AnimationPath = cxapPingPong
      Properties.BarStyle = cxbsAnimation
      Properties.BeginColor = 54056
      Properties.ShowTextStyle = cxtsPosition
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      TabOrder = 2
      Width = 121
    end
    object cxButton1: TcxButton
      Left = 739
      Top = 762
      Width = 75
      Height = 25
      Caption = #49892#54665
      TabOrder = 3
      OnClick = cxButton1Click
    end
    object dxLayoutControl1Group_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Visible = False
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItem1: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup2
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'cxGrid1'
      CaptionOptions.Layout = clTop
      Control = cxGrid1
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItem4: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup2
      AlignVert = avClient
      CaptionOptions.Text = 'cxMemo1'
      CaptionOptions.Layout = clTop
      Control = cxMemo1
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup
      Parent = dxLayoutControl1Group_Root
      AlignHorz = ahClient
      LayoutDirection = ldHorizontal
      Index = 1
      AutoCreated = True
    end
    object dxLayoutItem2: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = #51652#54665#47456
      Control = cxProgressBar1
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItem3: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      AlignVert = avClient
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = cxButton1
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutAutoCreatedGroup2: TdxLayoutAutoCreatedGroup
      Parent = dxLayoutControl1Group_Root
      AlignHorz = ahClient
      AlignVert = avClient
      LayoutDirection = ldHorizontal
      Index = 0
      AutoCreated = True
    end
  end
  object dxMemData1: TdxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    Left = 360
    Top = 8
    object dxMemData1Num: TAutoIncField
      FieldName = 'Num'
    end
    object dxMemData1Name: TStringField
      FieldName = 'Name'
    end
    object dxMemData1InputTime: TDateTimeField
      FieldName = 'InputTime'
    end
  end
  object UniDataSource1: TUniDataSource
    DataSet = dxMemData1
    Left = 368
    Top = 136
  end
  object SaveDialog1: TSaveDialog
    Filter = '.CSV|CSV|.SQL|SQL'
    Left = 544
    Top = 280
  end
  object VirtualTable1: TVirtualTable
    Options = [voPersistentData, voStored, voSkipUnSupportedFieldTypes]
    Active = True
    MasterSource = UniDataSource1
    Left = 128
    Top = 136
    Data = {03000000000000000000}
  end
end
