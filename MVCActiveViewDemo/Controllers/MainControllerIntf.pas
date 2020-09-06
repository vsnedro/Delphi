unit MainControllerIntf;

interface

type
  /// <summary>
  /// Main Controller
  /// </summary>
  IMainController = interface
    ['{11C5263A-46BB-4F12-A502-E19648AAC410}']
    procedure ConvertCelsiusToFahrenheit();
    procedure ConvertFahrenheitToCelsius();
  end;

implementation

end.
