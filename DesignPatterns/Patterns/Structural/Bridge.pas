unit Bridge;

interface

uses
  System.Classes;

type
  /// <summary>
  /// Remote
  /// </summary>
  IRemote = interface
    procedure TogglePower();
    procedure VolumeUp();
    procedure VolumeDown();
    procedure ChannelUp();
    procedure ChannelDown();
  end;

type
  /// <summary>
  /// Advanced Remote
  /// </summary>
  IAdvancedRemote = interface(IRemote)
    procedure Mute();
  end;

type
  /// <summary>
  /// Device
  /// </summary>
  IDevice = interface
    function IsPowered() : Boolean;
    procedure PowerOn();
    procedure PowerOff();
    function GetVolume() : Integer;
    procedure SetVolume(
      const Value : Integer);
    function GetChannel() : Integer;
    procedure SetChannel(
      const Value : Integer);
  end;

type
  /// <summary>
  /// Remote
  /// </summary>
  TRemote = class(
    TInterfacedObject, IRemote)
  strict protected
    FDevice : IDevice;
  protected
    procedure TogglePower();
    procedure VolumeUp();
    procedure VolumeDown();
    procedure ChannelUp();
    procedure ChannelDown();
  public
   constructor Create(
    const ADevice : IDevice);
  end;

type
  /// <summary>
  /// Advanced Remote
  /// </summary>
  TAdvancedRemote = class(
    TRemote, IAdvancedRemote)
  private
    procedure Mute();
  end;

type
  /// <summary>
  /// Remote
  /// </summary>
  TCustomDevice = class abstract(
    TInterfacedObject, IDevice)
  strict private
  const
    CVolumeMin = 0;
    CVolumeMax = 100;
  strict protected
    FIsPowered : Boolean;
    FVolume : Integer;
    FChannel : Integer;

    function GetName() : String; virtual; abstract;
  protected
    function IsPowered() : Boolean;
    procedure PowerOn();
    procedure PowerOff();
    function GetVolume() : Integer;
    procedure SetVolume(
      const Value : Integer);
    function GetChannel() : Integer;
    procedure SetChannel(
      const Value : Integer); virtual;
  public
    constructor Create();
  end;

type
  /// <summary>
  /// Radio
  /// </summary>
  TRadio = class(TCustomDevice)
  strict private
  const
    CChannelMin = 1;
    CChannelMax = 10;
  strict protected
    function GetName() : String; override;
  protected
    procedure SetChannel(
      const Value : Integer); override;
  end;

type
  /// <summary>
  /// TV
  /// </summary>
  TTV = class(TCustomDevice)
  strict private
  const
    CChannelMin = 1;
    CChannelMax = 5;
  strict protected
    function GetName() : String; override;
  protected
    procedure SetChannel(
      const Value : Integer); override;
  end;

{==============================================================================}

type
  /// <summary>
  /// Content
  /// </summary>
  IContent = interface
    function GetTitle() : String;
    function GetText() : String;
    function GetTags() : String;
    function GetImages() : IInterfaceList;

    property Title : String read GetTitle;
    property Text : String read GetText;
    property Tags : String read GetTags;
    property Images : IInterfaceList read GetImages;
  end;

type
  /// <summary>
  /// Custom Content
  /// </summary>
  TCustomContent = class abstract(
    TInterfacedObject, IContent)
  strict protected
    FTitle: String;
    FText: String;
    FTags: String;
    FImages: IInterfaceList;
  protected
    function GetTitle() : String; virtual;
    function GetText() : String;
    function GetTags() : String; virtual;
    function GetImages() : IInterfaceList;
  constructor Create(
    const ATitle: String;
    const AText: String;
    const ATags: String;
    const AImages: IInterfaceList);
  end;

type
  /// <summary>
  /// Story Content
  /// </summary>
  TStoryContent  = class(TCustomContent)
  protected
    function GetTitle() : String; override;
    function GetTags() : String; override;
  end;

type
  /// <summary>
  /// Poll Content
  /// </summary>
  TPollContent  = class(TCustomContent)
  protected
    function GetTitle() : String; override;
    function GetTags() : String; override;
  end;

