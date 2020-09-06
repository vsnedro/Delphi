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
    procedure SetOnConvertCelsiusToFahrenheit(
      const AValue: TNotifyEvent);
    procedure SetOnConvertFahrenheitToCelsius(
      const AValue: TNotifyEvent);

    function GetCelsius() : Double;
    function GetFahrenheit() : Double;

    property OnConvertCelsiusToFahrenheit: TNotifyEvent write SetOnConvertCelsiusToFahrenheit;
    property OnConvertFahrenheitToCelsius: TNotifyEvent write SetOnConvertFahrenheitToCelsius;
  end;

implementation

end.
