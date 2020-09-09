unit Observer;

interface

uses
  System.Generics.Collections;

type
  /// <summary>
  /// Event Type
  /// </summary>
  TEventType = (
    evtConnect,
    evtError
  );

type
  /// <summary>
  /// Event Observer
  /// </summary>
  IEventObserver = interface
    ['{9AFF5D40-9354-4203-8FF7-0F5750955DBB}']
    procedure Update(
      const ASender    : IInterface;
      const AEventType : TEventType);
  end;

type
  /// <summary>
  /// Event Manager
  /// </summary>
  IEventManager = interface
    ['{79A9E31D-1768-4B30-A286-EABE609FD5DD}']
    procedure Subscribe(
      const AObserver  : IEventObserver;
      const AEventType : TEventType);
    procedure Unsubscribe(
      const AObserver  : IEventObserver;
      const AEventType : TEventType);
    procedure Notify(
      const ASender    : IInterface;
      const AEventType : TEventType);
  end;

type
  /// <summary>
  /// Subject
  /// </summary>
  ISubject = interface
    ['{CC2DCAE6-C746-441C-9CBA-DCA5D7CB19C7}']
    function GetEvents() : IEventManager;

    property Events: IEventManager read GetEvents;
  end;

type
  /// <summary>
  /// Database
  /// </summary>
  IDatabase = interface(ISubject)
    ['{1380DDAE-8B85-476A-9FCA-4B655021159F}']
    procedure Connect();
    procedure RaiseError();
  end;

type
  /// <summary>
  /// Web Service
  /// </summary>
  IWebService = interface(ISubject)
    ['{7B030E3F-239B-468A-9852-EAE1085E2C0A}']
    procedure Connect();
    procedure RaiseError();
  end;

type
  /// <summary>
  /// Observer Context
  /// </summary>
  IObserverContext = interface
    ['{370E61ED-D7AB-4D5E-B740-771ADD5D40F9}']
    procedure DoSomeWork();
  end;

{------------------------------------------------------------------------------}

type
  /// <summary>
  /// Event Logger
  /// </summary>
  TEventLogger = class(
    TInterfacedObject, IEventObserver)
  private
    procedure Update(
      const ASender    : IInterface;
      const AEventType : TEventType);
  end;

type
  /// <summary>
  /// Event Email Sender
  /// </summary>
  TEventEmailSender = class(
    TInterfacedObject, IEventObserver)
  private
    procedure Update(
      const ASender    : IInterface;
      const AEventType : TEventType);
  end;

type
  /// <summary>
  /// Event Manager
  /// </summary>
  TEventManager = class(
    TInterfacedObject, IEventManager)
  strict private
    FObservers : array of TPair<IEventObserver, TEventType>;
  private
    procedure Subscribe(
      const AObserver  : IEventObserver;
      const AEventType : TEventType);
    procedure Unsubscribe(
      const AObserver  : IEventObserver;
      const AEventType : TEventType);
    procedure Notify(
      const ASender    : IInterface;
      const AEventType : TEventType);
  public
    destructor Destroy(); override;
  end;

type
  /// <summary>
  /// Subject
  /// </summary>
  TSubject = class(
    TInterfacedObject, ISubject)
  strict protected
    FEventManager: IEventManager;
  private
    function GetEvents() : IEventManager;
  public
    constructor Create(
      AEventManager : IEventManager);
  end;

type
  /// <summary>
  /// Database
  /// </summary>
  TDatabase = class(
    TSubject, IDatabase)
  private
    procedure Connect();
    procedure RaiseError();
  end;

type
  /// <summary>
  /// Web Service
  /// </summary>
  TWebService = class(
    TSubject, IWebService)
  private
    procedure Connect();
    procedure RaiseError();
  end;

type
  /// <summary>
  /// Observer Context
  /// </summary>
  TObserverContext = class(
    TInterfacedObject, IObserverContext)
  private
    procedure DoSomeWork();
  end;

implementation

uses
  System.SysUtils;

{------------------------------------------------------------------------------}
{ TEventLogger }
{------------------------------------------------------------------------------}

procedure TEventLogger.Update(
  const ASender   : IInterface;
  const AEventType: TEventType);
var
  S : String;
begin
  if Supports(ASender, IDatabase) then
    S := 'Database'
  else
  if Supports(ASender, IWebService) then
    S := 'Web Service'
  else
    Exit;

  case AEventType of
    evtConnect :
      Writeln('Logger: Somebody connected to ' + S);
    evtError   :
      Writeln('Logger: Warning! Error occured in ' + S);
  end;
