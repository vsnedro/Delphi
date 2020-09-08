unit Iterator;

interface

uses
  System.Generics.Collections;

type
  /// <summary>
  /// Social Profile
  /// </summary>
  ISocialProfile = interface
    ['{385D820A-6281-4CDE-B8BE-B82958AFC8A2}']
    function GetName() : String;
    function GetEmail() : String;

    property Name: String read GetName;
    property Email: String read GetEmail;
  end;

type
  /// <summary>
  /// Social Profile Iterator
  /// </summary>
  ISocialProfileIterator = interface
    ['{BF6D4CCA-8ECA-4885-9612-1355021F157C}']
    function HasMore() : Boolean;
    function Next() : ISocialProfile;
  end;

type
  /// <summary>
  /// Social Network
  /// </summary>
  ISocialNetwork = interface
    ['{B6DAD709-F7D2-4E1A-B090-B033E330A473}']
    function CreateFriendsIterator() : ISocialProfileIterator;
    function CreateEnemiesIterator() : ISocialProfileIterator;

    function GetProfiles() : TList<ISocialProfile>;
  end;

type
  /// <summary>
  /// Social Spammer
  /// </summary>
  ISocialSpammer = interface
    ['{FC77471F-54B3-4BC7-8C0B-99695A677536}']
    procedure SendMessage(
      const AProfile : ISocialProfile;
      const AMessage : String);
  end;

type
  /// <summary>
  /// Social Client
  /// </summary>
  ISocialClient = interface
    ['{96090927-92A3-4B89-89A2-5D61A6670BB0}']
    procedure SendMessagesToFriends();
    procedure SendMessagesToEnemies();
  end;

{------------------------------------------------------------------------------}

type
  /// <summary>
  /// Social Profile
  /// </summary>
  TSocialProfile = class(
    TInterfacedObject, ISocialProfile)
  strict private
    FName : String;
    FEmail: String;
   private
    function GetName() : String;
    function GetEmail() : String;
  public
    constructor Create(
      const AName  : String;
      const AEmail : String);
  end;

type
  /// <summary>
  /// Social Profile Iterator
  /// </summary>
  TSocialProfileCustomIterator = class abstract(
    TInterfacedObject, ISocialProfileIterator)
  strict private
    FSocialNetwork : ISocialNetwork;
    FCurrentIndex  : Integer;
  private
    function HasMore() : Boolean;
    function Next() : ISocialProfile; virtual;
  strict protected
    FProfiles : TList<ISocialProfile>;

    procedure LazyInit(); virtual;
  public
    constructor Create(
      const ASocialNetwork : ISocialNetwork);
    destructor  Destroy() ; override;
  end;

type
  /// <summary>
  /// Social Profile Friends Iterator
  /// </summary>
  TSocialProfileFriendsIterator = class(TSocialProfileCustomIterator)
  private
    function Next() : ISocialProfile; override;
  strict protected
    procedure LazyInit(); override;
  end;

type
  /// <summary>
  /// Social Profile Enemies Iterator
  /// </summary>
  TSocialProfileEnemiesIterator = class(TSocialProfileCustomIterator)
  private
    function Next() : ISocialProfile; override;
  strict protected
    procedure LazyInit(); override;
  end;

type
  /// <summary>
  /// Social Custom Network
  /// </summary>
  TSocialCustomNetwork = class abstract(
    TInterfacedObject, ISocialNetwork)
  private
    function CreateFriendsIterator() : ISocialProfileIterator;
    function CreateEnemiesIterator() : ISocialProfileIterator;

    function GetProfiles() : TList<ISocialProfile>; virtual; abstract;
  end;

type
  /// <summary>
  /// Facebook Network
  /// </summary>
  TFacebookNetwork = class(TSocialCustomNetwork)
  private
    function GetProfiles() : TList<ISocialProfile>; override;
  end;

