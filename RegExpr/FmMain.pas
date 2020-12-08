unit FmMain;

interface

uses
  {VCL}
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  System.Actions,
  Vcl.ActnList,
  {RegExpr}
  System.RegularExpressionsConsts,
  System.RegularExpressionsAPI,
  System.RegularExpressionsCore,
  System.RegularExpressions,
  {App}
  Translator;

type
  TFm_Main = class(TForm)
    {$REGION ' Components '}
    GBox_RegExp: TGroupBox;
    TEdt_RegExp: TEdit;
    Btn_Check: TButton;
    GBox_Text: TGroupBox;
    Mem_Text: TMemo;
    GBox_Result: TGroupBox;
    Spl_1: TSplitter;
    GBox_Options: TGroupBox;
    AL_1: TActionList;
    Act_CheckRegExp: TAction;
    Mem_Result: TMemo;
    ChBox_IgnoreCase: TCheckBox;
    ChBox_MultiLine: TCheckBox;
    ChBox_ExplicitCapture: TCheckBox;
    ChBox_Compiled: TCheckBox;
    ChBox_SingleLine: TCheckBox;
    ChBox_IgnorePatternSpace: TCheckBox;
    {$ENDREGION}
    procedure FormCreate(Sender: TObject);
    /// <summary> Проверить регулярное выражение </summary>
    procedure Act_CheckRegExpExecute(Sender: TObject);
  private
    { Private declarations }
    var FMsgFoundMatch : String;
    var FMsgNoMatchesFound : String;
    var FMsgResultGroup : String;
  public
    { Public declarations }
    procedure Translate(
      ATranslator : ITranslator);
  end;

var
  Fm_Main: TFm_Main;

implementation

{$R *.dfm}

procedure TFm_Main.FormCreate(Sender: TObject);
begin
  inherited;

  FMsgFoundMatch     := 'Found a match';
  FMsgNoMatchesFound := 'No matches found';
  FMsgResultGroup    := 'Group %d: %s';
end;

/// <summary> Проверить регулярное выражение </summary>
procedure TFm_Main.Act_CheckRegExpExecute(Sender: TObject);
var
  E, T : String;
begin
  Mem_Result.Clear();

  E := TEdt_RegExp.Text;
  T := Mem_Text.Text;

  // set options
  // задаём опции
  var O : TRegExOptions := [];
  if ChBox_IgnoreCase.Checked then
    O := O + [roIgnoreCase];
  if ChBox_MultiLine.Checked then
    O := O + [roMultiLine];
  if ChBox_ExplicitCapture.Checked then
    O := O + [roExplicitCapture];
  if ChBox_Compiled.Checked then
    O := O + [roCompiled];
  if ChBox_SingleLine.Checked then
    O := O + [roSingleLine];
  if ChBox_IgnorePatternSpace.Checked then
    O := O + [roIgnorePatternSpace];

  if (E.Length > 0) then begin
    // create a regular expression
    // создаём регулярное выражение
    var R := TRegEx.Create(E, O);

    // if there is a match
    // если есть совпадение
    if R.IsMatch(T) then begin
      Mem_Result.Lines.Add(FMsgFoundMatch);

      var M := R.Matches(T);
      for var i := 0 to M.Count - 1 do begin
        Mem_Result.Lines.Add(M[i].Value);
        // if there are groups
        // если есть группы
        for var j := 0 to M[i].Groups.Count - 1 do
          Mem_Result.Lines.Add(Format(
            '  - ' + FMsgResultGroup, [j, M[i].Groups[j].Value]));
      end;
    end
    else
      Mem_Result.Lines.Add(FMsgNoMatchesFound);
  end;
end;

procedure TFm_Main.Translate(
  ATranslator : ITranslator);
begin
  GBox_RegExp             .Caption := ATranslator.GetValue(100, GBox_RegExp.Caption);
  Btn_Check               .Caption := ATranslator.GetValue(200, Btn_Check.Caption);
  GBox_Options            .Caption := ATranslator.GetValue(300, GBox_Options.Caption);
  ChBox_IgnoreCase        .Caption := ATranslator.GetValue(310, ChBox_IgnoreCase.Caption);
  ChBox_IgnoreCase        .Hint    := ATranslator.GetValue(311, ChBox_IgnoreCase.Hint);
  ChBox_MultiLine         .Caption := ATranslator.GetValue(320, ChBox_MultiLine.Caption);
  ChBox_MultiLine         .Hint    := ATranslator.GetValue(321, ChBox_MultiLine.Hint);
  ChBox_ExplicitCapture   .Caption := ATranslator.GetValue(330, ChBox_ExplicitCapture.Caption);
  ChBox_ExplicitCapture   .Hint    := ATranslator.GetValue(331, ChBox_ExplicitCapture.Hint);
  ChBox_Compiled          .Caption := ATranslator.GetValue(340, ChBox_Compiled.Caption);
  ChBox_Compiled          .Hint    := ATranslator.GetValue(341, ChBox_Compiled.Hint);
  ChBox_SingleLine        .Caption := ATranslator.GetValue(350, ChBox_SingleLine.Caption);
  ChBox_SingleLine        .Hint    := ATranslator.GetValue(351, ChBox_SingleLine.Hint);
  ChBox_IgnorePatternSpace.Caption := ATranslator.GetValue(360, ChBox_IgnorePatternSpace.Caption);
  ChBox_IgnorePatternSpace.Hint    := ATranslator.GetValue(361, ChBox_IgnorePatternSpace.Hint);
  GBox_Text               .Caption := ATranslator.GetValue(400, GBox_Text.Caption);
  GBox_Result             .Caption := ATranslator.GetValue(500, GBox_Result.Caption);

  FMsgFoundMatch     := ATranslator.GetValue(1001, FMsgFoundMatch);
  FMsgNoMatchesFound := ATranslator.GetValue(1002, FMsgNoMatchesFound);
  FMsgResultGroup    := ATranslator.GetValue(1003, FMsgResultGroup);
end;

end.
