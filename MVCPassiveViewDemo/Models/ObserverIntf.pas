unit ObserverIntf;

interface

type
  /// <summary>
  /// Observer
  /// </summary>
  IObserver = interface
    ['{AFAEE573-7A7D-4DB3-8C00-0A38E46CC577}']
    procedure Notify();
  end;

implementation

end.
