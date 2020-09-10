unit State;

interface

type
  /// <summary>
  /// Music Player
  /// </summary>
  IMusicPlayer = interface;

  /// <summary>
  /// Music Player State
  /// </summary>
  IMusicPlayerState = interface
    ['{F4091E8C-A0A5-4ADC-92E3-DFE9BF7419B2}']
    procedure Lock();
    procedure Play();
    procedure Stop();
    procedure PrevTrack();
    procedure NextTrack();
  end;

  /// <summary>
  /// Music Player
  /// </summary>
  IMusicPlayer = interface
    ['{69083466-8E5F-41F6-9760-4C80DBA61434}']
    procedure Lock();
    procedure Unlock();
    procedure Play();
    procedure Stop();
    procedure RewindBack();
    procedure RewindForward();
    procedure PrevTrack();
    procedure NextTrack();

    function IsPlaying() : Boolean;

    procedure SetState(
      const AState : IMusicPlayerState);
  end;

type
  /// <summary>
  /// UI Music Player
  /// </summary>
  IUIMusicPlayer = interface
    ['{3D33050A-27DC-48E8-B3B1-D1C651D2EA8D}']
    procedure LockClick();
    procedure PlayClick();
    procedure StopClick();
    procedure PrevClick();
    procedure NextClick();
  end;

type
  /// <summary>
  /// UI Player Client
  /// </summary>
  IUIPlayerClient = interface
    ['{07E22E5C-660E-43FB-A435-0E82C5E8AB29}']
    procedure Player_Lock();
    procedure Player_Play();
    procedure Player_Stop();
    procedure Player_Prev();
    procedure Player_Next();
  end;

{------------------------------------------------------------------------------}

type
  /// <summary>
  /// Music Player Custom State
  /// </summary>
  TMusicPlayerCustomState = class abstract(
    TInterfacedObject, IMusicPlayerState)
  strict protected
    [weak] FPlayer: IMusicPlayer;
  private
    procedure Lock(); virtual; abstract;
    procedure Play(); virtual; abstract;
    procedure Stop(); virtual; abstract;
    procedure PrevTrack(); virtual; abstract;
    procedure NextTrack(); virtual; abstract;
  public
    constructor Create(
      const APlayer : IMusicPlayer);
  end;

type
  /// <summary>
  /// Music Player State Ready
  /// </summary>
  TMusicPlayerStateReady = class abstract(
    TMusicPlayerCustomState)
  private
    procedure Lock(); override;
    procedure Play(); override;
    procedure Stop(); override;
    procedure PrevTrack(); override;
    procedure NextTrack(); override;
  end;

type
  /// <summary>
  /// Music Player State Play
  /// </summary>
  TMusicPlayerStatePlay = class abstract(
    TMusicPlayerCustomState)
  private
    procedure Lock(); override;
    procedure Play(); override;
    procedure Stop(); override;
    procedure PrevTrack(); override;
    procedure NextTrack(); override;
  end;

type
  /// <summary>
  /// Music Player State Lock
  /// </summary>
  TMusicPlayerStateLock = class abstract(
    TMusicPlayerCustomState)
  private
    procedure Lock(); override;
    procedure Play(); override;
    procedure Stop(); override;
    procedure PrevTrack(); override;
    procedure NextTrack(); override;
  end;

type
  /// <summary>
  /// Music Player
  /// </summary>
  TMusicPlayer = class(
    TInterfacedObject, IMusicPlayer, IUIMusicPlayer)
  strict private
    FState : IMusicPlayerState;
    FIsPlaying : Boolean;
  private
    procedure Lock();
    procedure Unlock();
    procedure Play();
    procedure Stop();
    procedure RewindBack();
    procedure RewindForward();
    procedure PrevTrack();
    procedure NextTrack();

    function IsPlaying() : Boolean;

    procedure SetState(
      const AState : IMusicPlayerState);
  private
    procedure LockClick();
    procedure PlayClick();
    procedure StopClick();
    procedure PrevClick();
    procedure NextClick();
  public
    constructor Create();
    destructor  Destroy(); override;
  end;

type
  /// <summary>
  /// UI Player Client
  /// </summary>
  TUIPlayerClient = class(
    TInterfacedObject, IUIPlayerClient)
  strict private
    FPlayer : IUIMusicPlayer;
  private
    procedure Player_Lock();
    procedure Player_Play();
    procedure Player_Stop();
    procedure Player_Prev();
    procedure Player_Next();
  public
    constructor Create(
      const APlayer : IUIMusicPlayer);
  end;

implementation

{------------------------------------------------------------------------------}
{ TMusicPlayerCustomState }
{------------------------------------------------------------------------------}

constructor TMusicPlayerCustomState.Create(
  const APlayer: IMusicPlayer);
begin
  inherited Create();

  FPlayer := APlayer;
end;

{------------------------------------------------------------------------------}
{ TMusicPlayerStateReady }
{------------------------------------------------------------------------------}

procedure TMusicPlayerStateReady.Lock();
begin
  FPlayer.Lock();
  FPlayer.SetState(TMusicPlayerStateLock.Create(FPlayer));
end;

