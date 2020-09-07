unit ChainOfResponsibility;

interface

type
  /// <summary>
  /// Handler
  /// </summary>
  IHandler = interface
    ['{5D73C6F3-2D03-49D1-813D-3962AB7DACF9}']
    function SetNextHandler(
      const AHandler : IHandler) : IHandler;
    function Handle(
      const ARequest : String) : String;
  end;

type
  /// <summary>
  /// Handler
  /// </summary>
  TCustomHandler = class abstract(
    TInterfacedObject, IHandler)
  strict private
    FNextHandler : IHandler;
  private
    function SetNextHandler(
      const AHandler : IHandler) : IHandler;
  protected
    function Handle(
      const ARequest : String) : String; virtual;
  end;

type
  /// <summary>
  /// Monkey Handler
  /// </summary>
  TMonkeyHandler = class(TCustomHandler)
    function Handle(
      const ARequest : String) : String; override;
  end;

type
  /// <summary>
  /// Squirrel Handler
  /// </summary>
  TSquirrelHandler = class(TCustomHandler)
    function Handle(
      const ARequest : String) : String; override;
  end;

type
  /// <summary>
  /// Dog Handler
  /// </summary>
  TDogHandler = class(TCustomHandler)
    function Handle(
      const ARequest : String) : String; override;
  end;

type
  /// <summary>
  /// Handler Client
  /// </summary>
  IHandlerClient = interface
    ['{D5D9D230-30A2-4FCE-B3C7-1CFFEC3349A6}']
    procedure Feed(
      const AFood    : String;
      const AHandler : IHandler);
  end;

type
  /// <summary>
  /// Handler Client
  /// </summary>
  THandlerClient = class(
    TInterfacedObject, IHandlerClient)
  private
    procedure Feed(
      const AFood    : String;
      const AHandler : IHandler);
  end;

{==============================================================================}

type
  /// <summary>
  /// Web Service Handler
  /// </summary>
  IWebServiceHandler = interface
    ['{832201BC-078A-47ED-91A5-999B2E3444A5}']
    function SetNextHandler(
      const AHandler : IWebServiceHandler) : IWebServiceHandler;
    function Handle(
      const ALogin    : String;
      const APassword : String) : String;
  end;

type
  /// <summary>
  /// Web Service Handler
  /// </summary>
  TWebServiceCustomHandler = class abstract(
    TInterfacedObject, IWebServiceHandler)
  strict private
    FNextHandler : IWebServiceHandler;
  private
    function SetNextHandler(
      const AHandler : IWebServiceHandler) : IWebServiceHandler;
  protected
    function Handle(
      const ALogin    : String;
      const APassword : String) : String; virtual;
  end;

type
  /// <summary>
  /// Auth Web Service Handler
  /// </summary>
  TAuthWebServiceHandler = class(TWebServiceCustomHandler)
  protected
    function Handle(
      const ALogin    : String;
      const APassword : String) : String; override;
  end;

type
  /// <summary>
  /// Access Web Service Handler
  /// </summary>
  TAccessWebServiceHandler = class(TWebServiceCustomHandler)
  protected
    function Handle(
      const ALogin    : String;
      const APassword : String) : String; override;
  end;

type
  /// <summary>
  /// Web Service Handler Client
  /// </summary>
  IWebServiceHandlerClient = interface
    ['{11539E76-A9A5-410F-B406-9BE6F441E06F}']
    procedure Connect(
      const ALogin    : String;
      const APassword : String;
      const AHandler  : IWebServiceHandler);
  end;

type
  /// <summary>
  /// Web Service Handler Client
  /// </summary>
  TWebServiceHandlerClient = class(
    TInterfacedObject, IWebServiceHandlerClient)
  private
    procedure Connect(
      const ALogin    : String;
      const APassword : String;
      const AHandler  : IWebServiceHandler);
  end;

implementation

uses
  System.SysUtils;

{------------------------------------------------------------------------------}
{ TCustomHandler }
{------------------------------------------------------------------------------}

