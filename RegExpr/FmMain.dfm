object Fm_Main: TFm_Main
  Left = 0
  Top = 0
  Caption = 'RegExpr Testing'
  ClientHeight = 411
  ClientWidth = 684
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
  object Spl_1: TSplitter
    Left = 0
    Top = 258
    Width = 684
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = 3
    ExplicitTop = 4
    ExplicitWidth = 580
  end
  object GBox_RegExp: TGroupBox
    Left = 0
    Top = 0
    Width = 684
    Height = 42
    Align = alTop
    Caption = 'Regular expression'
    TabOrder = 0
    object TEdt_RegExp: TEdit
      AlignWithMargins = True
      Left = 5
      Top = 17
      Width = 574
      Height = 21
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alClient
      MaxLength = 1000
      TabOrder = 0
    end
    object Btn_Check: TButton
      Left = 582
      Top = 15
      Width = 100
      Height = 25
      Action = Act_CheckRegExp
      Align = alRight
      Caption = 'Check'
      TabOrder = 1
      ExplicitLeft = 585
      ExplicitTop = 14
    end
  end
  object GBox_Text: TGroupBox
    Left = 0
    Top = 82
    Width = 684
    Height = 176
    Align = alClient
    Caption = 'Text'
    TabOrder = 2
    ExplicitHeight = 162
    object Mem_Text: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 674
      Height = 153
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitHeight = 139
    end
  end
  object GBox_Result: TGroupBox
    Left = 0
    Top = 261
    Width = 684
    Height = 150
    Align = alBottom
    Caption = 'Result'
    TabOrder = 3
    ExplicitTop = 247
    object Mem_Result: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 674
      Height = 127
      Align = alClient
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object GBox_Options: TGroupBox
    Left = 0
    Top = 42
    Width = 684
    Height = 40
    Align = alTop
    Caption = 'Options'
    TabOrder = 1
    object ChBox_IgnoreCase: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 15
      Width = 100
      Height = 23
      Hint = 'Specifies case-insensitive matching.'
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'IgnoreCase'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object ChBox_MultiLine: TCheckBox
      Left = 105
      Top = 15
      Width = 100
      Height = 23
      Hint = 
        'Multiline mode. Changes the meaning of ^ and $ so they match at ' +
        'the beginning and end, respectively, of any line, and not just t' +
        'he beginning and end of the entire string.'
      Align = alLeft
      Caption = 'MultiLine'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object ChBox_ExplicitCapture: TCheckBox
      Left = 205
      Top = 15
      Width = 100
      Height = 23
      Hint = 
        'Specifies that the only valid captures are explicitly named or n' +
        'umbered groups of the form (?<name>'#8230'). This allows unnamed paren' +
        'theses to act as noncapturing groups without the syntactic clums' +
        'iness of the expression (?:'#8230').'
      Align = alLeft
      Caption = 'ExplicitCapture'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object ChBox_Compiled: TCheckBox
      Left = 305
      Top = 15
      Width = 100
      Height = 23
      Hint = 
        'Specifies that the regular expression is compiled to an assembly' +
        '. This yields faster execution but increases startup time. This ' +
        'value should not be assigned to the Options property when callin' +
        'g the CompileToAssembly method.'
      Align = alLeft
      Caption = 'Compiled'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object ChBox_SingleLine: TCheckBox
      Left = 405
      Top = 15
      Width = 100
      Height = 23
      Hint = 
        'Specifies single-line mode. Changes the meaning of the dot (.) s' +
        'o it matches every character (instead of every character except ' +
        '\n).'
      Align = alLeft
      Caption = 'SingleLine'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object ChBox_IgnorePatternSpace: TCheckBox
      Left = 505
      Top = 15
      Width = 120
      Height = 23
      Hint = 
        'Eliminates unescaped white space from the pattern and enables co' +
        'mments marked with #. However, the IgnorePatternWhitespace value' +
        ' does not affect or eliminate white space in character classes.'
      Align = alLeft
      Caption = 'IgnorePatternSpace'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
  end
  object AL_1: TActionList
    Left = 152
    object Act_CheckRegExp: TAction
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
      Hint = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1088#1077#1075#1091#1083#1103#1088#1085#1086#1077' '#1074#1099#1088#1072#1078#1077#1085#1080#1077
      OnExecute = Act_CheckRegExpExecute
    end
  end
end
