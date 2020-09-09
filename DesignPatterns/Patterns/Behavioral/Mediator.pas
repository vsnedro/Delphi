unit Mediator;

interface

uses
  System.Generics.Collections;

type
  /// <summary>
  /// My News
  /// </summary>
  TMyNews = record
    id    : Integer;
    title : String;
    likes : Integer;
  end;

type
  /// <summary>
  /// Screen Updatable
  /// </summary>
  IScreenUpdatable = interface
    ['{F92FC723-8BF6-458C-9015-59DD10FA5D54}']
    procedure Like(
      const ANews : TMyNews);
    procedure Dislike(
      const ANews : TMyNews);
  end;

type
  /// <summary>
  /// Screen Event
  /// </summary>
  IScreenEvent = interface
    ['{EF320674-1B12-4036-A116-527392B4AB43}']
    procedure UserLikes(
      const ANews : TMyNews);
    procedure UserDisliked(
      const ANews : TMyNews);
  end;

type
  /// <summary>
  /// News Mediator
  /// </summary>
  INewsMediator = interface(IScreenEvent)
    ['{8D7F42CB-2BCE-43C7-B5E8-5497734F394F}']
    procedure Init(
      const AScreens : TList<IScreenUpdatable>);
  end;

type
  /// <summary>
  /// Mediator Context
  /// </summary>
  IMediatorContext = interface
    ['{CA9408C8-37B4-4D0F-93CF-ACEF6AA82069}']
    procedure UserLikedAllNews();
    procedure UserDislikedAllNews();
  end;

type
  /// <summary>
  /// News Mediator
  /// </summary>
  TNewsMediator = class(
    TInterfacedObject, INewsMediator)
  strict private
    FScreens : TList<IScreenUpdatable>;
  private
    procedure UserLikes(
      const ANews : TMyNews);
    procedure UserDisliked(
      const ANews : TMyNews);

    procedure Init(
      const AScreens : TList<IScreenUpdatable>);
  end;

type
  /// <summary>
  /// News Custom Controller
  /// </summary>
  TNewsCustomController = class abstract(
    TInterfacedObject, IScreenUpdatable, IScreenEvent)
  strict private
    [weak] FMediator : IScreenEvent;
  protected
    procedure Like(
      const ANews : TMyNews); virtual; abstract;
    procedure Dislike(
      const ANews : TMyNews); virtual; abstract;
  private
    procedure UserLikes(
      const ANews : TMyNews);
    procedure UserDisliked(
      const ANews : TMyNews);
  public
    constructor Create(
      const AMediator : IScreenEvent);
  end;

type
  /// <summary>
  /// News Feed Controller
  /// </summary>
  TNewsFeedController = class(
    TNewsCustomController)
  strict private
    FNewsList : TArray<TMyNews>;
  private
    procedure Like(
      const ANews : TMyNews); override;
    procedure Dislike(
      const ANews : TMyNews); override;
  public
    constructor Create(
      const AMediator : IScreenEvent;
      const ANewsList : TArray<TMyNews>);
  end;

type
  /// <summary>
  /// News Detail Controller
  /// </summary>
  TNewsDetailController = class(
    TNewsCustomController)
  strict private
    FNews : TMyNews;
  private
    procedure Like(
      const ANews : TMyNews); override;
    procedure Dislike(
      const ANews : TMyNews); override;
  public
    constructor Create(
      const AMediator : IScreenEvent;
      const ANews     : TMyNews);
  end;

type
  /// <summary>
  /// Profile Controller
  /// </summary>
  TProfileController = class(
    TNewsCustomController)
  strict private
    FLikes : Integer;
  private
    procedure Like(
      const ANews : TMyNews); override;
    procedure Dislike(
      const ANews : TMyNews); override;
  end;

type
  /// <summary>
  /// Mediator Context
  /// </summary>
  TMediatorContext = class(
    TInterfacedObject, IMediatorContext)
  strict private
    FMainNews : TMyNews;
    FNewsList : TArray<TMyNews>;
    FScreens  : TList<IScreenUpdatable>;

    FNewsMediator : INewsMediator;
    FNewsFeed     : IScreenEvent;
    FNewsDetail   : IScreenEvent;
    FProfile      : IScreenEvent;
  private
    procedure UserLikedAllNews();
    procedure UserDislikedAllNews();
  public
    constructor Create();
    destructor  Destroy(); override;
  end;

implementation

uses
  System.SysUtils;

{------------------------------------------------------------------------------}
{ TNewsMediator }
{------------------------------------------------------------------------------}

procedure TNewsMediator.Init(
  const AScreens: TList<IScreenUpdatable>);
begin
  FScreens := AScreens;
end;

procedure TNewsMediator.UserLikes(
  const ANews: TMyNews);
var
  Screen : IScreenUpdatable;
begin
  Writeln('Mediator: I will notify all about LIKE');

  for Screen in FScreens do
    Screen.Like(ANews);
end;

procedure TNewsMediator.UserDisliked(
  const ANews: TMyNews);
var
  Screen : IScreenUpdatable;
begin
  Writeln('Mediator: I will notify all about DISLIKE');

  for Screen in FScreens do
    Screen.Dislike(ANews);
end;

{------------------------------------------------------------------------------}
{ TNewsCustomController }
{------------------------------------------------------------------------------}

