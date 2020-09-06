program RandomNumberGenerator;

uses
  Vcl.Forms,
  FmMain in 'FmMain.pas' {Fm_Main};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFm_Main, Fm_Main);
  Application.Run;
end.
