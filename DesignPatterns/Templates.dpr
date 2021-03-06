﻿program Templates;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.Classes,
  System.Types,
  System.Generics.Collections,
  System.SysUtils,
  Winapi.Windows,
  Adapter in 'Patterns\Structural\Adapter.pas',
  Decorator in 'Patterns\Structural\Decorator.pas',
  Proxy in 'Patterns\Structural\Proxy.pas',
  Facade in 'Patterns\Structural\Facade.pas',
  Bridge in 'Patterns\Structural\Bridge.pas',
  Composite in 'Patterns\Structural\Composite.pas',
  Flyweight in 'Patterns\Structural\Flyweight.pas',
  FactoryMethod in 'Patterns\Creational\FactoryMethod.pas',
  AbstractFactory in 'Patterns\Creational\AbstractFactory.pas',
  Builder in 'Patterns\Creational\Builder.pas',
  Prototype in 'Patterns\Creational\Prototype.pas',
  Singleton in 'Patterns\Creational\Singleton.pas',
  ChainOfResponsibility in 'Patterns\Behavioral\ChainOfResponsibility.pas',
  Command in 'Patterns\Behavioral\Command.pas',
  Iterator in 'Patterns\Behavioral\Iterator.pas',
  Mediator in 'Patterns\Behavioral\Mediator.pas',
  Memento in 'Patterns\Behavioral\Memento.pas',
  Observer in 'Patterns\Behavioral\Observer.pas',
  State in 'Patterns\Behavioral\State.pas',
  Strategy in 'Patterns\Behavioral\Strategy.pas',
  TemplateMethod in 'Patterns\Behavioral\TemplateMethod.pas',
  Visitor in 'Patterns\Behavioral\Visitor.pas';

var
  i : Integer;
  {$REGION ' Structural '}
  MathClient      : IMathClient;
  FastMathAdapter : IMathOper;
  MathStrClient   : IMathStrClient;
  MathStrAdapter  : IMathStrAdapter;
  {}
  AuthClient          : IClientThatNeedsAuth;
  FacebookAuthService : IAuthService;
  TwitterAuthService  : IAuthService;
  {}
  AreaCalc  : TAreaCalcFacade;
  MathOperDecorator : IMathOper;
  {}
  ImageClient : IImageClient;
  {}
  Notifier : INotifier;
  {}
  DataSource       : IDataSource;
  SecureDataSource : IDataSource;
  {}
  Cats        : IMyImage;
  Dogs        : IMyImage;
  Resizer     : IMyImageEditor;
  BlurFilter  : IMyImageEditor;
  ColorFilter : IMyImageEditor;
  {}
  WebService : IWebService;
  {}
  ProfileClient : IProfileClient;
  {}
  Remote         : IRemote;
  AdvancedRemote : IAdvancedRemote;
  Radio          : IDevice;
  TV             : IDevice;
  {}
  ViewController : ISharingSupport;
  {}
  Node    : INode;
  SubNode : INode;
  {}
  Form1 : TUIForm;
  Btn1  : TUIButton;
  Lbl1  : TUILabel;
  DefaultTheme : IUITheme;
  NightTheme   : IUITheme;
  {}
  Forest : IForest;
  {}
  AnimalClient : IAnimalClient;
  {$ENDREGION}
  {$REGION ' FactoryMethod '}
  FMTruckFactory : IFMTransportFactory;
  FMShipFactory  : IFMTransportFactory;
  FMTransport    : IFMTransport;

  ConferenceRoom1 : IConferenceRoom;
  ConferenceRoom2 : IConferenceRoom;
  Projector1      : IProjector;
  Projector2      : IProjector;
  {$ENDREGION}
  {$REGION ' Abstract Factory '}
  FurnitureClient : IFurnitureClient;
  {$ENDREGION}
  {$REGION ' Builder '}
  CarClient : ICarClient;
  {$ENDREGION}
  {$REGION ' Prototype '}
  Circle1 : ICircle;
  Circle2 : ICircle;
  Shape1  : IShape;
  Shape2  : IShape;
  {$ENDREGION}
  {$REGION ' Singleton '}
  MessageListVC : IMessageSubscriber;
  PrivateChatVC : IMessageSubscriber;
  {$ENDREGION}
  {$REGION ' Chain Of Responsibility '}
  MonkeyHandler   : IHandler;
  SquirrelHandler : IHandler;
  DogHandler      : IHandler;
  HandlerClient   : IHandlerClient;

  AuthWebServiceHandler   : IWebServiceHandler;
  AccessWebServiceHandler : IWebServiceHandler;
  WebServiceHandlerClient : IWebServiceHandlerClient;
  {$ENDREGION}
  {$REGION ' Command '}
  MyApplication : IMyApplication;
  {$ENDREGION}
  {$REGION ' Iterator '}
  SocialClient : ISocialClient;
  {$ENDREGION}
  {$REGION ' Mediator '}
  MediatorContext : IMediatorContext;
  {$ENDREGION}
  {$REGION ' Memento '}
  TextEditorClient : ITextEditorClient;
  {$ENDREGION}
  {$REGION ' Observer '}
  ObserverContext : IObserverContext;
  {$ENDREGION}
  {$REGION ' State '}
  Player       : IUIMusicPlayer;
  PlayerClient : IUIPlayerClient;
  {$ENDREGION}
  {$REGION ' Strategy '}
  MapNavigatorClient : IMapNavigatorClient;
  {$ENDREGION}
  {$REGION ' Template Method '}
  GameContext : IGameContext;
  {$ENDREGION}
  {$REGION ' Visitor '}
  MyGraphicsVisitor : IMyGraphicsVisitor;
  MyDot   : IMyGraphics;
  MyShape : IMyGraphics;

  NotificationClient : INotificationClient;
  {$ENDREGION}

