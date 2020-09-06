unit MainPresenterImpl;

interface

uses
  ConvertModelIntf,
  MainPresenterIntf,
  MainViewIntf;

type
  /// <summary>
  /// Main Presenter
  /// </summary>
  TMainPresenter = class(
    TInterfacedObject,
    IMainPresenter)
  strict private
    FModel: IConvertModel;
    [weak] FView: IMainView;
  strict private
    procedure SubscribeToViewEvents();

    procedure ConvertCelsiusToFahrenheit(Sender: TObject);
    procedure ConvertFahrenheitToCelsius(Sender: TObject);
  private
    {$REGION ' IMainPresenter '}
    {$ENDREGION}
  public
    constructor Create(
      const AModel: IConvertModel;
      const AView : IMainView);
  end;

implementation

{------------------------------------------------------------------------------}
{ TMainPresenter }
{------------------------------------------------------------------------------}

constructor TMainPresenter.Create(
  const AModel: IConvertModel;
  const AView: IMainView);
begin
  inherited Create();

  FModel := AModel;
  FView  := AView;

  SubscribeToViewEvents();
end;

procedure TMainPresenter.SubscribeToViewEvents();
begin
  FView.OnConvertCelsiusToFahrenheit := ConvertCelsiusToFahrenheit;
  FView.OnConvertFahrenheitToCelsius := ConvertFahrenheitToCelsius;
end;

procedure TMainPresenter.ConvertCelsiusToFahrenheit(Sender: TObject);
begin
  FModel.Celsius    := FView.Celsius;
  FView .Fahrenheit := FModel.Fahrenheit;
end;

procedure TMainPresenter.ConvertFahrenheitToCelsius(Sender: TObject);
begin
  FModel.Fahrenheit := FView.Fahrenheit;
  FView .Celsius    := FModel.Celsius;
end;

end.
