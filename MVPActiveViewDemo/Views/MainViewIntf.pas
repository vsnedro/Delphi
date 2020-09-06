unit MainViewIntf;

interface

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

    property Celsius    : Double  read GetCelsius     write SetCelsius;
    property Fahrenheit : Double  read GetFahrenheit  write SetFahrenheit;
  end;

implementation

end.