begin
  try
    {$REGION ' Adapter '}
//    MathClient := TMathClient.Create(TMathOper.Create());
//    MathClient.DoWork(10, 15);
//
//    FastMathAdapter := TFastMathOperAdapter.Create(TFastMathOper.Create());
//    MathClient      := TMathClient.Create(FastMathAdapter);
//    MathClient.DoWork(20, 25);
//
//    MathStrAdapter  := TMathStrAdapter.Create(TMathOper.Create());
//    MathStrClient   := TMathStrClient.Create(MathStrAdapter);
//    MathStrClient.DoWork('30', '35');
    {$ENDREGION}

    {$REGION ' Adapter Auth '}
//    FacebookAuthService := TFacebookAuthService.Create();
//    TwitterAuthService  := TTwitterAuthServiceAdapter.Create(TTwitterAuthService.Create());
//
//    AuthClient := TClientThatNeedsAuth.Create(FacebookAuthService);
//    AuthClient.DoAuth();
//
//    AuthClient := TClientThatNeedsAuth.Create(TwitterAuthService);
//    AuthClient.DoAuth();
    {$ENDREGION}

    {$REGION ' Facade '}
//    AreaCalc := TAreaCalcFacade.Create();
//    try
//      Writeln(Format(
//        'Square Area of %d x %d = %g',
//        [10, 20, AreaCalc.SquareArea(10, 20)]));
//      Writeln(Format(
//        'Triangle Area of %d x %d x %d = %0.2f',
//        [10, 20, 25, AreaCalc.TriangleArea(10, 20, 25)]));
//      Readln;
//    finally
//      FreeAndNil(AreaCalc);
//    end;
    {$ENDREGION}

    {$REGION ' Facade Image Download  '}
//    ImageClient := TImageClient.Create(
//      TImageDownloadFacade.Create(
//        {AImageDownload }TImageDownload.Create(),
//        {AImageFilter   }TImageFilter.Create(),
//        {AImageLibrary  }TImageLibrary.Create()));
//    ImageClient.DownloadImage('http://site.com/sun.jpg');
//    ImageClient.DownloadImage('http://mail.com/logo.jpg');
    {$ENDREGION}

    {$REGION ' Decorator '}
