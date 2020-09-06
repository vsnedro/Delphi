unit Decorator;

interface

uses
  System.Types;

type
  /// <summary>
  /// Math Operations
  /// </summary>
  IMathOper = interface
    ['{8B62723D-5274-4852-9760-3B5C0D7F2FD8}']
    function Min(
      const A, B : Integer) : Integer;
    function Max(
      const A, B : Integer) : Integer;
  end;

{------------------------------------------------------------------------------}

type
  /// <summary>
  /// Math Oper Decorator
  /// </summary>
  TMathOperDecorator = class(
    TInterfacedObject,
    IMathOper)
  strict private
    FMathOper : IMathOper;
  private
    function Min(
      const A, B : Integer) : Integer;
    function Max(
      const A, B : Integer) : Integer;
  public
    constructor Create(
      AMathOper: IMathOper);
  end;

{------------------------------------------------------------------------------}

type
  /// <summary>
  /// Notifier
  /// </summary>
  INotifier = interface
    procedure Send(
      const AMessage : String);
  end;

type
  /// <summary>
  /// Notifier
  /// </summary>
  TNotifier = class(
    TInterfacedObject,
    INotifier)
  private
    procedure Send(
      const AMessage : String);
  end;

type
  /// <summary>
  /// Notifier Decorator
  /// </summary>
  TNotifierDecorator = class abstract(
    TInterfacedObject,
    INotifier)
  strict private
    FNotifier : INotifier;
  private
    procedure Send(
      const AMessage : String); virtual;
  public
    constructor Create(
      ANotifier : INotifier);
  end;

type
  /// <summary>
  /// Sms Notifier Decorator
  /// </summary>
  TSmsNotifier = class(TNotifierDecorator)
    procedure Send(
      const AMessage : String); override;
  end;

type
  /// <summary>
  /// Email Notifier Decorator
  /// </summary>
  TEmailNotifier = class(TNotifierDecorator)
    procedure Send(
      const AMessage : String); override;
  end;

{------------------------------------------------------------------------------}

type
  /// <summary>
  /// Data Source
  /// </summary>
  IDataSource = interface
    function  Read() : String;
    procedure Write(
      const AData : String);
  end;

type
  /// <summary>
  /// File Data Source
  /// </summary>
  TFileDataSource = class(
    TInterfacedObject,
    IDataSource)
  strict private
    FFileName : String;
    FData     : String;
  private
    function  Read() : String;
    procedure Write(
      const AData : String);
  public
    constructor Create(
      const AFileName : String);
  end;

type
  /// <summary>
  /// File Data Source Decorator
  /// </summary>
  TFileDataSourceDecorator = class abstract(
    TInterfacedObject,
    IDataSource)
  strict private
    FDataSource : IDataSource;
  private
    function  Read() : String; virtual;
    procedure Write(
      const AData : String); virtual;
  public
    constructor Create(
      const ADataSource : IDataSource);
  end;

type
  /// <summary>
  /// File Data Source Decorator
  /// </summary>
  TSecureFileDataSource = class(
    TFileDataSourceDecorator)
  strict private
  const
    CSecretKey : Byte = 13;
  private
    function  Read() : String; override;
    procedure Write(
      const AData : String); override;
  end;

{==============================================================================}

type
  /// <summary>
  /// My Image
  /// </summary>
  IMyImage = interface;


  /// <summary>
  /// My Image Editor
  /// </summary>
  IMyImageEditor = interface
    function GetDescription() : String;
    function Proccess() : IMyImage;

    property Description: String read GetDescription;
  end;

  /// <summary>
  /// My Image
  /// </summary>
  IMyImage = interface(IMyImageEditor)
    function GetRect() : TRect;

    property Rect: TRect read GetRect;
  end;

type
  /// <summary>
  /// My Image
  /// </summary>
  TMyImage = class(
    TInterfacedObject, IMyImage)
  strict private
    FRect : TRect;
    FDescription: String;
  protected
    function GetRect() : TRect;
    function GetDescription() : String;
    function Proccess() : IMyImage;
  public
    constructor Create(
      const ARect       : TRect;
      const ADescription: String);
  end;

type
  /// <summary>
  /// My Image Editor Decorator
  /// </summary>
  TMyCustomImageEditorDecorator = class abstract(
    TInterfacedObject, IMyImageEditor)
  strict private
    FImageEditor : IMyImageEditor;
    FDescription: String;
  protected
    function GetDescription() : String;
    function Proccess() : IMyImage; virtual;
  public
    constructor Create(
      const AImageEditor: IMyImageEditor;
      const ADescription: String);
  end;

