unit MainViewIntf;

interface

uses
  System.Classes;

type
  /// <summary>
  /// Main View
  /// </summary>
  IMainView = interface
    ['{3B3767FE-DE1C-4FB1-A008-8B805D08C162}']
    function  GetCelsius() : Double;
    procedure SetCelsius(
      const AValue : Double);
    function  GetFahrenheit() : Double;
    procedure SetFahrenheit(
      const AValue : Double);
    { Events }
    procedure SetOnConvertCelsiusToFahrenheit(
      const AValue: TNotifyEvent);
    procedure SetOnConvertFahrenheitToCelsius(
      const AValue: TNotifyEvent);

    property Celsius    : Double  read GetCelsius     write SetCelsius;
    property Fahrenheit : Double  read GetFahrenheit  write SetFahrenheit;
    { Events }
    property OnConvertCelsiusToFahrenheit: TNotifyEvent write SetOnConvertCelsiusToFahrenheit;
    property OnConvertFahrenheitToCelsius: TNotifyEvent write SetOnConvertFahrenheitToCelsius;
  end;

implementation

end.
