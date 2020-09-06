unit ConvertModelImpl;

interface

uses
  {VCL}
  System.Generics.Collections,
  {App}
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
  private
    {$REGION ' IConvertModel '}
    function  GetCelsius() : Double;
    procedure SetCelsius(
      const AValue : Double);
    function  GetFahrenheit() : Double;
    procedure SetFahrenheit(
      const AValue : Double);
    {$ENDREGION}
  end;

implementation

{------------------------------------------------------------------------------}
{ TConvertModel }
{------------------------------------------------------------------------------}

function TConvertModel.GetCelsius() : Double;
begin
  Result := FCelsius;
end;

procedure TConvertModel.SetCelsius(
  const AValue : Double);
begin
  FCelsius    := AValue;
  FFahrenheit := (FCelsius * 9 / 5) + 32;
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
end;

end.
