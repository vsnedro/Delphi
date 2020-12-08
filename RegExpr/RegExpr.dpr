program RegExpr;

uses
  Vcl.Forms,
  Translator in 'Translator.pas',
  FmMain in 'FmMain.pas' {Fm_Main},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize();
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Luna');

  var translator : ITranslator := TTranslator.Create();
  Application.CreateForm(TFm_Main, Fm_Main);
  Fm_Main.Translate(translator);

  Application.Run();
end.
