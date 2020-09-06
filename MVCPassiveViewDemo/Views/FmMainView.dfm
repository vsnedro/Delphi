object Fm_MainView: TFm_MainView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Temperature Converter'
  ClientHeight = 309
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Lbl_C: TLabel
    Left = 231
    Top = 120
    Width = 11
    Height = 13
    Caption = 'C:'
  end
  object Lbl_F: TLabel
    Left = 231
    Top = 147
    Width = 10
    Height = 13
    Caption = 'F:'
  end
  object TEdt_C: TEdit
    Left = 248
    Top = 117
    Width = 121
    Height = 21
    MaxLength = 10
    TabOrder = 0
  end
  object TEdt_F: TEdit
    Left = 248
    Top = 144
    Width = 121
    Height = 21
    MaxLength = 10
    TabOrder = 2
  end
  object Btn_CtoF: TButton
    Left = 375
    Top = 115
    Width = 75
    Height = 25
    Caption = 'C -> F'
    TabOrder = 1
  end
  object Btn_FtoC: TButton
    Left = 375
    Top = 142
    Width = 75
    Height = 25
    Caption = 'F -> C'
    TabOrder = 3
  end
end
