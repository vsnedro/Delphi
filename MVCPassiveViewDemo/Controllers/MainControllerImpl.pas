unit MainControllerImpl;

interface

uses
  ConvertModelIntf,
  MainControllerIntf,
  MainViewIntf;

type
  /// <summary>
  /// Main Controller
  /// </summary>
  TMainController = class(
    TInterfacedObject,
    IMainController)
  strict private
    FModel: IConvertModel;
    [weak] FView: IMainView;
  strict private
    procedure SubscribeToViewEvents();

    procedure ConvertCelsiusToFahrenheit(Sender: TObject);
    procedure ConvertFahrenheitToCelsius(Sender: TObject);
  private
    {$REGION ' IMainController '}
    {$ENDREGION}
  public
    constructor Create(
      const AModel: IConvertModel;
      const AView : IMainView);
  end;

implementation

{------------------------------------------------------------------------------}
{ TMainController }
{------------------------------------------------------------------------------}

constructor TMainController.Create(
  const AModel: IConvertModel;
  const AView: IMainView);
begin
  inherited Create();

  FModel := AModel;
  FView  := AView;

  SubscribeToViewEvents();
end;

procedure TMainController.SubscribeToViewEvents();
begin
  FView.OnConvertCelsiusToFahrenheit := ConvertCelsiusToFahrenheit;
  FView.OnConvertFahrenheitToCelsius := ConvertFahrenheitToCelsius;
end;

procedure TMainController.ConvertCelsiusToFahrenheit(Sender: TObject);
begin
  FModel.Celsius := FView.GetCelsius();
end;

procedure TMainController.ConvertFahrenheitToCelsius(Sender: TObject);
begin
  FModel.Fahrenheit := FView.GetFahrenheit();
end;

end.
