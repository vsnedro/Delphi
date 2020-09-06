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
  private
    {$REGION ' IMainPresenter '}
    procedure ConvertCelsiusToFahrenheit();
    procedure ConvertFahrenheitToCelsius();
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
end;

procedure TMainPresenter.ConvertCelsiusToFahrenheit();
begin
  FModel.Celsius    := FView .Celsius;
  FView .Fahrenheit := FModel.Fahrenheit;
end;

procedure TMainPresenter.ConvertFahrenheitToCelsius();
begin
  FModel.Fahrenheit := FView .Fahrenheit;
  FView .Celsius    := FModel.Celsius;
end;

end.