end;

{------------------------------------------------------------------------------}
{ TEventEmailSender }
{------------------------------------------------------------------------------}

procedure TEventEmailSender.Update(
  const ASender   : IInterface;
  const AEventType: TEventType);
var
  S : String;
begin
  if Supports(ASender, IDatabase) then
    S := 'Database'
  else
  if Supports(ASender, IWebService) then
    S := 'Web Service'
  else
    Exit;

  case AEventType of
    evtConnect :
      Writeln('Email Sender: Somebody connected to ' + S);
    evtError   :
      Writeln('Email Sender: Warning! Error occured in ' + S);
  end;
end;

{------------------------------------------------------------------------------}
{ TEventManager }
{------------------------------------------------------------------------------}

destructor TEventManager.Destroy();
var
  i : Integer;
begin
  for i := Low(FObservers) to High(FObservers) do
    FObservers[i].Key := nil;
  SetLength(FObservers, 0);

  inherited;
end;

procedure TEventManager.Subscribe(
  const AObserver : IEventObserver;
  const AEventType: TEventType);
var
  N : Integer;
begin
  N := Length(FObservers);
  SetLength(FObservers, N + 1);
  FObservers[N] := TPair<IEventObserver, TEventType>.Create(AObserver, AEventType);
end;

procedure TEventManager.Unsubscribe(
  const AObserver : IEventObserver;
  const AEventType: TEventType);
var
  i : Integer;
begin
  for i := Low(FObservers) to High(FObservers) do
    if (FObservers[i].Key   = AObserver)  and
       (FObservers[i].Value = AEventType) then
      FObservers[i].Key := nil;
end;

procedure TEventManager.Notify(
  const ASender   : IInterface;
  const AEventType: TEventType);
var
  i : Integer;
begin
  for i := Low(FObservers) to High(FObservers) do
    if (FObservers[i].Key   <> nil)       and
       (FObservers[i].Value = AEventType) then
      FObservers[i].Key.Update(ASender, AEventType);
end;

{------------------------------------------------------------------------------}
{ TSubject }
{------------------------------------------------------------------------------}

constructor TSubject.Create(
  AEventManager: IEventManager);
begin
  inherited Create();

  FEventManager := AEventManager;
end;

function TSubject.GetEvents(): IEventManager;
begin
  Result := FEventManager;
end;

{------------------------------------------------------------------------------}
{ TDatabase }
{------------------------------------------------------------------------------}

procedure TDatabase.Connect();
begin
  Writeln('Database: Somebody has connected');
  FEventManager.Notify(Self, evtConnect);
end;

procedure TDatabase.RaiseError();
begin
  Writeln('Database: Error occured');
  FEventManager.Notify(Self, evtError);
end;

{------------------------------------------------------------------------------}
{ TWebService }
{------------------------------------------------------------------------------}

procedure TWebService.Connect();
begin
  Writeln('Web Service: Somebody has connected');
  FEventManager.Notify(Self, evtConnect);
end;

procedure TWebService.RaiseError();
begin
  Writeln('Web Service: Error occured');
  FEventManager.Notify(Self, evtError);
end;

{------------------------------------------------------------------------------}
{ TObserverContext }
{------------------------------------------------------------------------------}

procedure TObserverContext.DoSomeWork();
var
  Evt         : TEventType;
  Database    : IDatabase;
  WebService  : IWebService;
  Logger      : IEventObserver;
  EmailSender : IEventObserver;
begin
  Database    := TDatabase.Create(TEventManager.Create());
  WebService  := TWebService.Create(TEventManager.Create());

  Logger      := TEventLogger.Create();
  EmailSender := TEventEmailSender.Create();

  Writeln('Context: Logger subscribes to all events');
  Writeln('Context: Email Sender subscribes to all events');
  for Evt := Low(TEventType) to High(TEventType) do
  begin
    Database  .Events.Subscribe(Logger, Evt);
    WebService.Events.Subscribe(Logger, Evt);
    Database  .Events.Subscribe(EmailSender, Evt);
    WebService.Events.Subscribe(EmailSender, Evt);
  end;

  Database.Connect();

  Writeln('Context: Email Sender unsubscribes from connect events');
  Database  .Events.Unsubscribe(EmailSender, evtConnect);
  WebService.Events.Unsubscribe(EmailSender, evtConnect);

  WebService.Connect();
  WebService.RaiseError();
end;

end.
