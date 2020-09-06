unit ConvertModelImpl;

interface

uses
  {VCL}
  System.Generics.Collections,
  {App}
  ObserverIntf,
  ConvertModelIntf;

type
  /// <summary>
  /// Temperature Convert Model
  /// </summary>
  TConvertModel = class(
    TInterfacedObject,
    IConvertModel)
  strict private
    FCelsius    : Double;
    FFahrenheit : Double;
  strict private
    FObservers : TList<IObserver>;
  private
    {$REGION ' IConvertModel '}
    function  GetCelsius() : Double;
    procedure SetCelsius(
      const AValue : Double);
    function  GetFahrenheit() : Double;
    procedure SetFahrenheit(
      const AValue : Double);

    procedure Subscribe(
      const AObserver : IObserver);
    procedure Unsubscribe(
      const AObserver : IObserver);
    {$ENDREGION}
  public
    constructor Create();
    destructor  Destroy(); override;
  end;

implementation

uses
  {VCL}
  System.SysUtils;

{------------------------------------------------------------------------------}
{ TConvertModel }
{------------------------------------------------------------------------------}

constructor TConvertModel.Create();
begin
  inherited Create();

  FObservers := TList<IObserver>.Create();
end;

destructor TConvertModel.Destroy();
begin
  FreeAndNil(FObservers);

  inherited Destroy();
end;

function TConvertModel.GetCelsius() : Double;
begin
  Result := FCelsius;
end;

procedure TConvertModel.SetCelsius(
  const AValue : Double);
begin
  FCelsius    := AValue;
  FFahrenheit := (FCelsius * 9 / 5) + 32;

  var
    Observer : IObserver;
  for Observer in FObservers do
    Observer.Notify();
end;

function TConvertModel.GetFahrenheit() : Double;
begin
  Result := FFahrenheit;
end;

procedure TConvertModel.SetFahrenheit(
  const AValue : Double);
begin
  FFahrenheit := AValue;
  FCelsius    := (FFahrenheit - 32) * 5 / 9;

  var
    Observer : IObserver;
  for Observer in FObservers do
    Observer.Notify();
end;

procedure TConvertModel.Subscribe(
  const AObserver : IObserver);
begin
  if not FObservers.Contains(AObserver) then
    FObservers.Add(AObserver);
end;

procedure TConvertModel.Unsubscribe(
  const AObserver : IObserver);
begin
  if FObservers.Contains(AObserver) then
    FObservers.Remove(AObserver);
end;

end.