type
  /// <summary>
  /// LinkedIn Network
  /// </summary>
  TLinkedInNetwork = class(TSocialCustomNetwork)
  private
    function GetProfiles() : TList<ISocialProfile>; override;
  end;

type
  /// <summary>
  /// Social Spammer
  /// </summary>
  TSocialSpammer = class(
    TInterfacedObject, ISocialSpammer)
  private
    procedure SendMessage(
      const AProfile : ISocialProfile;
      const AMessage : String);
  end;

type
  /// <summary>
  /// Social Client
  /// </summary>
  TSocialClient = class(
    TInterfacedObject, ISocialClient)
  strict private
    FSocialSpammer : ISocialSpammer;
  private
    procedure SendMessagesToFriends();
    procedure SendMessagesToEnemies();
  public
    constructor Create(
      const ASocialSpammer : ISocialSpammer);
  end;

implementation

uses
  System.SysUtils;

{------------------------------------------------------------------------------}
{ TSocialProfile }
{------------------------------------------------------------------------------}

constructor TSocialProfile.Create(
  const AName  : String;
  const AEmail : String);
begin
  inherited Create();

  FName  := AName;
  FEmail := AEmail;
end;

function TSocialProfile.GetName(): String;
begin
  Result := FName;
end;

function TSocialProfile.GetEmail(): String;
begin
  Result := FEmail;
end;

{------------------------------------------------------------------------------}
{ TSocialProfileCustomIterator }
{------------------------------------------------------------------------------}

constructor TSocialProfileCustomIterator.Create(
  const ASocialNetwork: ISocialNetwork);
begin
  inherited Create();

  FSocialNetwork := ASocialNetwork;
end;

destructor TSocialProfileCustomIterator.Destroy();
begin
  FreeAndNil(FProfiles);

  inherited Destroy();
end;

function TSocialProfileCustomIterator.HasMore(): Boolean;
begin
  LazyInit();
  Result := FCurrentIndex < FProfiles.Count;
end;

function TSocialProfileCustomIterator.Next(): ISocialProfile;
begin
  if HasMore() then
  begin
    Result := FProfiles[FCurrentIndex];
    Inc(FCurrentIndex);
  end
  else
    Result := nil;
end;

procedure TSocialProfileCustomIterator.LazyInit();
begin
  if not Assigned(FProfiles) then
    FProfiles := FSocialNetwork.GetProfiles();
end;

{------------------------------------------------------------------------------}
{ TSocialProfileFriendsIterator }
{------------------------------------------------------------------------------}

function TSocialProfileFriendsIterator.Next(): ISocialProfile;
begin
  Result := inherited Next();
  while Assigned(Result) and (not Result.Name.Contains('Good')) do
    Result := inherited Next();
end;

procedure TSocialProfileFriendsIterator.LazyInit();
var
  i : Integer;
begin
  if not Assigned(FProfiles) then
  begin
    inherited LazyInit();
    for i := FProfiles.Count - 1 downto 0 do
    if not FProfiles[i].Name.Contains('Good') then
      FProfiles.Delete(i);
  end;
end;

{------------------------------------------------------------------------------}
{ TSocialProfileEnemiesIterator }
{------------------------------------------------------------------------------}

function TSocialProfileEnemiesIterator.Next(): ISocialProfile;
begin
  Result := inherited Next();
  while Assigned(Result) and (not Result.Name.Contains('Bad')) do
    Result := inherited Next();
end;

procedure TSocialProfileEnemiesIterator.LazyInit();
var
  i : Integer;
begin
  if not Assigned(FProfiles) then
  begin
    inherited LazyInit();
    for i := FProfiles.Count - 1 downto 0 do
    if not FProfiles[i].Name.Contains('Bad') then
      FProfiles.Delete(i);
  end;
end;

{------------------------------------------------------------------------------}
{ TSocialCustomNetwork }
{------------------------------------------------------------------------------}

function TSocialCustomNetwork.CreateFriendsIterator(): ISocialProfileIterator;
begin
  Result := TSocialProfileFriendsIterator.Create(Self);
