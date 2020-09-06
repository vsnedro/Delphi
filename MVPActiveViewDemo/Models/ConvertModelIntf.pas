unit ConvertModelIntf;

interface

type
  /// <summary>
  /// Temperature Convert Model
  /// </summary>
  IConvertModel = interface
    ['{9B319E91-F301-4165-AD72-113823FB961B}']
    function  GetCelsius() : Double;
    procedure SetCelsius(
      const AValue : Double);
    function  GetFahrenheit() : Double;
    procedure SetFahrenheit(
      const AValue : Double);

    property Celsius    : Double  read GetCelsius     write SetCelsius;
    property Fahrenheit : Double  read GetFahrenheit  write SetFahrenheit;
  end;

implementation

end.
