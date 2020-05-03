object FormatF: TFormatF
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = #54028#51068' '#54805#49885' '#51648#51221
  ClientHeight = 214
  ClientWidth = 241
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dxLayoutControl1: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 241
    Height = 214
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 48
    ExplicitTop = 136
    ExplicitWidth = 300
    ExplicitHeight = 250
    object cxRadioGroup1: TcxRadioGroup
      Left = 10
      Top = 10
      Caption = #54028#51068' '#54805#49885' '#51648#51221
      Properties.Items = <
        item
          Caption = 'CSV'
        end
        item
          Caption = 'SQL'
        end>
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      TabOrder = 0
      Height = 105
      Width = 185
    end
    object cxButton1: TcxButton
      Left = 10
      Top = 179
      Width = 75
      Height = 25
      Caption = #54869#51064
      TabOrder = 1
      OnClick = cxButton1Click
    end
    object cxButton2: TcxButton
      Left = 124
      Top = 179
      Width = 75
      Height = 25
      Caption = #52712#49548
      TabOrder = 2
      OnClick = cxButton2Click
    end
    object dxLayoutControl1Group_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItem1: TdxLayoutItem
      Parent = dxLayoutControl1Group_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Visible = False
      Control = cxRadioGroup1
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItem2: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = cxButton1
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItem3: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'cxButton2'
      CaptionOptions.Visible = False
      Control = cxButton2
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
  end
end
