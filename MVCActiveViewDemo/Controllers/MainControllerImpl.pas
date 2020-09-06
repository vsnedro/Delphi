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
  private
    {$REGION ' IMainController '}
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
{ TMainController }
{------------------------------------------------------------------------------}

constructor TMainController.Create(
  const AModel: IConvertModel;
  const AView: IMainView);
begin
  inherited Create();

  FModel := AModel;
  FView  := AView;
end;

procedure TMainController.ConvertCelsiusToFahrenheit();
begin
  FModel.Celsius := FView.GetCelsius();
end;

procedure TMainController.ConvertFahrenheitToCelsius();
begin
  FModel.Fahrenheit := FView.GetFahrenheit();
end;

end.
