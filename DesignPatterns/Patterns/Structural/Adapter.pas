unit Adapter;

interface

{$REGION ' Math Operations '}
type
  /// <summary>
  /// Math Operations
  /// </summary>
  IMathOper = interface
    ['{8B62723D-5274-4852-9760-3B5C0D7F2FD8}']
    function Min(
      const A, B : Integer) : Integer;
    function Max(
      const A, B : Integer) : Integer;
  end;
  
type
  /// <summary>
  /// Math Operations
  /// </summary>
  TMathOper = class(
    TInterfacedObject,
    IMathOper)
  private
    function Min(
      const A, B : Integer) : Integer;
    function Max(
      const A, B : Integer) : Integer;
  end;
  
type
  /// <summary>
  /// Math Client
  /// </summary>
  IMathClient = interface
    procedure DoWork(
      const A, B : Integer);
  end;
  
type
  /// <summary>
  /// Math Client
  /// </summary>
  TMathClient = class(
    TInterfacedObject,
    IMathClient)
  strict private
    FMathOper : IMathOper;
  private
    procedure DoWork(
      const A, B : Integer);
  public
    constructor Create(
      AMathOper : IMathOper);
  end;
  
type
  /// <summary>
  /// Fast Math Operations
  /// </summary>
  IFastMathOper = interface
    ['{26CBFC29-205C-4196-B576-D1672E372736}']
    function CalculateMin(
      const A, B : Integer) : Integer;
    function CalculateMax(
      const A, B : Integer) : Integer;
  end;
  
type
  /// <summary>
  /// Fast Math Operations
  /// </summary>
  TFastMathOper = class(
    TInterfacedObject,
    IFastMathOper)
  private
    function CalculateMin(
      const A, B : Integer) : Integer;
    function CalculateMax(
      const A, B : Integer) : Integer;
  end;
  
type
  /// <summary>
  /// Fast Math Operations
  /// </summary>
  TFastMathOperAdapter = class(
    TInterfacedObject,
    IMathOper)
  strict private
    FMathOper : IFastMathOper;
  private
    function Min(
      const A, B : Integer) : Integer;
    function Max(
      const A, B : Integer) : Integer;
  public
    constructor Create(
      AMathOper : IFastMathOper);
  end;
  
type
  /// <summary>
  /// Math Client
  /// </summary>
  IMathStrClient = interface
    procedure DoWork(
      const A, B : String);
  end;
  
type
  /// <summary>
  /// Math String Adapter
  /// </summary>
  IMathStrAdapter = interface
    function Min(
      const A, B : String) : Integer;
    function Max(
      const A, B : String) : Integer;
  end;
  
type
  /// <summary>
  /// Math Client
  /// </summary>
  TMathStrAdapter = class(
    TInterfacedObject,
    IMathStrAdapter)
  strict private
    FMathOper : IMathOper;
  private
    function Min(
      const A, B : String) : Integer;
    function Max(
      const A, B : String) : Integer;
  public
    constructor Create(
      AMathOper : IMathOper);
  end;
  
type
  /// <summary>
  /// Math Client
  /// </summary>
  TMathStrClient = class(
    TInterfacedObject,
    IMathStrClient)
  strict private
    FMathOper : IMathStrAdapter;
  private
    procedure DoWork(
      const A, B : String);
  public
    constructor Create(
      AMathOper : IMathStrAdapter);
  end;
{$ENDREGION}

{==============================================================================}

type
  /// <summary>
  /// Auth Service
  /// </summary>
  IAuthService = interface
    procedure Login();
  end;

type
  /// <summary>
  /// Facebook Auth Service
  /// </summary>
  TFacebookAuthService = class(
    TInterfacedObject, IAuthService)
  private
    procedure Login();
  end;

type
  /// <summary>
  /// Other Auth Service
  /// </summary>
  IOtherAuthService = interface
    procedure Auth();
  end;

type
  /// <summary>
  /// Twitter Auth Service
  /// </summary>
  TTwitterAuthService = class(
    TInterfacedObject, IOtherAuthService)
  private
    procedure Auth();
  end;

type
  /// <summary>
  /// Twitter Auth Service Adapter
  /// </summary>
  TTwitterAuthServiceAdapter = class(
    TInterfacedObject, IAuthService)
  strict private
    FAuthService : IOtherAuthService;
  private
    procedure Login();
  public
    constructor Create(
      const AAuthService : IOtherAuthService);
  end;

type
  /// <summary>
  /// Client That Needs Auth
  /// </summary>
  IClientThatNeedsAuth = interface
    procedure DoAuth();
  end;

type
  /// <summary>
  /// Client That Needs Auth
  /// </summary>
  TClientThatNeedsAuth = class(
    TInterfacedObject, IClientThatNeedsAuth)
  strict private
    FAuthService : IAuthService;
  private
    procedure DoAuth();
  public
    constructor Create(
      const AAuthService : IAuthService);
  end;

