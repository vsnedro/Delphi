unit Proxy;

interface

{$REGION ' Web Service '}
type
  /// <summary>
  /// Web Service
  /// </summary>
  IWebService = interface
    procedure Upload(
      const ADocument : String);
    function Download(
      const AID : Integer) : String;
  end;

type
  /// <summary>
  /// Web Service
  /// </summary>
  TWebService = class(
    TInterfacedObject,
    IWebService)
  private
    procedure Upload(
      const ADocument : String);
    function Download(
      const AID : Integer) : String;
  end;

type
  /// <summary>
  /// Web Service Proxy
  /// </summary>
  TWebServiceProxy = class(
    TInterfacedObject,
    IWebService)
  strict private
    type
      TWebServiceCache = record
        ID       : Integer;
        Document : String;
      end;
  strict private
    FWebService : IWebService;
    FWebServiceCache : TWebServiceCache;
  private
    procedure Upload(
      const ADocument : String);
    function Download(
      const AID : Integer) : String;
  public
    constructor Create(
      AWebService : IWebService = nil);
  end;
{$ENDREGION}

type
  /// <summary>
  /// User Profile
  /// </summary>
  TUserProfile = record
    ID    : Integer;
    Name  : String;
    Email : String;
  end;

type
  /// <summary>
  /// Profile Service
  /// </summary>
  IProfileService = interface
    function LoadProfile(
      const AID      : Integer;
      const APrivate : Boolean) : TUserProfile;
  end;

type
  /// <summary>
  /// Profile Client
  /// </summary>
  IProfileClient = interface
    function GetProfile(
      const AID      : Integer;
      const APrivate : Boolean) : TUserProfile;
  end;

type
  /// <summary>
  /// Profile Service
  /// </summary>
  TProfileService = class(
    TInterfacedObject, IProfileService)
  strict private
  const
    FProfiles : array [0..2] of TUserProfile = (
      (ID    : 1;
       Name  : 'Коля';
       Email : 'kolya@gmail.com'),
      (ID    : 2;
       Name  : 'Петя';
       Email : 'petr_123@gmail.com'),
      (ID    : 3;
       Name  : 'Маша';
       Email : 'mary_2000@gmail.com')
    );
  private
    function LoadProfile(
      const AID      : Integer;
      const APrivate : Boolean) : TUserProfile;
  end;

type
  /// <summary>
  /// Profile Proxy
  /// </summary>
  TProfileProxy = class(
    TInterfacedObject, IProfileService)
  strict private
    FProfileService : IProfileService;
  private
    function LoadProfile(
      const AID      : Integer;
      const APrivate : Boolean) : TUserProfile;
  public
    constructor Create(
      const AProfileService : IProfileService);
  end;

type
  /// <summary>
  /// Profile Client
  /// </summary>
  TProfileClient = class(
    TInterfacedObject, IProfileClient)
  strict private
    FProfileService : IProfileService;
  private
    function GetProfile(
      const AID      : Integer;
      const APrivate : Boolean) : TUserProfile;
  public
    constructor Create(
      const AProfileService : IProfileService);
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils;

{$REGION ' Web Service '}
{------------------------------------------------------------------------------}
{ TWebService }
{------------------------------------------------------------------------------}

function TWebService.Download(
  const AID: Integer): String;
begin
  Result := 'Document ' + AID.ToString();
  Writeln('Web service download = ' + Result);
end;

procedure TWebService.Upload(
  const ADocument: String);
begin
  Writeln('Web service download = ' + ADocument);
end;

{------------------------------------------------------------------------------}
{ TWebServiceProxy }
{------------------------------------------------------------------------------}

constructor TWebServiceProxy.Create(
  AWebService: IWebService = nil);
begin
  inherited Create();

  FWebService := AWebService;
end;

function TWebServiceProxy.Download(
  const AID: Integer): String;
begin
  if not Assigned(FWebService) then
  begin
    FWebService := TWebService.Create();
    Writeln('Lazy initialization of web service at download');
  end;

  if (FWebServiceCache.ID = AID) then
  begin
    Result := FWebServiceCache.Document;
    Writeln('Web service proxy download = ' + Result);
  end
  else
  begin
    Result := FWebService.Download(AID);
    FWebServiceCache.ID       := AID;
    FWebServiceCache.Document := Result;
    Writeln('Web service proxy cache = ' + Result);
  end;
end;

procedure TWebServiceProxy.Upload(
  const ADocument: String);
begin
  if not Assigned(FWebService) then
  begin
    FWebService := TWebService.Create();
    Writeln('Lazy initialization of web service at upload');
  end;

  FWebService.Upload(ADocument);
end;
{$ENDREGION}

{------------------------------------------------------------------------------}
{ TProfileProxy }
{------------------------------------------------------------------------------}

constructor TProfileProxy.Create(
  const AProfileService : IProfileService);
begin
  inherited Create();

  FProfileService := AProfileService;
end;

function TProfileProxy.LoadProfile(
  const AID      : Integer;
  const APrivate : Boolean): TUserProfile;
begin
  Writeln('Proxy is working');

  if APrivate then
  begin
    Writeln('Access check is required');
    case AID of
      1 :
        Writeln('Access denied');
      2 :
        begin
          Writeln('Access restricted');
          Result := FProfileService.LoadProfile(AID, False);
        end
      else
        begin
          Writeln('Access granted');
          Result := FProfileService.LoadProfile(AID, APrivate);
        end;
    end;
  end
  else
  begin
    Writeln('Access check is not required');
    Result := FProfileService.LoadProfile(AID, APrivate);
  end;
end;

{------------------------------------------------------------------------------}
{ TProfileService }
{------------------------------------------------------------------------------}

function TProfileService.LoadProfile(
  const AID      : Integer;
  const APrivate : Boolean): TUserProfile;
var
  i : Integer;
begin
  Writeln('Profile service is working');

  for i := Low(FProfiles) to High(FProfiles) do
    if (FProfiles[i].ID = AID) then
    begin
      Result := FProfiles[i];
      if not APrivate then
        Result.Email := '***';
      Break;
    end;

  Writeln('Profile service is complete');
end;

{------------------------------------------------------------------------------}
{ TProfileClient }
{------------------------------------------------------------------------------}

constructor TProfileClient.Create(
  const AProfileService: IProfileService);
begin
  inherited Create();

  FProfileService := AProfileService;
end;

function TProfileClient.GetProfile(
  const AID      : Integer;
  const APrivate : Boolean): TUserProfile;
begin
  Writeln(
    'Let''s get profile for ID = ' + AID.ToString() +
    ' with ' + IfThen(APrivate, 'private', 'non-private') + ' access');

  Result := FProfileService.LoadProfile(AID, APrivate);

  Writeln('Profile is loaded');
  Writeln('Name: ' + Result.Name);
  Writeln('Email: ' + Result.Email);
  Writeln('');
end;

end.