type
  /// <summary>
  /// Sharing Service
  /// </summary>
  ISharingService = interface
    procedure Share(
      const AContent : IContent);
  end;

type
  /// <summary>
  /// Custom Sharing Service
  /// </summary>
  TCustomSharingService = class abstract(
    TInterfacedObject, ISharingService)
  private
    procedure Share(
      const AContent : IContent); virtual; abstract;
  end;

type
  /// <summary>
  /// Facebook Sharing Service
  /// </summary>
  TFacebookSharingService = class(TCustomSharingService)
  private
    procedure Share(
      const AContent : IContent); override;
  end;

type
  /// <summary>
  /// Instagram Sharing Service
  /// </summary>
  TInstagramSharingService = class(TCustomSharingService)
  private
    procedure Share(
      const AContent : IContent); override;
  end;

type
  /// <summary>
  /// Instagram Sharing Service
  /// </summary>
  ISharingSupport = interface
    procedure SetService(
      const AService: ISharingService);
    procedure Publish(
      const AContent: IContent);
  end;

type
  /// <summary>
  /// Custom View Controller
  /// </summary>
  TCustomViewController = class abstract(
    TInterfacedObject, ISharingSupport)
  strict protected
    FService: ISharingService;
  protected
    procedure SetService(
      const AService: ISharingService);
    procedure Publish(
      const AContent: IContent); virtual;
  end;

type
  /// <summary>
  /// Feed View Controller
  /// </summary>
  TFeedViewController = class(TCustomViewController)
  protected
    procedure Publish(
      const AContent: IContent); override;
  end;

type
  /// <summary>
  /// Photo View Controller
  /// </summary>
  TPhotoViewController = class(TCustomViewController)
  protected
    procedure Publish(
      const AContent: IContent); override;
  end;

implementation

uses
  System.SysUtils;

{------------------------------------------------------------------------------}
{ TRemote }
{------------------------------------------------------------------------------}

constructor TRemote.Create(
  const ADevice: IDevice);
begin
  inherited Create();

  FDevice := ADevice;
end;

procedure TRemote.TogglePower();
begin
  if FDevice.IsPowered then
    FDevice.PowerOff()
  else
    FDevice.PowerOn();
end;

procedure TRemote.VolumeUp();
begin
  FDevice.SetVolume(FDevice.GetVolume() + 10);
end;

procedure TRemote.VolumeDown();
begin
  FDevice.SetVolume(FDevice.GetVolume() - 10);
end;

procedure TRemote.ChannelUp();
begin
  FDevice.SetChannel(FDevice.GetChannel() + 1);
end;

procedure TRemote.ChannelDown();
begin
  FDevice.SetChannel(FDevice.GetChannel() - 1);
end;

{------------------------------------------------------------------------------}
{ TAdvancedRemote }
{------------------------------------------------------------------------------}

procedure TAdvancedRemote.Mute();
begin
  FDevice.SetVolume(0);
end;

{------------------------------------------------------------------------------}
{ TCustomDevice }
{------------------------------------------------------------------------------}

constructor TCustomDevice.Create();
begin
  inherited;

  FChannel := 1;
end;

function TCustomDevice.IsPowered(): Boolean;
begin
  Result := FIsPowered;
end;

procedure TCustomDevice.PowerOn();
begin
  if not FIsPowered then
    FIsPowered := True;
  Writeln(GetName() + ' is ON');
end;

procedure TCustomDevice.PowerOff();
begin
  if FIsPowered then
    FIsPowered := False;
  Writeln(GetName() + ' is OFF');
end;

function TCustomDevice.GetVolume(): Integer;
begin
  Result := FVolume;
end;

procedure TCustomDevice.SetVolume(
  const Value: Integer);
begin
  if (Value > CVolumeMax) then
    FVolume := CVolumeMax
  else
  if (Value < CVolumeMin) then
    FVolume := CVolumeMin
  else
    FVolume := Value;
  Writeln(GetName() + ' volume = ' + FVolume.ToString());
end;

function TCustomDevice.GetChannel(): Integer;
begin
  Result := FChannel;
end;

procedure TCustomDevice.SetChannel(
  const Value: Integer);
begin
  FChannel := Value;
//  Writeln(GetName() + ' internal channel = ' + FChannel.ToString());
end;

