unit FactoryMethod;

interface

uses
  System.Generics.Collections;

{$REGION ' FMTransport '}
type
  /// <summary>
  /// Transport
  /// </summary>
  IFMTransport = interface
    procedure Deliver();
  end;

type
  /// <summary>
  /// Transport Factory
  /// </summary>
  IFMTransportFactory = interface
    function New() : IFMTransport;
  end;

type
  /// <summary>
  /// Truck
  /// </summary>
  TFMTruck = class(
    TInterfacedObject, IFMTransport)
  private
    procedure Deliver();
  end;

type
  /// <summary>
  /// Ship
  /// </summary>
  TFMShip = class(
    TInterfacedObject, IFMTransport)
  private
    procedure Deliver();
  end;

type
  /// <summary>
  /// Truck Factory
  /// </summary>
  TFMTruckFactory = class(
    TInterfacedObject, IFMTransportFactory)
  private
    function New() : IFMTransport;
  end;

type
  /// <summary>
  /// Ship Factory
  /// </summary>
  TFMShipFactory = class(
    TInterfacedObject, IFMTransportFactory)
  private
    function New() : IFMTransport;
  end;
{$ENDREGION}

type
  /// <summary>
  /// Projector
  /// </summary>
  IProjector = interface
    function GetPage(): Integer;

    procedure Present(
      const AInfo : String);
    procedure Update(
      const APage : Integer);

    property Page: Integer read GetPage;
  end;

type
  /// <summary>
  /// Wifi Projector
  /// </summary>
  TCustomProjector = class abstract(
    TInterfacedObject, IProjector)
  strict private
    FPage : Integer;
  private
    function GetPage(): Integer;

    procedure Present(
      const AInfo : String); virtual; abstract;
    procedure Update(
      const APage : Integer); virtual;
  end;

type
  /// <summary>
  /// Wifi Projector
  /// </summary>
  TWifiProjector = class(
    TCustomProjector)
  private
    procedure Present(
      const AInfo : String); override;
  end;

type
  /// <summary>
  /// Bluetooth Projector
  /// </summary>
  TBluetoothProjector = class(
    TCustomProjector)
  private
    procedure Present(
      const AInfo : String); override;
  end;

type
  /// <summary>
  /// ConferenceRoom (Projector Factory)
  /// </summary>
  IConferenceRoom = interface
    function CreateProjector() : IProjector;
    procedure Sync(
      const AProjector : IProjector);
  end;

type
  /// <summary>
  /// Custom Conference Room (Projector Factory)
  /// </summary>
  TCustomConferenceRoom = class abstract(
    TInterfacedObject, IConferenceRoom)
  strict protected
    FProjectors : TList<IProjector>;
  private
    function CreateProjector() : IProjector; virtual; abstract;
    procedure Sync(
      const AProjector : IProjector);
  public
    constructor Create();
    destructor  Destroy(); override;
  end;

type
  /// <summary>
  /// Wifi Conference Room
  /// </summary>
  TWifiConferenceRoom = class(TCustomConferenceRoom)
  private
    function CreateProjector() : IProjector; override;
  end;

type
  /// <summary>
  /// Bluetooth Conference Room
  /// </summary>
  TBluetoothConferenceRoom = class(TCustomConferenceRoom)
  private
    function CreateProjector() : IProjector; override;
  end;

implementation

uses
  System.SysUtils;

{$REGION ' FMTransport '}
{------------------------------------------------------------------------------}
{ TFMTruck }
{------------------------------------------------------------------------------}

procedure TFMTruck.Deliver();
begin
  Writeln('Truck delivering');
end;

{------------------------------------------------------------------------------}
{ TFMShip }
{------------------------------------------------------------------------------}

procedure TFMShip.Deliver();
begin
  Writeln('Ship delivering');
end;

{------------------------------------------------------------------------------}
{ TFMTruckFactory }
{------------------------------------------------------------------------------}

function TFMTruckFactory.New(): IFMTransport;
begin
  Result := TFMTruck.Create();
end;

{------------------------------------------------------------------------------}
{ TFMShipFactory }
{------------------------------------------------------------------------------}

function TFMShipFactory.New(): IFMTransport;
begin
  Result := TFMShip.Create();
end;
{$ENDREGION}

{------------------------------------------------------------------------------}
{ TCustomProjector }
{------------------------------------------------------------------------------}

function TCustomProjector.GetPage(): Integer;
begin
  Result := FPage;
end;

procedure TCustomProjector.Update(
  const APage: Integer);
begin
  FPage := APage;
  Writeln(Self.ClassName + ': Scrolling to page ' + FPage.ToString());
end;

{------------------------------------------------------------------------------}
{ TWifiProjector }
{------------------------------------------------------------------------------}

procedure TWifiProjector.Present(
  const AInfo: String);
begin
  Writeln('WiFi projector presents: ' + AInfo);
end;

{------------------------------------------------------------------------------}
{ TBluetoothProjector }
{------------------------------------------------------------------------------}

procedure TBluetoothProjector.Present(
  const AInfo: String);
begin
  Writeln('Bluetooth projector presents: ' + AInfo);
end;

{------------------------------------------------------------------------------}
{ TCustomConferenceRoom }
{------------------------------------------------------------------------------}

constructor TCustomConferenceRoom.Create();
begin
  inherited Create();

  FProjectors := TList<IProjector>.Create();
end;

destructor TCustomConferenceRoom.Destroy();
begin
  FreeAndNil(FProjectors);

  inherited Destroy();
end;

procedure TCustomConferenceRoom.Sync(
  const AProjector: IProjector);
var
  i : Integer;
begin
  for i := 0 to FProjectors.Count - 1 do
    FProjectors[i].Update(AProjector.Page);
end;

{------------------------------------------------------------------------------}
{ TWifiConferenceRoom }
{------------------------------------------------------------------------------}

function TWifiConferenceRoom.CreateProjector(): IProjector;
begin
  Result := TWifiProjector.Create();
  FProjectors.Add(Result);
end;

{------------------------------------------------------------------------------}
{ TBluetoothConferenceRoom }
{------------------------------------------------------------------------------}

function TBluetoothConferenceRoom.CreateProjector(): IProjector;
begin
  Result := TBluetoothProjector.Create();
  FProjectors.Add(Result);
end;

end.