implementation

uses
  System.SysUtils;

{$REGION ' Math Operations '}
{------------------------------------------------------------------------------}
{ TMathOper }
{------------------------------------------------------------------------------}

function TMathOper.Max(
  const A, B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

function TMathOper.Min(
  const A, B: Integer): Integer;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

{------------------------------------------------------------------------------}
{ TMathClient }
{------------------------------------------------------------------------------}

constructor TMathClient.Create(
  AMathOper : IMathOper);
begin
  inherited Create();

  FMathOper := AMathOper;
end;


procedure TMathClient.DoWork(
  const A, B : Integer);
begin
  Writeln(Format('Client wants to get minimum of %d and %d', [A, B]));
  Writeln('Minimum is ' + FMathOper.Min(A, B).ToString());
  Writeln(Format('Client wants to get maximum of %d and %d', [A, B]));
  Writeln('Maximum is ' + FMathOper.Max(A, B).ToString());
end;

{------------------------------------------------------------------------------}
{ TFastMathOper }
{------------------------------------------------------------------------------}

function TFastMathOper.CalculateMax(
  const A, B: Integer): Integer;
begin
  if A >= B then
    Result := A
  else
    Result := B;
end;

function TFastMathOper.CalculateMin(
  const A, B: Integer): Integer;
begin
  if A <= B then
    Result := A
  else
    Result := B;
end;

{------------------------------------------------------------------------------}
{ TFastMathOperAdapter }
{------------------------------------------------------------------------------}

constructor TFastMathOperAdapter.Create(
  AMathOper: IFastMathOper);
begin
  inherited Create();

  FMathOper := AMathOper;
end;

function TFastMathOperAdapter.Max(
  const A, B: Integer): Integer;
begin
  Result := FMathOper.CalculateMax(A, B);
end;

function TFastMathOperAdapter.Min(
  const A, B: Integer): Integer;
begin
  Result := FMathOper.CalculateMin(A, B);
end;

{------------------------------------------------------------------------------}
{ TMathStrAdapter }
{------------------------------------------------------------------------------}

constructor TMathStrAdapter.Create(
  AMathOper: IMathOper);
begin
  inherited Create();

  FMathOper := AMathOper;
end;

function TMathStrAdapter.Max(
  const A, B: String): Integer;
begin
  Result := FMathOper.Min(StrToIntDef(A, 0), StrToIntDef(B, 0));
end;

function TMathStrAdapter.Min(
  const A, B: String): Integer;
begin
  Result := FMathOper.Min(A.ToInteger, B.ToInteger);
end;

{------------------------------------------------------------------------------}
{ TMathStrClient }
{------------------------------------------------------------------------------}

constructor TMathStrClient.Create(
  AMathOper: IMathStrAdapter);
begin
  inherited Create();

  FMathOper := AMathOper;
end;

procedure TMathStrClient.DoWork(
  const A, B: String);
begin
  Writeln('Client wants to get minimum of ' + A + ' and ' + B);
  Writeln('Minimum is ' + FMathOper.Min(A, B).ToString());
  Writeln('Client wants to get maximum of ' + A + ' and ' + B);
  Writeln('Maximum is ' + FMathOper.Max(A, B).ToString());
end;
{$ENDREGION}

{==============================================================================}

{------------------------------------------------------------------------------}
{ TClientThatNeedsAuth }
{------------------------------------------------------------------------------}

constructor TClientThatNeedsAuth.Create(
  const AAuthService: IAuthService);
begin
  inherited Create();

  FAuthService := AAuthService;
end;

procedure TClientThatNeedsAuth.DoAuth();
begin
  FAuthService.Login();
end;

{------------------------------------------------------------------------------}
{ TFacebookAuthService }
{------------------------------------------------------------------------------}

procedure TFacebookAuthService.Login();
begin
  Writeln('Authorization via Facebook...');
  Sleep(1000);
  Writeln('Done!');
end;

{------------------------------------------------------------------------------}
{ TTwitterAuthService }
{------------------------------------------------------------------------------}

procedure TTwitterAuthService.Auth();
begin
  Writeln('Authorization via Twitter...');
  Sleep(1000);
  Writeln('Done!');
end;

{------------------------------------------------------------------------------}
{ TTwitterAuthServiceAdapter }
{------------------------------------------------------------------------------}

constructor TTwitterAuthServiceAdapter.Create(
  const AAuthService: IOtherAuthService);
begin
  inherited Create();

  FAuthService := AAuthService;
end;

procedure TTwitterAuthServiceAdapter.Login();
begin
  Writeln('Using adapter for Twitter auth service');
  FAuthService.Auth();
end;

end.