//    MathOperDecorator := TMathOperDecorator.Create(TMathOper.Create());
//    MathOperDecorator.Min(1, 10);
//    MathOperDecorator.Max(1, 10);
//    Readln;

//    Notifier := TNotifier.Create();
//    Notifier.Send('Message 1');
//    Notifier := TSmsNotifier.Create(Notifier);
//    Notifier.Send('Message 2');
//    Notifier := TEmailNotifier.Create(Notifier);
//    Notifier.Send('Message 3');
//    Readln;

//    DataSource := TFileDataSource.Create('Text.txt');
//    DataSource.Write('String 1');
//    DataSource.Read();
//    SecureDataSource := TSecureFileDataSource.Create(DataSource);
//    SecureDataSource.Write('Secret string');
//    SecureDataSource.Read();
    {$ENDREGION}

    {$REGION ' Decorator Image Editor '}
//    Cats       := TMyImage.Create(TRect.Create(0, 0, 1000, 500), 'Funny cats');
//    Resizer    := TMyImageResizer.Create(Cats, 'Simple Resizer', 0.9, 0.9);
//    BlurFilter := TMyBlurImageFilter.Create(Resizer, 'Fast blur', 1);
//    BlurFilter.Proccess();
//    Writeln;
//
//    Dogs        := TMyImage.Create(TRect.Create(0, 0, 1000, 500), 'Funny dogs');
//    Resizer     := TMyImageResizer.Create(Dogs, 'Simple Resizer', 0.5, 0.5);
//    BlurFilter  := TMyBlurImageFilter.Create(Resizer, 'Fast blur', 2);
//    ColorFilter := TMyColorImageFilter.Create(BlurFilter, 'Color editor', 90, 105, 110);
//    ColorFilter.Proccess();
//    Writeln;
    {$ENDREGION}

    {$REGION ' Proxy '}
//    WebService := TWebServiceProxy.Create();
//    WebService.Upload('Doc1');
//    WebService.Upload('Doc2');
//    WebService.Download(15);
//    WebService.Download(20);
//    WebService.Download(20);
//    WebService.Download(25);
    {$ENDREGION}

    {$REGION ' Proxy Profile '}
//    ProfileClient := TProfileClient.Create(TProfileProxy.Create(TProfileService.Create()));
//
//    ProfileClient.GetProfile(1, False);
//    ProfileClient.GetProfile(1, True);
//    ProfileClient.GetProfile(2, False);
//    ProfileClient.GetProfile(2, True);
//    ProfileClient.GetProfile(3, False);
//    ProfileClient.GetProfile(3, True);
    {$ENDREGION}

    {$REGION ' Bridge '}
//    Writeln('Radio + Remote');
//    Radio  := TRadio.Create();
//    Remote := TRemote.Create(Radio);
//    Remote.TogglePower();
//    for i := 0 to 10 do
//      Remote.VolumeUp();
//    for i := 0 to 10 do
//      Remote.VolumeDown();
//    for i := 0 to 10 do
//      Remote.ChannelUp();
//    for i := 0 to 10 do
//      Remote.ChannelDown();
//    Remote.TogglePower();
//
//    Writeln('TV + Remote');
//    TV     := TTV.Create();
//    Remote := TRemote.Create(TV);
//    Remote.TogglePower();
//    for i := 0 to 10 do
//      Remote.VolumeUp();
//    for i := 0 to 10 do
//      Remote.VolumeDown();
//    for i := 0 to 10 do
//      Remote.ChannelUp();
//    for i := 0 to 10 do
//      Remote.ChannelDown();
//    Remote.TogglePower();
//
//    Writeln('TV + AdvancedRemote');
//    AdvancedRemote := TAdvancedRemote.Create(TV);
//    AdvancedRemote.TogglePower();
//    for i := 0 to 10 do
//      AdvancedRemote.VolumeUp();
//    for i := 0 to 10 do
//      AdvancedRemote.VolumeDown();
//    for i := 0 to 10 do
//      AdvancedRemote.ChannelUp();
//    for i := 0 to 10 do
//      AdvancedRemote.ChannelDown();
//    AdvancedRemote.Mute();
//    AdvancedRemote.TogglePower();
    {$ENDREGION}

    {$REGION ' Bridge Sharing Service '}