constructor TNewsCustomController.Create(
  const AMediator: IScreenEvent);
begin
  inherited Create();

  FMediator := AMediator;
end;

procedure TNewsCustomController.UserLikes(
  const ANews: TMyNews);
begin
  Writeln(Self.ClassName + ': I will notify mediator about LIKE to this news');
  FMediator.UserLikes(ANews);
end;

procedure TNewsCustomController.UserDisliked(
  const ANews: TMyNews);
begin
  Writeln(Self.ClassName + ': I will notify mediator about DISLIKE to this news');
  FMediator.UserDisliked(ANews);
end;

{------------------------------------------------------------------------------}
{ TNewsFeedController }
{------------------------------------------------------------------------------}

constructor TNewsFeedController.Create(
  const AMediator: IScreenEvent;
  const ANewsList: TArray<TMyNews>);
begin
  inherited Create(AMediator);

  FNewsList := ANewsList;
end;

procedure TNewsFeedController.Like(
  const ANews: TMyNews);
var
  i : Integer;
begin
  for i := Low(FNewsList) to High(FNewsList) do
    if (FNewsList[i].id = ANews.id) then
    begin
      FNewsList[i].likes := FNewsList[i].likes + 1;
      Writeln(Format('News Feed: News with title %s was LIKED', [ANews.title.QuotedString('"')]));
      Break;
    end;
end;

procedure TNewsFeedController.Dislike(
  const ANews: TMyNews);
var
  i : Integer;
begin
  for i := Low(FNewsList) to High(FNewsList) do
    if (FNewsList[i].id = ANews.id) then
    begin
      FNewsList[i].likes := FNewsList[i].likes - 1;
      Writeln(Format('News Feed: News with title %s was DISLIKED', [ANews.title.QuotedString('"')]));
      Break;
    end;
end;

{------------------------------------------------------------------------------}
{ TNewsDetailController }
{------------------------------------------------------------------------------}

constructor TNewsDetailController.Create(
  const AMediator: IScreenEvent;
  const ANews: TMyNews);
begin
  inherited Create(AMediator);

  FNews := ANews;
end;

procedure TNewsDetailController.Like(
  const ANews: TMyNews);
begin
  if (FNews.id = ANews.id) then
  begin
    FNews.likes := FNews.likes + 1;
    Writeln(Format('News Detail: News with title %s was LIKED', [ANews.title.QuotedString('"')]));
  end;
end;

procedure TNewsDetailController.Dislike(
  const ANews: TMyNews);
begin
  if (FNews.id = ANews.id) then
  begin
    FNews.likes := FNews.likes + 1;
    Writeln(Format('News Detail: News with title %s was DISLIKED', [ANews.title.QuotedString('"')]));
  end;
end;

{------------------------------------------------------------------------------}
{ TProfileController }
{------------------------------------------------------------------------------}

procedure TProfileController.Like(
  const ANews: TMyNews);
begin
  Inc(FLikes);
  Writeln(Format('Profile: Number of LIKES is %d', [FLikes]));
end;

procedure TProfileController.Dislike(
  const ANews: TMyNews);
begin
  Dec(FLikes);
  Writeln(Format('Profile: Number of LIKES is %d', [FLikes]));
end;

{------------------------------------------------------------------------------}
{ TMediatorContext }
{------------------------------------------------------------------------------}

constructor TMediatorContext.Create();
var
  N0, N1, N2 : TMyNews;
begin
  inherited;

  N0.id    := 0;
  N0.title := 'Cats';
  N0.likes := 0;

  N1.id    := 0;
  N1.title := 'Dogs';
  N1.likes := 0;

  N2.id    := 0;
  N2.title := 'Monkeys';
  N2.likes := 0;

  SetLength(FNewsList, 3);
  FNewsList[0] := N0;
  FNewsList[1] := N1;
  FNewsList[2] := N2;
  FMainNews    := FNewsList[0];

  FNewsMediator := TNewsMediator.Create();

  FNewsFeed   := TNewsFeedController  .Create(FNewsMediator, FNewsList);
  FNewsDetail := TNewsDetailController.Create(FNewsMediator, FMainNews);
  FProfile    := TProfileController   .Create(FNewsMediator);

  FScreens := TList<IScreenUpdatable>.Create();
  FScreens.Add(FNewsFeed as IScreenUpdatable);
  FScreens.Add(FNewsDetail as IScreenUpdatable);
  FScreens.Add(FProfile as IScreenUpdatable);
  FNewsMediator.Init(FScreens);
end;

destructor TMediatorContext.Destroy();
begin
  FreeAndNil(FScreens);

  inherited;
end;

procedure TMediatorContext.UserLikedAllNews();
var
  i : Integer;
begin
  Writeln('Context: User LIKES main news');
  FNewsDetail.UserLikes(FMainNews);

  Writeln('Context: User LIKES all news');
  for i := Low(FNewsList) to High(FNewsList) do
    FNewsFeed.UserLikes(FNewsList[i]);
end;

procedure TMediatorContext.UserDislikedAllNews();
var
  i : Integer;
begin
  Writeln('Context: User DISLIKES main news');
  FNewsDetail.UserDisliked(FMainNews);

  Writeln('Context: User DISLIKES all news');
  for i := Low(FNewsList) to High(FNewsList) do
    FNewsFeed.UserDisliked(FNewsList[i]);
end;

end.
