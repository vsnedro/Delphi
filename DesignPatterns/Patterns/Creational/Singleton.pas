unit Singleton;

interface

uses
  System.SyncObjs,
  System.Generics.Collections;

type
  /// <summary>
  /// Message Subscriber
  /// </summary>
  IMessageSubscriber = interface
    procedure Accept(
      const AMessage : String);
    procedure StartReceiveingMessages();
  end;

type
  /// <summary>
  /// Friend Chat Service (Singleton)
  /// </summary>
  TFriendChatService = class
  strict private
  class var
    FChat : TFriendChatService;
    FLock : TCriticalSection;
  private
    FSubscribers : TList<IMessageSubscriber>;

    constructor Create();
    destructor  Destroy(); override;
  public
    class function GetInstance() : TFriendChatService;

    procedure AddSubsriber(
      const ASubscriber : IMessageSubscriber);

    procedure SendMessages();
  end;

type
  /// <summary>
  /// Base VC
  /// </summary>
  TBaseVC = class abstract(
    TInterfacedObject, IMessageSubscriber)
    procedure Accept(
      const AMessage : String); virtual; abstract;
    procedure StartReceiveingMessages();
  end;

type
  /// <summary>
  /// Message List VC
  /// </summary>
  TMessageListVC = class(TBaseVC)
    procedure Accept(
      const AMessage : String); override;
  end;

type
  /// <summary>
  /// Private Chat VC
  /// </summary>
  TPrivateChatVC = class(TBaseVC)
    procedure Accept(
      const AMessage : String); override;
  end;

implementation

uses
  System.SysUtils,
  Winapi.Windows;

{------------------------------------------------------------------------------}
{ TFriendChatService }
{------------------------------------------------------------------------------}

constructor TFriendChatService.Create();
begin
  inherited Create();

  FLock        := TCriticalSection.Create();
  FSubscribers := TList<IMessageSubscriber>.Create();
end;

destructor TFriendChatService.Destroy();
begin
  FreeAndNil(FSubscribers);
  FreeAndNil(FLock);

  inherited Destroy();
end;

class function TFriendChatService.GetInstance(): TFriendChatService;
var
  H : THandle;
begin
  H := Winapi.Windows.CreateMutex(nil, True, PChar('{92AB66E8-5761-4598-B7C6-C8EAB124E18C}'));
  while (Winapi.Windows.GetLastError() = Winapi.Windows.ERROR_ALREADY_EXISTS) do
  begin
    CloseHandle(H);
    H := Winapi.Windows.CreateMutex(nil, True, PChar('{92AB66E8-5761-4598-B7C6-C8EAB124E18C}'));
  end;

  if not Assigned(FChat) then
    FChat := TFriendChatService.Create();

  ReleaseMutex(H);
  CloseHandle(H);

  Result := FChat;
end;

procedure TFriendChatService.SendMessages();
var
  i : Integer;
begin
  for i := 0 to FSubscribers.Count - 1 do
  begin
    FSubscribers[i].Accept('Hello!');
    FSubscribers[i].Accept('Привет!');
  end;
end;

procedure TFriendChatService.AddSubsriber(
  const ASubscriber: IMessageSubscriber);
begin
  FSubscribers.Add(ASubscriber);
end;

{------------------------------------------------------------------------------}
{ TBaseVC }
{------------------------------------------------------------------------------}

procedure TBaseVC.StartReceiveingMessages();
begin
  TFriendChatService.GetInstance().AddSubsriber(Self);
end;

{------------------------------------------------------------------------------}
{ TMessageListVC }
{------------------------------------------------------------------------------}

procedure TMessageListVC.Accept(
  const AMessage: String);
begin
  Writeln('MessageList received message ' + AMessage);
end;

{------------------------------------------------------------------------------}
{ TPrivateChatVC }
{------------------------------------------------------------------------------}

procedure TPrivateChatVC.Accept(
  const AMessage: String);
begin
  Writeln('PrivateChat received message ' + AMessage);
end;

end.