{------------------------------------------------------------------------------}
{ TRadio }
{------------------------------------------------------------------------------}

function TRadio.GetName() : String;
begin
  Result := 'Radio';
end;

procedure TRadio.SetChannel(
  const Value: Integer);
begin
  inherited;

  if (FChannel > CChannelMax) then
    FChannel := CChannelMax
  else
  if (FChannel < CChannelMin) then
    FChannel := CChannelMin;
  Writeln(GetName() + ' channel = ' + FChannel.ToString());
end;

{------------------------------------------------------------------------------}
{ TTV }
{------------------------------------------------------------------------------}

function TTV.GetName() : String;
begin
  Result := 'TV';
end;

procedure TTV.SetChannel(
  const Value: Integer);
begin
  inherited;

  if (FChannel > CChannelMax) then
    FChannel := CChannelMin
  else
  if (FChannel < CChannelMin) then
    FChannel := CChannelMax;
  Writeln(GetName() + ' channel = ' + FChannel.ToString());
end;

{==============================================================================}

{------------------------------------------------------------------------------}
{ TCustomContent }
{------------------------------------------------------------------------------}

constructor TCustomContent.Create(
  const ATitle: String;
  const AText: String;
  const ATags: String;
  const AImages: IInterfaceList);
begin
  inherited Create();

  FTitle  := ATitle;
  FText   := AText;
  FTags   := ATags;
  FImages := AImages;
end;

function TCustomContent.GetTitle(): String;
begin
  Result := FTitle;
end;

function TCustomContent.GetText(): String;
begin
  Result := FText;
end;

function TCustomContent.GetTags(): String;
begin
  Result := FTags;
end;

function TCustomContent.GetImages(): IInterfaceList;
begin
  Result := FImages;
end;

{------------------------------------------------------------------------------}
{ TStoryContent }
{------------------------------------------------------------------------------}

function TStoryContent.GetTitle(): String;
begin
  Result := inherited GetTitle() + sLineBreak + '[Story]';
end;

function TStoryContent.GetTags(): String;
begin
  Result := inherited GetTags() + ' #story';
end;

{------------------------------------------------------------------------------}
{ TPollContent }
{------------------------------------------------------------------------------}

function TPollContent.GetTitle(): String;
begin
  Result := inherited GetTitle() + sLineBreak + '[Poll]';
end;

function TPollContent.GetTags(): String;
begin
  Result := inherited GetTags() + ' #poll';
end;

{------------------------------------------------------------------------------}
{ TFacebookSharingService }
{------------------------------------------------------------------------------}

procedure TFacebookSharingService.Share(
  const AContent: IContent);
begin
  Writeln('Posting content to the Facebook');
  Writeln('Title: ' + AContent.Title);
  Writeln('Text: ' + AContent.Text);
  Writeln('Tags: ' + AContent.Tags);
  Writeln('☺☻♥☼');
end;

{------------------------------------------------------------------------------}
{ TInstagramSharingService }
{------------------------------------------------------------------------------}

procedure TInstagramSharingService.Share(
  const AContent: IContent);
begin
  Writeln('Posting content to the Instagram');
  Writeln('Title: ' + AContent.Title);
  Writeln('Text: ' + AContent.Text);
  Writeln('Tags: ' + AContent.Tags);
  Writeln('☺♥►');
end;

{------------------------------------------------------------------------------}
{ TCustomViewController }
{------------------------------------------------------------------------------}

procedure TCustomViewController.SetService(
  const AService: ISharingService);
begin
  FService := AService;
end;

procedure TCustomViewController.Publish(
  const AContent: IContent);
begin
  Writeln('Publishing content');
  FService.Share(AContent);
  Writeln('Content is published');
end;

{------------------------------------------------------------------------------}
{ TFeedViewController }
{------------------------------------------------------------------------------}

procedure TFeedViewController.Publish(
  const AContent: IContent);
begin
  Writeln('Prepare service for feed publishing');

  inherited;
end;

{------------------------------------------------------------------------------}
{ TPhotoViewController }
{------------------------------------------------------------------------------}

procedure TPhotoViewController.Publish(
  const AContent: IContent);
begin
  Writeln('Prepare service for photo publishing');

  inherited;
end;

end.
