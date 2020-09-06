program MVCPassiveView;

uses
  Vcl.Forms,
  ConvertModelIntf in 'Models\ConvertModelIntf.pas',
  ConvertModelImpl in 'Models\ConvertModelImpl.pas',
  MainControllerIntf in 'Controllers\MainControllerIntf.pas',
  MainControllerImpl in 'Controllers\MainControllerImpl.pas',
  MainViewIntf in 'Views\MainViewIntf.pas',
  FmMainView in 'Views\FmMainView.pas' {Fm_MainView},
  ObserverIntf in 'Models\ObserverIntf.pas';

{$R *.res}

var
  Model     : IConvertModel;
  Controller: IMainController;

begin
  Application.Initialize();
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TFm_MainView, Fm_MainView);
  Model      := TConvertModel.Create();
  Controller := TMainController.Create(Model, Fm_MainView);
  Fm_MainView.Init(Model);

  Application.Run();
end.
