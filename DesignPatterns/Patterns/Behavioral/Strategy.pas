unit Strategy;

interface

type
  /// <summary>
  /// Route Builder
  /// </summary>
  IRouteBuilder = interface
    ['{C0136034-F045-456B-80B1-83483BE8ED59}']
    function BuildRoute(
      const AFrom : String;
      const ATo   : String) : String;
  end;

type
  /// <summary>
  /// Map Navigator
  /// </summary>
  IMapNavigator = interface
    ['{802FF517-914A-4BBC-8631-6B26A0850BB0}']
    procedure SetRouter(
      const ARouter : IRouteBuilder);
    function BuildRoute(
      const AFrom : String;
      const ATo   : String) : String;
  end;

type
  /// <summary>
  /// Map Navigator Client
  /// </summary>
  IMapNavigatorClient = interface
    ['{7DD60DE1-1D5C-4528-BB5A-687D46C3486A}']
    procedure GetRouteOnFoot();
    procedure GetRouteOnCar();
    procedure GetRouteOnPublicTransport();
  end;

{------------------------------------------------------------------------------}

type
  /// <summary>
  /// Route Builder On Foot
  /// </summary>
  TRouteBuilderOnFoot = class(
    TInterfacedObject, IRouteBuilder)
  private
    function BuildRoute(
      const AFrom : String;
      const ATo   : String) : String;
  end;

type
  /// <summary>
  /// Route Builder On Car
  /// </summary>
  TRouteBuilderOnCar = class(
    TInterfacedObject, IRouteBuilder)
  private
    function BuildRoute(
      const AFrom : String;
      const ATo   : String) : String;
  end;

type
  /// <summary>
  /// Route Builder On Public Transport
  /// </summary>
  TRouteBuilderOnPublicTransport = class(
    TInterfacedObject, IRouteBuilder)
  private
    function BuildRoute(
      const AFrom : String;
      const ATo   : String) : String;
  end;

type
  /// <summary>
  /// Map Navigator
  /// </summary>
  TMapNavigator = class(
    TInterfacedObject, IMapNavigator)
  strict private
    FRouter: IRouteBuilder;
  private
    procedure SetRouter(
      const ARouter : IRouteBuilder);
    function BuildRoute(
      const AFrom : String;
      const ATo   : String) : String;
  public
    constructor Create();
  end;

type
  /// <summary>
  /// Map Navigator Client
  /// </summary>
  TMapNavigatorClient = class(
    TInterfacedObject, IMapNavigatorClient)
  strict private
    FMapNavigator: IMapNavigator;
  private
    procedure GetRouteOnFoot();
    procedure GetRouteOnCar();
    procedure GetRouteOnPublicTransport();
  public
    constructor Create(
      const AMapNavigator: IMapNavigator);
  end;

implementation

uses
  System.SysUtils;

{------------------------------------------------------------------------------}
{ TRouteBuilderOnFoot }
{------------------------------------------------------------------------------}

function TRouteBuilderOnFoot.BuildRoute(
  const AFrom : String;
  const ATo   : String): String;
begin
  Result := Format(
    'Route on foot: Walk straight ahead 1000 m, turn to left, walk straight ahead 2000 m.',
    [ATo]);
end;

{------------------------------------------------------------------------------}
{ TRouteBuilderOnCar }
{------------------------------------------------------------------------------}

function TRouteBuilderOnCar.BuildRoute(
  const AFrom : String;
  const ATo   : String): String;
begin
  Result := Format(
    'Route on car: Get in car, drive straight ahead 1000 m, turn to left, drive straight ahead 2000 m.',
    [ATo]);
end;

{------------------------------------------------------------------------------}
{ TRouteBuilderOnPublicTransport }
{------------------------------------------------------------------------------}

function TRouteBuilderOnPublicTransport.BuildRoute(
  const AFrom : String;
  const ATo   : String): String;
begin
  Result := Format(
    'Route on public transport: Get in bus #123, drive three stops, get off the bus.',
    [ATo]);
end;

{------------------------------------------------------------------------------}
{ TMapNavigator }
{------------------------------------------------------------------------------}

constructor TMapNavigator.Create();
begin
  inherited Create();

  FRouter := TRouteBuilderOnFoot.Create();
end;

procedure TMapNavigator.SetRouter(
  const ARouter: IRouteBuilder);
begin
  FRouter := ARouter;
end;

function TMapNavigator.BuildRoute(
  const AFrom, ATo: String): String;
begin
  Writeln(Format(
    'Map Navigator: I am building route form %s to %s...',
    [AFrom, ATo]));
  Result := FRouter.BuildRoute(AFrom, ATo);
  Writeln('Map Navigator: Route is ready!');
  Writeln(Result);
end;

{------------------------------------------------------------------------------}
{ TMapNavigatorClient }
{------------------------------------------------------------------------------}

constructor TMapNavigatorClient.Create(
  const AMapNavigator: IMapNavigator);
begin
  inherited Create();

  FMapNavigator := AMapNavigator;
end;

procedure TMapNavigatorClient.GetRouteOnFoot();
begin
  Writeln('Client: I want to get from "Lenin st., 1" to "City hall" on FOOT. How do i get there?');
  FMapNavigator.BuildRoute('"Lenin st., 1"', '"City hall"');
end;

procedure TMapNavigatorClient.GetRouteOnCar();
begin
  Writeln('Client: I want to get from "Lenin st., 1" to "City hall" on CAR. How do i get there?');
  FMapNavigator.SetRouter(TRouteBuilderOnCar.Create());
  FMapNavigator.BuildRoute('"Lenin st., 1"', '"City hall"');
end;

procedure TMapNavigatorClient.GetRouteOnPublicTransport();
begin
  Writeln('Client: I want to get from "Lenin st., 1" to "City hall" on PUBLIC TRANSPORT. How do i get there?');
  FMapNavigator.SetRouter(TRouteBuilderOnPublicTransport.Create());
  FMapNavigator.BuildRoute('"Lenin st., 1"', '"City hall"');
end;

end.
