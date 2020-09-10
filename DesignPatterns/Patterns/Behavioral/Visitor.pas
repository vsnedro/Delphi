unit Visitor;

interface

uses
  System.Generics.Collections;

{$REGION ' Simple Example '}
type
  TMyDot = class;
  TMyShape = class;

  /// <summary>
  /// My Graphics Visitor
  /// </summary>
  IMyGraphicsVisitor = interface
    ['{ED00E8A4-B789-4C59-AB25-A740BEA4876E}']
    procedure Visit(
      const ADot : TMyDot); overload;
    procedure Visit(
      const AShape : TMyShape); overload;
  end;

  /// <summary>
  /// My Graphics
  /// </summary>
  IMyGraphics = interface
    ['{72A19DAD-0EB5-49F9-B06F-4DA61FBE2B6F}']
    procedure Accept(
      const AVisitor: IMyGraphicsVisitor);
  end;

  /// <summary>
  /// My Graphics Visitor
  /// </summary>
  TMyGraphicsVisitor = class(
    TInterfacedObject, IMyGraphicsVisitor)
    procedure Visit(
      const ADot : TMyDot); overload;
    procedure Visit(
      const AShape : TMyShape); overload;
  end;

  /// <summary>
  /// My Custom Graphics
  /// </summary>
  TMyCustomGraphics = class abstract(
    TInterfacedObject, IMyGraphics)
  private
    procedure Accept(
      const AVisitor: IMyGraphicsVisitor); virtual; abstract;
  end;

  /// <summary>
  /// My Dot
  /// </summary>
  TMyDot = class(TMyCustomGraphics)
  private
    procedure Accept(
      const AVisitor: IMyGraphicsVisitor); override;
  end;

  /// <summary>
  /// My Shape
  /// </summary>
  TMyShape = class(TMyCustomGraphics)
  private
    procedure Accept(
      const AVisitor: IMyGraphicsVisitor); override;
  end;
{$ENDREGION}

type
  /// <summary>
  /// Notification Policy (Visitor)
  /// </summary>
  INotificationPolicy = interface;

  /// <summary>
  /// Notification (Is visited by Visitor)
  /// </summary>
  INotification = interface
    ['{426C7254-52D9-4072-A6DE-C096D96B6217}']
    function GetSender() : String;
    function Accept(
      const ANotificationPolicy : INotificationPolicy) : Boolean;

    property Sender: String read GetSender;
  end;

  /// <summary>
  /// Some Email
  /// </summary>
  ISomeEmail = interface(INotification)
    ['{AAF1C56F-28C4-4D91-84C6-426B861227A7}']
  end;

  /// <summary>
  /// Some SMS
  /// </summary>
  ISomeSMS = interface(INotification)
    ['{36070228-8ADE-4BEE-B890-52DD158A9A89}']
  end;

  /// <summary>
  /// Some Push
  /// </summary>
  ISomePush = interface(INotification)
    ['{DB4843B3-14DB-450F-9742-B6B977D9E35E}']
  end;

  /// <summary>
  /// Notification Policy (Visitor)
  /// </summary>
  INotificationPolicy = interface
    ['{30B42E55-DF7C-4DDE-9E5B-42263C707D8C}']
    function Allowed(
      const ANotification : ISomeEmail) : Boolean; overload;
    function Allowed(
      const ANotification : ISomeSMS) : Boolean; overload;
    function Allowed(
      const ANotification : ISomePush) : Boolean; overload;
  end;

type
  /// <summary>
  /// Notification Client
  /// </summary>
  INotificationClient = interface
    ['{0308F788-6B86-4230-B6B1-952CA5F69A1E}']
    procedure GetSomeMessagesWithDefaultPolicy();
    procedure GetSomeMessagesWithNightPolicy();
  end;

{------------------------------------------------------------------------------}

type
  /// <summary>
  /// Custom Notification
  /// </summary>
  TCustomNotification = class abstract(
    TInterfacedObject, INotification)
  strict private
    FSender : String;
  private
    function GetSender() : String;
  protected
    function Accept(
      const ANotificationPolicy : INotificationPolicy) : Boolean; virtual; abstract;
  public
    constructor Create(
      const ASender : String);
  end;

type
  /// <summary>
  /// Some Email
  /// </summary>
  TSomeEmail = class(
    TCustomNotification, ISomeEmail)
  protected
    function Accept(
      const ANotificationPolicy : INotificationPolicy) : Boolean; override;
  end;

type
  /// <summary>
  /// Some SMS
  /// </summary>
  TSomeSMS = class(
    TCustomNotification, ISomeSMS)
  protected
    function Accept(
      const ANotificationPolicy : INotificationPolicy) : Boolean; override;
  end;

type
  /// <summary>
  /// Some Push
  /// </summary>
  TSomePush = class(
    TCustomNotification, ISomePush)
  protected
    function Accept(
      const ANotificationPolicy : INotificationPolicy) : Boolean; override;
  end;

