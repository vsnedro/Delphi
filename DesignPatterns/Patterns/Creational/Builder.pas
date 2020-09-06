unit Builder;

interface

type
  /// <summary>
  /// Car Type
  /// </summary>
  TCarType = (
    ctSportCar,
    ctTruck
  );

type
  /// <summary>
  /// Car
  /// </summary>
  ICar = interface
    ['{3C3982FD-A145-4F46-9A2E-0C7F092B672A}']
    procedure Look();
  end;

type
  /// <summary>
  /// Car
  /// </summary>
  ICarManual = interface
    ['{0CF8AD41-76FD-4CDC-BC08-5AE3E474F955}']
    procedure Read();
  end;

type
  /// <summary>
  /// Car
  /// </summary>
  TCar = class(
    TInterfacedObject, ICar)
  strict private
    FName : String;
  private
    procedure Look();
  public
    constructor Create(
      const AName : String);
  end;

type
  /// <summary>
  /// Car Manual
  /// </summary>
  TCarManual = class(
    TInterfacedObject, ICarManual)
  strict private
    FName : String;
  private
    procedure Read();
  public
    constructor Create(
      const AName : String);
  end;

type
  /// <summary>
  /// Builder
  /// </summary>
  IBuilder  = interface
    ['{47DB953E-626C-44A9-90C0-2FE20913B9A0}']
    procedure Start(
      const AName : String);
    procedure SetSeats(
      const ANumber : Integer);
    procedure SetEngine(
      const AName : String);
    procedure SetComputer();
    procedure SetAudio();
    function GetResult() : IInterface;
  end;

type
  /// <summary>
  /// Car Builder
  /// </summary>
  TCarBuilder = class(
    TInterfacedObject, IBuilder)
  strict private
    FCar : ICar;
  private
    procedure Start(
      const AName : String);
    procedure SetSeats(
      const ANumber : Integer);
    procedure SetEngine(
      const AName : String);
    procedure SetComputer();
    procedure SetAudio();
    function GetResult() : IInterface;
  end;

type
  /// <summary>
  /// Manual Builder
  /// </summary>
  TManualBuilder = class(
    TInterfacedObject, IBuilder)
  strict private
    FManual : ICarManual;
  private
    procedure Start(
      const AName : String);
    procedure SetSeats(
      const ANumber : Integer);
    procedure SetEngine(
      const AName : String);
    procedure SetComputer();
    procedure SetAudio();
    function GetResult() : IInterface;
  end;

type
  /// <summary>
  /// Director
  /// </summary>
  IDirector = interface
    ['{898991E1-9976-4EE9-BACD-FCEE38EBD993}']
    procedure MakeSportCar();
    procedure MakeTruck();
    procedure SetBuilder(
      const ABuilder : IBuilder);
  end;

type
  /// <summary>
  /// Director
  /// </summary>
  TDirector = class(
    TInterfacedObject, IDirector)
  strict private
    FBuilder : IBuilder;
  private
    procedure MakeSportCar();
    procedure MakeTruck();
    procedure SetBuilder(
      const ABuilder : IBuilder);
  public
    constructor Create(
      const ABuilder : IBuilder);
  end;

type
  /// <summary>
  /// Car Client
  /// </summary>
  ICarClient = interface
    procedure GetCar(
      const AType : TCarType);
  end;

type
  /// <summary>
  /// Car Client
  /// </summary>
  TCarClient = class(
    TInterfacedObject, ICarClient)
  private
    procedure GetCar(
      const AType : TCarType);
  end;

implementation

uses
  System.SysUtils;

{------------------------------------------------------------------------------}
{ TCarBuilder }
{------------------------------------------------------------------------------}

procedure TCarBuilder.Start(
  const AName : String);
begin
  FCar := TCar.Create(AName);
  Writeln('Building car...');
end;

procedure TCarBuilder.SetAudio;
begin
  Writeln('Set audio');
end;

procedure TCarBuilder.SetComputer;
begin
  Writeln('Set computer');
end;

procedure TCarBuilder.SetEngine(
  const AName: String);
begin
  Writeln('Set engine: ' + AName);
end;

procedure TCarBuilder.SetSeats(
  const ANumber: Integer);
begin
  Writeln('Set seats: ' + ANumber.ToString());
end;

function TCarBuilder.GetResult(): IInterface;
begin
  Result := FCar;
end;

{------------------------------------------------------------------------------}
{ TManualBuilder }
{------------------------------------------------------------------------------}

procedure TManualBuilder.Start(
  const AName: String);
begin
  FManual := TCarManual.Create(AName);
  Writeln('Printing manual...');
end;

procedure TManualBuilder.SetAudio;
begin
  Writeln('В машине есть аудиосистема');
end;

procedure TManualBuilder.SetComputer;
begin
  Writeln('В машине есть компьютер');
end;

procedure TManualBuilder.SetEngine(
  const AName: String);
begin
  Writeln('В машине есть ' + AName);
end;

procedure TManualBuilder.SetSeats(
  const ANumber: Integer);
begin
  Writeln('В машине есть сиденья: ' + ANumber.ToString() + ' шт.');
end;

function TManualBuilder.GetResult: IInterface;
begin
  Result := FManual;
end;

{------------------------------------------------------------------------------}
{ TDirector }
{------------------------------------------------------------------------------}

constructor TDirector.Create(
  const ABuilder: IBuilder);
begin
  inherited Create();

  FBuilder := ABuilder;
end;

procedure TDirector.SetBuilder(
  const ABuilder: IBuilder);
begin
  FBuilder := ABuilder;
end;

procedure TDirector.MakeSportCar();
begin
  FBuilder.Start('Sport Car');
  FBuilder.SetSeats(2);
  FBuilder.SetEngine('sport engine');
  FBuilder.SetComputer();
  FBuilder.SetAudio();
end;

procedure TDirector.MakeTruck();
begin
  FBuilder.Start('Truck');
  FBuilder.SetSeats(4);
  FBuilder.SetEngine('diesel engine');
end;

{------------------------------------------------------------------------------}
{ TCarClient }
{------------------------------------------------------------------------------}

procedure TCarClient.GetCar(
  const AType: TCarType);
var
  CarBuilder    : IBuilder;
  ManualBuilder : IBuilder;
  Director      : IDirector;
  Car           : ICar;
  Manual        : ICarManual;
begin
  CarBuilder    := TCarBuilder.Create();
  ManualBuilder := TManualBuilder.Create();

  case AType of
    ctSportCar :
      begin
        Director := TDirector.Create(CarBuilder);
        Director.MakeSportCar();
        Director.SetBuilder(ManualBuilder);
        Director.MakeSportCar();
      end;

    ctTruck :
      begin
        Director := TDirector.Create(CarBuilder);
        Director.MakeTruck();
        Director.SetBuilder(ManualBuilder);
        Director.MakeTruck();
      end;
  end;

  Car    := CarBuilder.GetResult() as ICar;
  Manual := ManualBuilder.GetResult() as ICarManual;
  Car.Look();
  Manual.Read();
end;

{------------------------------------------------------------------------------}
{ TCar }
{------------------------------------------------------------------------------}

constructor TCar.Create(
  const AName: String);
begin
  inherited Create();

  FName := AName;
end;

procedure TCar.Look();
begin
  Writeln('I am vehicle ' + FName);
end;

{------------------------------------------------------------------------------}
{ TCarManual }
{------------------------------------------------------------------------------}

constructor TCarManual.Create(
  const AName: String);
begin
  inherited Create();

  FName := AName;
end;

procedure TCarManual.Read();
begin
  Writeln('I am manual for ' + FName);
end;

end.