function TCustomHandler.SetNextHandler(
  const AHandler: IHandler): IHandler;
begin
  FNextHandler := AHandler;
  Result       := AHandler;
end;

function TCustomHandler.Handle(
  const ARequest: String): String;
begin
  Result := '';

  if Assigned(FNextHandler) then
    Result := FNextHandler.Handle(ARequest);
end;

{------------------------------------------------------------------------------}
{ TMonkeyHandler }
{------------------------------------------------------------------------------}

function TMonkeyHandler.Handle(
  const ARequest: String): String;
begin
  if AnsiSameText(ARequest, 'Banana') then
    Result := 'Monkey: I''ll eat the ' + ARequest
  else
    Result := inherited Handle(ARequest);
end;

{------------------------------------------------------------------------------}
{ TSquirrelHandler }
{------------------------------------------------------------------------------}

function TSquirrelHandler.Handle(
  const ARequest: String): String;
begin
  if AnsiSameText(ARequest, 'Nuts') then
    Result := 'Squirrel: I''ll eat the ' + ARequest
  else
    Result := inherited Handle(ARequest);
end;

{------------------------------------------------------------------------------}
{ TDogHandler }
{------------------------------------------------------------------------------}

function TDogHandler.Handle(
  const ARequest: String): String;
begin
  if AnsiSameText(ARequest, 'Meat') then
    Result := 'Dog: I''ll eat the ' + ARequest
  else
    Result := inherited Handle(ARequest);
end;

{------------------------------------------------------------------------------}
{ THandlerClient }
{------------------------------------------------------------------------------}

procedure THandlerClient.Feed(
  const AFood: String;
  const AHandler: IHandler);
var
  S : String;
begin
  Writeln(Format('Client: Who wants a %s?', [AFood]));
  S := AHandler.Handle(AFood);
  if (S.Length <= 0) then
    Writeln(AFood + ' was left untouched')
  else
    Writeln(S);
end;

{==============================================================================}

{------------------------------------------------------------------------------}
{ TWebServiceCustomHandler }
{------------------------------------------------------------------------------}

function TWebServiceCustomHandler.SetNextHandler(
  const AHandler: IWebServiceHandler): IWebServiceHandler;
begin
  FNextHandler := AHandler;
  Result       := AHandler;
end;

function TWebServiceCustomHandler.Handle(
  const ALogin    : String;
  const APassword : String): String;
begin
  Result := '';

  if Assigned(FNextHandler) then
    Result := FNextHandler.Handle(ALogin, APassword);
end;

{------------------------------------------------------------------------------}
{ TAuthWebServiceHandler }
{------------------------------------------------------------------------------}

function TAuthWebServiceHandler.Handle(
  const ALogin    : String;
  const APassword : String): String;
begin
  Result := 'Authorization...';

  if (ALogin.Equals('admin')  and APassword.Equals('123456')) or
     (ALogin.Equals('Alex')   and APassword.Equals('111'))    or
     (ALogin.Equals('Justas') and APassword.Equals('222'))    then
    Result := Result + ' Access granted.' + sLineBreak + inherited Handle(ALogin, APassword)
  else
    Result := Result + ' Access denied.';
end;

{------------------------------------------------------------------------------}
{ TAccessWebServiceHandler }
{------------------------------------------------------------------------------}

function TAccessWebServiceHandler.Handle(
  const ALogin    : String;
  const APassword : String): String;
begin
  Result := 'Access rights...';

  if ALogin.Equals('admin') then
    Result := Result + ' Administrator rights granted.'
  else
    Result := Result + ' User rights granted.';
end;

{ TWebServiceHandlerClient }

procedure TWebServiceHandlerClient.Connect(
  const ALogin    : String;
  const APassword : String;
  const AHandler  : IWebServiceHandler);
begin
  Writeln('Web Service Client: Try to connect for ' + ALogin);
  Writeln(AHandler.Handle(ALogin, APassword));
end;

end.