end;

function TSocialCustomNetwork.CreateEnemiesIterator(): ISocialProfileIterator;
begin
  Result := TSocialProfileEnemiesIterator.Create(Self);
end;

{------------------------------------------------------------------------------}
{ TFacebookNetwork }
{------------------------------------------------------------------------------}

function TFacebookNetwork.GetProfiles: TList<ISocialProfile>;
begin
  Result := TList<ISocialProfile>.Create();

  Result.Add(TSocialProfile.Create('Bad Guy 1', 'bill@microsoft.com'));
  Result.Add(TSocialProfile.Create('Bad Guy 2', 'john@apple.com'));
  Result.Add(TSocialProfile.Create('Good Guy 1', 'jack@microsoft.com'));
  Result.Add(TSocialProfile.Create('Good Guy 2', 'alex@apple.com'));
  Result.Add(TSocialProfile.Create('Bender', 'bender@ilovebender.com'));
end;

{------------------------------------------------------------------------------}
{ TLinkedInNetwork }
{------------------------------------------------------------------------------}

function TLinkedInNetwork.GetProfiles(): TList<ISocialProfile>;
begin
  Result := TList<ISocialProfile>.Create();

  Result.Add(TSocialProfile.Create('Bad Girl 1', 'ann@google.com'));
  Result.Add(TSocialProfile.Create('Bad Girl 2', 'mary@yandex.com'));
  Result.Add(TSocialProfile.Create('Good Girl 1', 'lucy@google.com'));
  Result.Add(TSocialProfile.Create('Good Girl 2', 'katy@yandex.com'));
  Result.Add(TSocialProfile.Create('Bender', 'bender@ilovebender.com'));
end;

{------------------------------------------------------------------------------}
{ TSocialSpammer }
{------------------------------------------------------------------------------}

procedure TSocialSpammer.SendMessage(
  const AProfile: ISocialProfile;
  const AMessage: String);
begin
  Writeln(Format(
    'E-mail was sent to %s: Hello, %s, %s',
    [AProfile.Email, AProfile.Name, AMessage]));
end;

{------------------------------------------------------------------------------}
{ TSocialClient }
{------------------------------------------------------------------------------}

constructor TSocialClient.Create(
  const ASocialSpammer: ISocialSpammer);
begin
  inherited Create();

  FSocialSpammer := ASocialSpammer;
end;

procedure TSocialClient.SendMessagesToFriends();
var
  Facebook        : ISocialNetwork;
  LinkedIn        : ISocialNetwork;
  ProfileIterator : ISocialProfileIterator;
begin
  Facebook := TFacebookNetwork.Create();
  LinkedIn := TLinkedInNetwork.Create();

  Writeln('Client: Now I want to send message to all my friends');
  ProfileIterator := Facebook.CreateFriendsIterator();
  while ProfileIterator.HasMore() do
    FSocialSpammer.SendMessage(ProfileIterator.Next(), 'I like you!');
  ProfileIterator := LinkedIn.CreateFriendsIterator();
  while ProfileIterator.HasMore() do
    FSocialSpammer.SendMessage(ProfileIterator.Next(), 'I like you!');
end;

procedure TSocialClient.SendMessagesToEnemies();
var
  Facebook        : ISocialNetwork;
  LinkedIn        : ISocialNetwork;
  ProfileIterator : ISocialProfileIterator;
begin
  Facebook := TFacebookNetwork.Create();
  LinkedIn := TLinkedInNetwork.Create();

  Writeln('Client: Now I want to send message to all my enemies');
  ProfileIterator := Facebook.CreateEnemiesIterator();
  while ProfileIterator.HasMore() do
    FSocialSpammer.SendMessage(ProfileIterator.Next(), 'I do not like you!');
  ProfileIterator := LinkedIn.CreateEnemiesIterator();
  while ProfileIterator.HasMore() do
    FSocialSpammer.SendMessage(ProfileIterator.Next(), 'I do not like you!');
end;

end.
