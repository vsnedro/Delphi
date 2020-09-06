unit MainViewIntf;

interface

type
  /// <summary>
  /// Main View
  /// </summary>
  IMainView = interface
    ['{3B3767FE-DE1C-4FB1-A008-8B805D08C162}']
    function GetCelsius() : Double;
    function GetFahrenheit() : Double;
  end;

implementation

end.