type
  /// <summary>
  /// Default Notification Policy (Visitor)
  /// </summary>
  TDefaultNotificationPolicy = class(
    TInterfacedObject, INotificationPolicy)
  private
    function Allowed(
      const ANotification : ISomeEmail) : Boolean; overload;
    function Allowed(
      const ANotification : ISomeSMS) : Boolean; overload;
    function Allowed(
      const ANotification : ISomePush) : Boolean; overload;
  end;

type
  /// <summary>
  /// Night Notification Policy (Visitor)
  /// </summary>
  TNightNotificationPolicy = class(
    TInterfacedObject, INotificationPolicy)
  private
    function Allowed(
      const ANotification : ISomeEmail) : Boolean; overload;
    function Allowed(
      const ANotification : ISomeSMS) : Boolean; overload;
    function Allowed(
      const ANotification : ISomePush) : Boolean; overload;
  end;

type
  /// <summary>
  /// Blocklist Policy (Visitor)
  /// </summary>
  TBlocklistPolicy = class(
    TInterfacedObject, INotificationPolicy)
  strict private
    FBlockEmails : TList<String>;
    FBlockPhones : TList<String>;
    FBlockUsers  : TList<String>;
  private
    function Allowed(
      const ANotification : ISomeEmail) : Boolean; overload;
    function Allowed(
      const ANotification : ISomeSMS) : Boolean; overload;
    function Allowed(
      const ANotification : ISomePush) : Boolean; overload;
  public
    constructor Create(
      const ABlockEmails : TArray<String>;
      const ABlockPhones : TArray<String>;
      const ABlockUsers  : TArray<String>);
    destructor  Destroy(); override;
  end;

type
  /// <summary>
  /// Notification Client
  /// </summary>
  TNotificationClient = class(
    TInterfacedObject, INotificationClient)
  private
    procedure GetSomeMessagesWithDefaultPolicy();
    procedure GetSomeMessagesWithNightPolicy();
  private
    function CreateSomeMessages() : TList<INotification>;
  end;

implementation

uses
  System.SysUtils;

{$REGION ' Simple Example '}
{------------------------------------------------------------------------------}
{ TMyGraphicsVisitor }
{------------------------------------------------------------------------------}

procedure TMyGraphicsVisitor.Visit(
  const AShape: TMyShape);
begin
  Writeln('Shape is visited');
end;

procedure TMyGraphicsVisitor.Visit(
  const ADot: TMyDot);
begin
  Writeln('Dot is visited');
end;

{------------------------------------------------------------------------------}
{ TMyDot }
{------------------------------------------------------------------------------}

procedure TMyDot.Accept(
  const AVisitor: IMyGraphicsVisitor);
begin
  AVisitor.Visit(Self);
end;

{------------------------------------------------------------------------------}
{ TMyShape }
{------------------------------------------------------------------------------}

procedure TMyShape.Accept(
  const AVisitor: IMyGraphicsVisitor);
begin
  AVisitor.Visit(Self);
end;
{$ENDREGION}

{------------------------------------------------------------------------------}
{ TCustomNotification }
{------------------------------------------------------------------------------}

constructor TCustomNotification.Create(
  const ASender: String);
begin
  inherited Create();

  FSender := ASender;
end;

function TCustomNotification.GetSender(): String;
begin
  Result := FSender;
end;

{------------------------------------------------------------------------------}
{ TSomeEmail }
{------------------------------------------------------------------------------}

function TSomeEmail.Accept(
  const ANotificationPolicy: INotificationPolicy): Boolean;
begin
  Result := ANotificationPolicy.Allowed(Self as ISomeEmail);
end;

{------------------------------------------------------------------------------}
{ TSomeSMS }
{------------------------------------------------------------------------------}

function TSomeSMS.Accept(
  const ANotificationPolicy: INotificationPolicy): Boolean;
begin
  Result := ANotificationPolicy.Allowed(Self as ISomeSMS);
end;

{------------------------------------------------------------------------------}
{ TSomePush }
{------------------------------------------------------------------------------}

function TSomePush.Accept(
  const ANotificationPolicy: INotificationPolicy): Boolean;
begin
  Result := ANotificationPolicy.Allowed(Self as ISomePush);
end;

{------------------------------------------------------------------------------}
{ TDefaultNotificationPolicy }
{------------------------------------------------------------------------------}

function TDefaultNotificationPolicy.Allowed(
  const ANotification: ISomeEmail): Boolean;
begin
  Result := True;
end;

function TDefaultNotificationPolicy.Allowed(
  const ANotification: ISomeSMS): Boolean;
begin
  Result := True;
end;

function TDefaultNotificationPolicy.Allowed(
  const ANotification: ISomePush): Boolean;
