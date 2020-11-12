object Fm_Main: TFm_Main
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Random Number Generator'
  ClientHeight = 201
  ClientWidth = 194
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_1: TPanel
    Left = 0
    Top = 0
    Width = 194
    Height = 201
    Align = alClient
    TabOrder = 0
    object Lbl_1: TLabel
      Left = 24
      Top = 32
      Width = 16
      Height = 13
      Caption = 'Min'
    end
    object Lbl_11: TLabel
      Left = 24
      Top = 59
      Width = 20
      Height = 13
      Caption = 'Max'
    end
    object Label1: TLabel
      Left = 24
      Top = 114
      Width = 30
      Height = 13
      Caption = 'Result'
    end
    object Lbl_Caption: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 186
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Random Number Generator'
      ExplicitWidth = 131
    end
    object TEdt_Min: TEdit
      Left = 56
      Top = 29
      Width = 113
      Height = 21
      MaxLength = 6
      NumbersOnly = True
      TabOrder = 0
      Text = '1'
    end
    object TEdt_Max: TEdit
      Left = 56
      Top = 56
      Width = 113
      Height = 21
      MaxLength = 6
      NumbersOnly = True
      TabOrder = 1
      Text = '100'
    end
    object Btn_Generate: TButton
      Left = 94
      Top = 83
      Width = 75
      Height = 25
      Caption = 'Generate'
      TabOrder = 2
      OnClick = Btn_GenerateClick
    end
    object TEdt_Result: TEdit
      Left = 24
      Top = 133
      Width = 145
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object Btn_Reset: TButton
      Left = 94
      Top = 160
      Width = 75
      Height = 25
      Caption = 'Reset'
      TabOrder = 4
      OnClick = Btn_ResetClick
    end
  end
end