procedure TMusicPlayerStateReady.Play();
begin
  FPlayer.Play();
  FPlayer.SetState(TMusicPlayerStatePlay.Create(FPlayer));
end;

procedure TMusicPlayerStateReady.PrevTrack();
begin
  FPlayer.PrevTrack();
end;

procedure TMusicPlayerStateReady.NextTrack();
begin
  FPlayer.NextTrack();
end;

procedure TMusicPlayerStateReady.Stop();
begin
  { Nothing to do }
end;

{------------------------------------------------------------------------------}
{ TMusicPlayerStatePlay }
{------------------------------------------------------------------------------}

procedure TMusicPlayerStatePlay.Lock();
begin
  FPlayer.Lock();
  FPlayer.SetState(TMusicPlayerStateLock.Create(FPlayer));
end;

procedure TMusicPlayerStatePlay.Play();
begin
  { Nothing to do }
end;

procedure TMusicPlayerStatePlay.PrevTrack();
begin
  FPlayer.RewindBack();
end;

procedure TMusicPlayerStatePlay.NextTrack();
begin
  FPlayer.RewindForward();
end;


procedure TMusicPlayerStatePlay.Stop();
begin
  FPlayer.Stop();
  FPlayer.SetState(TMusicPlayerStateReady.Create(FPlayer));
end;

{------------------------------------------------------------------------------}
{ TMusicPlayerStateLock }
{------------------------------------------------------------------------------}

procedure TMusicPlayerStateLock.Lock();
begin
  FPlayer.Unlock();
  if FPlayer.IsPlaying() then
    FPlayer.SetState(TMusicPlayerStatePlay.Create(FPlayer))
  else
    FPlayer.SetState(TMusicPlayerStateReady.Create(FPlayer));
end;

procedure TMusicPlayerStateLock.Play();
begin
  { Nothing to do }
end;

procedure TMusicPlayerStateLock.PrevTrack();
begin
  { Nothing to do }
end;

procedure TMusicPlayerStateLock.NextTrack();
begin
  { Nothing to do }
end;

procedure TMusicPlayerStateLock.Stop();
begin
  { Nothing to do }
end;

{------------------------------------------------------------------------------}
{ TMusicPlayer }
{------------------------------------------------------------------------------}

constructor TMusicPlayer.Create();
begin
  inherited Create();

  FState     := TMusicPlayerStateReady.Create(Self);
  FIsPlaying := False;
end;

destructor TMusicPlayer.Destroy();
begin
  FState := nil;

  inherited Destroy();
end;

procedure TMusicPlayer.SetState(
  const AState: IMusicPlayerState);
begin
  FState := AState;
end;

function TMusicPlayer.IsPlaying(): Boolean;
begin
  Result := FIsPlaying;
end;

{ IMusicPlayer }

procedure TMusicPlayer.Lock();
begin
  Writeln('Player: I am locked');
end;

procedure TMusicPlayer.Unlock();
begin
  Writeln('Player: I am unlocked');
end;

procedure TMusicPlayer.Play();
begin
  FIsPlaying := True;
  Writeln('Player: I am playing now');
end;

procedure TMusicPlayer.PrevTrack();
begin
  Writeln('Player: Set previous track');
end;

procedure TMusicPlayer.NextTrack();
begin
  Writeln('Player: Set next track');
end;

procedure TMusicPlayer.RewindBack();
begin
  Writeln('Player: Rewind back');
end;

procedure TMusicPlayer.RewindForward();
begin
  Writeln('Player: Rewind forward');
end;

procedure TMusicPlayer.Stop();
begin
  FIsPlaying := False;
  Writeln('Player: I am stopped');
end;

{ IUIMusicPlayer }

procedure TMusicPlayer.LockClick();
begin
  FState.Lock();
end;

procedure TMusicPlayer.PlayClick();
begin
  FState.Play();
end;

procedure TMusicPlayer.PrevClick();
begin
  FState.PrevTrack();
end;

procedure TMusicPlayer.NextClick();
begin
  FState.NextTrack();
end;

procedure TMusicPlayer.StopClick();
begin
  FState.Stop();
end;

{------------------------------------------------------------------------------}
{ TUIPlayerClient }
{------------------------------------------------------------------------------}

constructor TUIPlayerClient.Create(
  const APlayer: IUIMusicPlayer);
begin
  inherited Create();

  FPlayer := APlayer;
  Writeln('Client: Ho-ho-ho! Now I have a music player');
end;

procedure TUIPlayerClient.Player_Lock();
begin
  Writeln('Client: I click "Lock" on my player');
  FPlayer.LockClick();
end;

procedure TUIPlayerClient.Player_Play();
begin
  Writeln('Client: I click "Play" on my player');
  FPlayer.PlayClick();
end;

procedure TUIPlayerClient.Player_Prev();
begin
  Writeln('Client: I click "Prev" on my player');
  FPlayer.PrevClick();
end;

procedure TUIPlayerClient.Player_Next();
begin
  Writeln('Client: I click "Next" on my player');
  FPlayer.NextClick();
end;

procedure TUIPlayerClient.Player_Stop();
begin
  Writeln('Client: I click "Stop" on my player');
  FPlayer.StopClick();
end;

end.