begin
  Result := True;
end;

{------------------------------------------------------------------------------}
{ TNightNotificationPolicy }
{------------------------------------------------------------------------------}

function TNightNotificationPolicy.Allowed(
  const ANotification: ISomeEmail): Boolean;
begin
  Result := False;
end;

function TNightNotificationPolicy.Allowed(
  const ANotification: ISomeSMS): Boolean;
begin
  Result := True;
end;

function TNightNotificationPolicy.Allowed(
  const ANotification: ISomePush): Boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TBlocklistPolicy }
{------------------------------------------------------------------------------}

constructor TBlocklistPolicy.Create(
  const ABlockEmails : TArray<String>;
  const ABlockPhones : TArray<String>;
  const ABlockUsers  : TArray<String>);
var
  S : String;
begin
  inherited Create();

  FBlockEmails := TList<String>.Create();
  FBlockPhones := TList<String>.Create();
  FBlockUsers  := TList<String>.Create();

  for S in ABlockEmails do
    FBlockEmails.Add(S);
  for S in ABlockPhones do
    FBlockPhones.Add(S);
  for S in ABlockUsers do
    FBlockUsers.Add(S);
end;

destructor TBlocklistPolicy.Destroy();
begin
  FreeAndNil(FBlockUsers);
  FreeAndNil(FBlockPhones);
  FreeAndNil(FBlockEmails);

  inherited;
end;

function TBlocklistPolicy.Allowed(
  const ANotification: ISomeEmail): Boolean;
begin
  Result := not FBlockEmails.Contains(ANotification.Sender);
end;

function TBlocklistPolicy.Allowed(
  const ANotification: ISomeSMS): Boolean;
begin
  Result := not FBlockPhones.Contains(ANotification.Sender);
end;

function TBlocklistPolicy.Allowed(
  const ANotification: ISomePush): Boolean;
begin
  Result := not FBlockUsers.Contains(ANotification.Sender);
end;

{------------------------------------------------------------------------------}
{ TNotificationClient }
{------------------------------------------------------------------------------}

procedure TNotificationClient.GetSomeMessagesWithDefaultPolicy();
var
  DefaultNotificationPolicy : INotificationPolicy;
  BlocklistPolicy           : INotificationPolicy;
  Messages                  : TList<INotification>;
  Notification              : INotification;
begin
  DefaultNotificationPolicy := TDefaultNotificationPolicy.Create();
  BlocklistPolicy           := TBlocklistPolicy.Create(
    ['spammer@spam.com'], ['999000000'], ['NotFriend']);

  Writeln('Client: Now I am using default notification policy and blocklist policy');

  Messages := CreateSomeMessages();
  try
    for Notification in Messages do
      if not Notification.Accept(BlocklistPolicy) then
        Writeln(Format('Client: Message from %s is blocked', [Notification.Sender]))
      else
      if Notification.Accept(DefaultNotificationPolicy) then
        Writeln(Format('Client: Notification for message from %s will be shown', [Notification.Sender]))
      else
        Writeln(Format('Client: Notification for message from %s will be silenced', [Notification.Sender]));
  finally
    FreeAndNil(Messages);
  end;
end;

procedure TNotificationClient.GetSomeMessagesWithNightPolicy();
var
  NightNotificationPolicy : INotificationPolicy;
  BlocklistPolicy         : INotificationPolicy;
  Messages                : TList<INotification>;
  Notification            : INotification;
begin
  NightNotificationPolicy := TNightNotificationPolicy.Create();
  BlocklistPolicy         := TBlocklistPolicy.Create(
    ['spammer@spam.com'], ['999000000'], ['NotFriend']);

  Writeln('Client: Now I am using night notification policy and blocklist policy');

  Messages := CreateSomeMessages();
  try
    for Notification in Messages do
      if not Notification.Accept(BlocklistPolicy) then
        Writeln(Format('Client: Message from %s is blocked', [Notification.Sender]))
      else
      if Notification.Accept(NightNotificationPolicy) then
        Writeln(Format('Client: Notification for message from %s will be shown', [Notification.Sender]))
      else
        Writeln(Format('Client: Notification for message from %s will be silenced', [Notification.Sender]));
  finally
    FreeAndNil(Messages);
  end;

end;

function TNotificationClient.CreateSomeMessages(): TList<INotification>;
begin
  Result := TList<INotification>.Create();
  try
    Result.Add(TSomeEmail.Create('bender@ilovebender.com'));
    Result.Add(TSomeEmail.Create('spammer@spam.com'));
    Result.Add(TSomeSMS  .Create('123000000'));
    Result.Add(TSomeSMS  .Create('999000000'));
    Result.Add(TSomePush .Create('Friend'));
    Result.Add(TSomePush .Create('NotFriend'));
  except
    FreeAndNil(Result);
    raise;
  end;
end;

end.