type
  /// <summary>
  /// Image Resizer
  /// </summary>
  TMyImageResizer = class(
    TMyCustomImageEditorDecorator)
  strict private
    FFactorX : Double;
    FFactorY : Double;
  protected
    function Proccess() : IMyImage; override;
  public
    constructor Create(
      const AImageEditor: IMyImageEditor;
      const ADescription: String;
      const AFactorX    : Double;
      const AFactorY    : Double);
  end;

type
  /// <summary>
  /// Custom Image Filter
  /// </summary>
  TMyCustomImageFilter = class abstract(
    TMyCustomImageEditorDecorator)
  strict protected
    FFilters : TArray<String>;
  protected
    function Proccess() : IMyImage; override;
  end;

type
  /// <summary>
  /// Blur Image Filter
  /// </summary>
  TMyBlurImageFilter = class abstract(
    TMyCustomImageFilter)
  public
    constructor Create(
      const AImageEditor: IMyImageEditor;
      const ADescription: String;
      const ARadius     : Integer);
  end;

type
  /// <summary>
  /// Color Image Filter
  /// </summary>
  TMyColorImageFilter = class abstract(
    TMyCustomImageFilter)
  public
    constructor Create(
      const AImageEditor: IMyImageEditor;
      const ADescription: String;
      const ASaturation : Integer;
      const ABrightness : Integer;
      const AContrast   : Integer);
  end;

implementation

uses
  System.SysUtils;

{------------------------------------------------------------------------------}
{ TLibraryMathOperDecorator }
{------------------------------------------------------------------------------}

constructor TMathOperDecorator.Create(
  AMathOper: IMathOper);
begin
  inherited Create();

  FMathOper := AMathOper;
end;

function TMathOperDecorator.Max(
  const A, B: Integer): Integer;
begin
  Writeln('A = ' + A.ToString());
  Writeln('B = ' + B.ToString());
  Result := FMathOper.Max(A, B);
  Writeln('Max = ' + Result.ToString());
end;

function TMathOperDecorator.Min(
  const A, B: Integer): Integer;
begin
  Writeln('A = ' + A.ToString());
  Writeln('B = ' + B.ToString());
  Result := FMathOper.Min(A, B);
  Writeln('Min = ' + Result.ToString());
end;

{------------------------------------------------------------------------------}
{ TNotifier }
{------------------------------------------------------------------------------}

procedure TNotifier.Send(
  const AMessage: String);
begin
  Writeln('Notify: ' + AMessage);
end;

{------------------------------------------------------------------------------}
{ TNotifierDecorator }
{------------------------------------------------------------------------------}

constructor TNotifierDecorator.Create(
  ANotifier: INotifier);
begin
  inherited Create();

  FNotifier := ANotifier;
end;

procedure TNotifierDecorator.Send(
  const AMessage: String);
begin
  FNotifier.Send(AMessage);
end;

{------------------------------------------------------------------------------}
{ TSmsNotifier }
{------------------------------------------------------------------------------}

procedure TSmsNotifier.Send(
  const AMessage: String);
begin
  inherited;

  Writeln('Sms: ' + AMessage);
end;

{------------------------------------------------------------------------------}
{ TEmailNotifier }
{------------------------------------------------------------------------------}

procedure TEmailNotifier.Send(
  const AMessage: String);
begin
  inherited;

  Writeln('Email: ' + AMessage);
end;

{------------------------------------------------------------------------------}
{ TFileDataSource }
{------------------------------------------------------------------------------}

constructor TFileDataSource.Create(
  const AFileName : String);
begin
  inherited Create();

  FFileName := AFileName;
end;

function TFileDataSource.Read(): String;
begin
  Result := FData;
  Writeln('FileDataSource Read = ' + Result);
end;

procedure TFileDataSource.Write(
  const AData: String);
begin
  Writeln('FileDataSource Write = ' + AData);
  FData := AData;
end;

{------------------------------------------------------------------------------}
{ TFileDataSourceDecorator }
{------------------------------------------------------------------------------}

constructor TFileDataSourceDecorator.Create(
  const ADataSource: IDataSource);
begin
  inherited Create();

  FDataSource := ADataSource;
end;

function TFileDataSourceDecorator.Read(): String;
begin
  Result := FDataSource.Read();
end;

procedure TFileDataSourceDecorator.Write(
  const AData: String);
begin
  FDataSource.Write(AData);
end;

{------------------------------------------------------------------------------}
{ TSecureFileDataSource }
{------------------------------------------------------------------------------}

function TSecureFileDataSource.Read(): String;
var
  i : Integer;
