program MVPPassiveView;

uses
  Vcl.Forms,
  ConvertModelIntf in 'Models\ConvertModelIntf.pas',
  ConvertModelImpl in 'Models\ConvertModelImpl.pas',
  MainPresenterIntf in 'Presenters\MainPresenterIntf.pas',
  MainPresenterImpl in 'Presenters\MainPresenterImpl.pas',
  MainViewIntf in 'Views\MainViewIntf.pas',
  FmMainView in 'Views\FmMainView.pas' {Fm_MainView};

{$R *.res}

var
  Model    : IConvertModel;
  Presenter: IMainPresenter;

begin
  Application.Initialize();
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TFm_MainView, Fm_MainView);
  Model     := TConvertModel.Create();
  Presenter := TMainPresenter.Create(Model, Fm_MainView);

  Application.Run();
end.