//    ViewController := TFeedViewController.Create();
//    ViewController.SetService(TFacebookSharingService.Create());
//    ViewController.Publish(
//      TStoryContent.Create('Breakfast', 'Here''s my breakfast', '#morning #breakfast', nil));
//
//    ViewController := TPhotoViewController.Create();
//    ViewController.SetService(TInstagramSharingService.Create());
//    ViewController.Publish(
//      TPollContent.Create('Beach', 'I am on the beach', '#sun #beach', nil));
    {$ENDREGION}

    {$REGION ' Composite '}
//    Node    := TNode.Create('Генерал Вася');
//    SubNode := TNode.Create('Полковник Коля');
//    SubNode.Add(TLeaf.Create('Рядовой Артём'));
//    Node.Add(SubNode);
//    Node.Add(TNode.Create('Полковник Петя'));
//    Node.Add(TLeaf.Create('Секретарь Лена'));
//    Node.Operation();
    {$ENDREGION}

    {$REGION ' Composite UI Theme '}
//    Form1 := TUIForm.Create(nil, 'MainForm');
//    Btn1  := TUIButton.Create(Form1, 'Btn_Hello');
//    Lbl1  := TUILabel.Create(Form1, 'Lbl_Hello');
//
//    Writeln('Let''s apply a default theme to the form');
//    DefaultTheme := TUITheme.Create('Default Theme', 'LightGray', 'White', 'Black');
//    Form1.SetTheme(DefaultTheme);
//    Writeln('');
//
//    Writeln('Let''s apply a night theme to the main form');
//    NightTheme   := TUITheme.Create('Night Theme', 'DarkGray', 'LightGray', 'White');
//    Form1.SetTheme(NightTheme);
//    Writeln('');
    {$ENDREGION}

    {$REGION ' Flyweight '}
//    Forest := TForest.Create();
//    Forest.PlantTree('Oak', 'dark brown', '', 10, 20);
//    Forest.PlantTree('Birch', 'white', '', 20, 15);
//    Forest.PlantTree('Pine', 'brown', '', 30, 30);
//    Forest.PlantTree('Birch', 'white', '', 1, 15);
//    Forest.PlantTree('Pine', 'brown', '', 20, 10);
//    Forest.Draw();
    {$ENDREGION}

    {$REGION ' Flyweight Animals '}
//    AnimalClient := TAnimalClient.Create(TAnimalCatalog.Create(TAnimalPhotoCatalog.Create()));
//    AnimalClient.AddAnimalToCatalog(TAnimal.Create('Жучка', 'Москва', akDog));
//    AnimalClient.AddAnimalToCatalog(TAnimal.Create('Матроскин', 'Простоквашино', akCat));
//    AnimalClient.AddAnimalToCatalog(TAnimal.Create('Кот камышовый', 'Россия', akCat));
//    AnimalClient.AddAnimalToCatalog(TAnimal.Create('Кот камышовый', 'Белоруссия', akCat));
//    AnimalClient.AddAnimalToCatalog(TAnimal.Create('Бульдог', 'Германия', akDog));
//    AnimalClient.AddAnimalToCatalog(TAnimal.Create('Бульдог', 'Италия', akDog));
    {$ENDREGION}

    {$REGION ' Factory Method '}
//    FMTruckFactory := TFMTruckFactory.Create();
//    FMTransport    := FMTruckFactory.New();
//    FMTransport.Deliver();
//
//    FMShipFactory  := TFMShipFactory.Create();
//    FMTransport    := FMShipFactory.New();
//    FMTransport.Deliver();
//
//    Readln;