begin
  Result := inherited Read();

  for i := Low(Result) to High(Result) do
    Result[i] := Chr(Ord(Result[i]) xor CSecretKey);
  Writeln('Secure FileDataSource Read = ' + Result);
end;

procedure TSecureFileDataSource.Write(
  const AData: String);
var
  i   : Integer;
  Data: String;
begin
  Writeln('Secure FileDataSource Write = ' + AData);
  Data := AData;
  for i := Low(Data) to High(Data) do
    Data[i] := Chr(Ord(Data[i]) xor CSecretKey);

  inherited Write(Data);
end;

{==============================================================================}

{------------------------------------------------------------------------------}
{ TMyImage }
{------------------------------------------------------------------------------}

constructor TMyImage.Create(
  const ARect       : TRect;
  const ADescription: String);
begin
  inherited Create();

  FRect        := ARect;
  FDescription := ADescription;
end;

function TMyImage.GetDescription(): String;
begin
  Result := FDescription;
end;

function TMyImage.GetRect(): TRect;
begin
  Result := FRect;
end;

function TMyImage.Proccess() : IMyImage;
begin
  Result := Self;
end;

{------------------------------------------------------------------------------}
{ TMyCustomImageEditorDecorator }
{------------------------------------------------------------------------------}

constructor TMyCustomImageEditorDecorator.Create(
  const AImageEditor: IMyImageEditor;
  const ADescription: String);
begin
  inherited Create();

  FImageEditor := AImageEditor;
  FDescription := ADescription;
end;

function TMyCustomImageEditorDecorator.GetDescription() : String;
begin
  Result := FDescription;
end;

function TMyCustomImageEditorDecorator.Proccess() : IMyImage;
begin
  Result := FImageEditor.Proccess();
end;

{------------------------------------------------------------------------------}
{ TMyImageResizer }
{------------------------------------------------------------------------------}

constructor TMyImageResizer.Create(
  const AImageEditor: IMyImageEditor;
  const ADescription: String;
  const AFactorX    : Double;
  const AFactorY    : Double);
begin
  inherited Create(AImageEditor, ADescription);

  FFactorX := AFactorX;
  FFactorY := AFactorY;
end;

function TMyImageResizer.Proccess() : IMyImage;
begin
  Result := inherited Proccess();

  Writeln('Editor "' + GetDescription() + '" is applying to image "' + Result.Description + '"');
  Writeln(
    'Image is resized from ' + Result.Rect.Width.ToString() + ' x ' + Result.Rect.Height.ToString() +
    ' to ' + Round(Result.Rect.Width * FFactorX).ToString() + ' x ' + Round(Result.Rect.Height * FFactorY).ToString());
end;

{------------------------------------------------------------------------------}
{ TImageFilter }
{------------------------------------------------------------------------------}

function TMyCustomImageFilter.Proccess() : IMyImage;
var
  i : Integer;
begin
  Result := inherited Proccess();

  Writeln('Editor "' + GetDescription() + '" is applying to image "' + Result.Description + '"');
  for i := Low(FFilters) to High(FFilters) do
    Writeln('Filter "' + FFilters[i] + '" is applied to image');
end;

{------------------------------------------------------------------------------}
{ TMyBlurImageFilter }
{------------------------------------------------------------------------------}

constructor TMyBlurImageFilter.Create(
  const AImageEditor: IMyImageEditor;
  const ADescription: String;
  const ARadius     : Integer);
begin
  inherited Create(AImageEditor, ADescription);

  SetLength(FFilters, Length(FFilters) + 1);
  FFilters[Length(FFilters) - 1] := 'Gauss blur with radius ' + ARadius.ToString();
end;

{------------------------------------------------------------------------------}
{ TMyColorImageFilter }
{------------------------------------------------------------------------------}

constructor TMyColorImageFilter.Create(
  const AImageEditor: IMyImageEditor;
  const ADescription: String;
  const ASaturation : Integer;
  const ABrightness : Integer;
  const AContrast   : Integer);
begin
  inherited Create(AImageEditor, ADescription);

  SetLength(FFilters, Length(FFilters) + 1);
  FFilters[Length(FFilters) - 1] := 'Set saturation to ' + ASaturation.ToString();
  SetLength(FFilters, Length(FFilters) + 1);
  FFilters[Length(FFilters) - 1] := 'Set brightness to ' + ABrightness.ToString();
  SetLength(FFilters, Length(FFilters) + 1);
  FFilters[Length(FFilters) - 1] := 'Set contrast to ' + AContrast.ToString();
end;

end.