//    ConferenceRoom1 := TWifiConferenceRoom.Create();
//    Projector1      := ConferenceRoom1.CreateProjector();
//
//    ConferenceRoom2 := TBluetoothConferenceRoom.Create();
//    Projector2      := ConferenceRoom2.CreateProjector();
//
//    Projector1.Update(2);
//    Projector1.Present('Cats information');
//
//    Projector2.Update(0);
//    Projector2.Present('Dogs information');
//
//    ConferenceRoom2.Sync(Projector1);
    {$ENDREGION}

    {$REGION ' Abstract Factory '}
//    Writeln('Client 1 orders classic furniture');
//    FurnitureClient := TFurnitureClient.Create(TClassicFurnitureFactory.Create());
//    FurnitureClient.DoOrder();
//
//    Writeln('Client 2 orders modern furniture');
//    FurnitureClient := TFurnitureClient.Create(TModernFurnitureFactory.Create());
//    FurnitureClient.DoOrder();
    {$ENDREGION}

    {$REGION ' Builder '}
//    Writeln('Client wants sport car');
//    CarClient := TCarClient.Create();
//    CarClient.GetCar(ctSportCar);
//
//    Writeln('Client wants truck');
//    CarClient.GetCar(ctTruck);
    {$ENDREGION}

    {$REGION ' Prototype '}
//    Writeln('Let''s create circle 1');
//    Circle1 := TCircle.Create(10, 20, 'red', 5);
//    Circle1.Name();
//    Writeln('Let''s clone circle 1');
//    Circle2 := Circle1.Clone();
//    Circle2.Name();
//
//    Shape1 := Circle1;
//    Shape2 := Shape1.Clone();
//    Shape2.Name();
    {$ENDREGION}

    {$REGION ' Singleton '}
//    Writeln('Let''s create message list');
//    MessageListVC := TMessageListVC.Create();
//    MessageListVC.StartReceiveingMessages();
//    Writeln('Sending messages to all subscribers');
//    TFriendChatService.GetInstance().SendMessages();
//
//    Writeln('Let''s create private chat');
//    PrivateChatVC := TPrivateChatVC.Create();
//    PrivateChatVC.StartReceiveingMessages();
//    Writeln('Sending messages to all subscribers');
//    TFriendChatService.GetInstance().SendMessages();
    {$ENDREGION}

    {$REGION ' Chain Of Responsibility '}
//    MonkeyHandler   := TMonkeyHandler.Create();
//    SquirrelHandler := TSquirrelHandler.Create();
//    DogHandler      := TDogHandler.Create();
//    MonkeyHandler.SetNextHandler(SquirrelHandler).SetNextHandler(DogHandler);
//
//    HandlerClient := THandlerClient.Create();
//    HandlerClient.Feed('Nuts',   MonkeyHandler);
//    HandlerClient.Feed('Banana', MonkeyHandler);
//    HandlerClient.Feed('Meat',   MonkeyHandler);
//    HandlerClient.Feed('Cup of coffee', MonkeyHandler);
//    HandlerClient.Feed('Banana', SquirrelHandler);
//
//    Writeln('');
//
//    AuthWebServiceHandler   := TAuthWebServiceHandler.Create();
//    AccessWebServiceHandler := TAccessWebServiceHandler.Create();
//    AuthWebServiceHandler.SetNextHandler(AccessWebServiceHandler);
//
//    WebServiceHandlerClient := TWebServiceHandlerClient.Create();
//    WebServiceHandlerClient.Connect('admin', 'admin', AuthWebServiceHandler);
//    WebServiceHandlerClient.Connect('admin', '123456', AuthWebServiceHandler);
//    WebServiceHandlerClient.Connect('Alex', '111', AuthWebServiceHandler);
//    WebServiceHandlerClient.Connect('Justas', '111', AuthWebServiceHandler);
//    WebServiceHandlerClient.Connect('Justas', '222', AuthWebServiceHandler);
    {$ENDREGION}

    {$REGION ' Command '}
//    MyApplication := TMyApplication.Create('Some text');
//    MyApplication.CreateUI();
//
//    MyApplication.ExecuteCommand(MyApplication.CutCommand);
//    MyApplication.ExecuteCommand(MyApplication.CutCommand);
//    MyApplication.ExecuteCommand(MyApplication.UndoCommand);
//    MyApplication.ExecuteCommand(MyApplication.UndoCommand);
//
//    MyApplication.ExecuteCommand(MyApplication.CopyCommand);
//    MyApplication.ExecuteCommand(MyApplication.CutCommand);
//    MyApplication.ExecuteCommand(MyApplication.CutCommand);
//    MyApplication.ExecuteCommand(MyApplication.CutCommand);
//    MyApplication.ExecuteCommand(MyApplication.PasteCommand);
//    MyApplication.ExecuteCommand(MyApplication.PasteCommand);
//    MyApplication.ExecuteCommand(MyApplication.PasteCommand);
//    MyApplication.ExecuteCommand(MyApplication.UndoCommand);
//    MyApplication.ExecuteCommand(MyApplication.UndoCommand);
//    MyApplication.ExecuteCommand(MyApplication.UndoCommand);
//    MyApplication.ExecuteCommand(MyApplication.UndoCommand);
//    MyApplication.ExecuteCommand(MyApplication.UndoCommand);
//    MyApplication.ExecuteCommand(MyApplication.UndoCommand);
    {$ENDREGION}

    {$REGION ' Iterator '}
//    SocialClient := TSocialClient.Create(TSocialSpammer.Create());
//    SocialClient.SendMessagesToFriends();
//    SocialClient.SendMessagesToEnemies();
    {$ENDREGION}

    {$REGION ' Mediator '}
//    MediatorContext := TMediatorContext.Create();
//    MediatorContext.UserLikedAllNews();
//    MediatorContext.UserDislikedAllNews();
    {$ENDREGION}

    {$REGION ' Memento '}
//    TextEditorClient := TTextEditorClient.Create();
//    TextEditorClient.DoSomeWork();
    {$ENDREGION}

    {$REGION ' Observer '}
//    ObserverContext := TObserverContext.Create();
//    ObserverContext.DoSomeWork();
    {$ENDREGION}

    {$REGION ' State '}
//    Player       := TMusicPlayer.Create();
//    PlayerClient := TUIPlayerClient.Create(Player);
//
//    PlayerClient.Player_Play();
//    PlayerClient.Player_Lock();
//    PlayerClient.Player_Stop();
//    PlayerClient.Player_Lock();
//    PlayerClient.Player_Stop();
//    PlayerClient.Player_Next();
//    PlayerClient.Player_Play();
//    PlayerClient.Player_Next();
//    PlayerClient.Player_Prev();
//    PlayerClient.Player_Play();
//    PlayerClient.Player_Stop();
    {$ENDREGION}

    {$REGION ' Strategy '}
//    MapNavigatorClient := TMapNavigatorClient.Create(TMapNavigator.Create());
//    MapNavigatorClient.GetRouteOnFoot();
//    MapNavigatorClient.GetRouteOnCar();
//    MapNavigatorClient.GetRouteOnPublicTransport();
    {$ENDREGION}

    {$REGION ' Template Method '}
//    GameContext := TGameContext.Create();
//    GameContext.TakePlayerTurn();
//    GameContext.TakeAITurn();
    {$ENDREGION}

    {$REGION ' Visitor '}
    MyGraphicsVisitor := TMyGraphicsVisitor.Create();
    MyDot   := TMyDot.Create();
    MyShape := TMyShape.Create();
    MyDot  .Accept(MyGraphicsVisitor);
    MyShape.Accept(MyGraphicsVisitor);

    Writeln('');

    NotificationClient := TNotificationClient.Create();
    NotificationClient.GetSomeMessagesWithDefaultPolicy();
    NotificationClient.GetSomeMessagesWithNightPolicy();
    {$ENDREGION}

    Writeln(sLineBreak + 'Press Enter to exit...');
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
