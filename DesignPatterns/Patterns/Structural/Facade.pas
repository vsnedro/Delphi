unit Facade;

interface

{$REGION ' Area Calc '}
type
  /// <summary>
  /// Square Area Calc
  /// </summary>
  TSquareAreaCalc = class(TObject)
  strict private
    FWidth  : Integer;
    FHeight : Integer;
  public
    procedure SetWidth(
      const Value : Integer);
    procedure SetHeight(
      const Value : Integer);
    function Area() : Integer;
  end;
  
type
  /// <summary>
  /// Triangle Area Calc
  /// </summary>
  TTriangleAreaCalc = class(TObject)
    strict private
    FSide1  : Integer;
    FSide2  : Integer;
    FSide3  : Integer;
  public
    procedure SetSide1(
      const Value : Integer);
    procedure SetSide2(
      const Value : Integer);
    procedure SetSide3(
      const Value : Integer);
    function Area() : Double;
  end;
  
type
  /// <summary>
  /// Facade
  /// </summary>
  TAreaCalcFacade = class(TObject)
  public
    function SquareArea(
      const AWidth  : Integer;
      const AHeight : Integer) : Double;
    function TriangleArea(
      const ASide1 : Integer;
      const ASide2 : Integer;
      const ASide3 : Integer) : Double;
  end;
{$ENDREGION}

type
  /// <summary>
  /// My Image
  /// </summary>
  IMyImage = interface
  end;

type
  /// <summary>
  /// Image Download
  /// </summary>
  IImageDownload = interface
    function Download(
      const AURL : String) : IMyImage;
  end;

type
  /// <summary>
  /// Image Filter
  /// </summary>
  IImageFilter = interface
    function ApllyFilters(
      const AImage : IMyImage) : IMyImage;
  end;

type
  /// <summary>
  /// Image Library
  /// </summary>
  IImageLibrary = interface
    procedure Save(
      const AImage : IMyImage);
  end;

type
  /// <summary>
  /// Image Download Facade
  /// </summary>
  IImageDownloadFacade = interface
    procedure DownloadAndSave(
      const AURL : String);
  end;

type
  /// <summary>
  /// Image Client
  /// </summary>
  IImageClient = interface
    procedure DownloadImage(
      const AURL : String);
  end;

type
  /// <summary>
  /// My Image
  /// </summary>
  TMyImage = class(
    TInterfacedObject, IMyImage)
  end;

type
  /// <summary>
  /// Image Download
  /// </summary>
  TImageDownload = class(
    TInterfacedObject, IImageDownload)
  private
    function Download(
      const AURL : String) : IMyImage;
  end;

type
  /// <summary>
  /// Image Filter
  /// </summary>
  TImageFilter = class(
    TInterfacedObject, IImageFilter)
  private
    function ApllyFilters(
      const AImage : IMyImage) : IMyImage;
  end;

type
  /// <summary>
  /// Image Library
  /// </summary>
  TImageLibrary = class(
    TInterfacedObject, IImageLibrary)
  private
    procedure Save(
      const AImage : IMyImage);
  end;

type
  /// <summary>
  /// Image Download Facade
  /// </summary>
  TImageDownloadFacade = class(
    TInterfacedObject, IImageDownloadFacade)
  strict private
    FImageDownload : IImageDownload;
    FImageFilter   : IImageFilter;
    FImageLibrary  : IImageLibrary;
  private
    procedure DownloadAndSave(
      const AURL : String);
  public
    constructor Create(
      const AImageDownload : IImageDownload;
      const AImageFilter   : IImageFilter;
      const AImageLibrary  : IImageLibrary);
  end;

type
  /// <summary>
  /// Image Client
  /// </summary>
  TImageClient = class(
    TInterfacedObject, IImageClient)
  strict private
    FImageDownload : IImageDownloadFacade;
  private
    procedure DownloadImage(
      const AURL : String);
  public
    constructor Create(
      const AImageDownload : IImageDownloadFacade);
  end;

implementation

uses
  System.SysUtils;

{$REGION ' Area Calc '}
{------------------------------------------------------------------------------}
{ TSquareAreaCalc }
{------------------------------------------------------------------------------}

function TSquareAreaCalc.Area(): Integer;
begin
  Result := FHeight * FWidth;
end;

procedure TSquareAreaCalc.SetHeight(
  const Value: Integer);
begin
  FHeight := Value;
end;

procedure TSquareAreaCalc.SetWidth(
  const Value: Integer);
begin
  FWidth := Value;
end;

{------------------------------------------------------------------------------}
{ TTriangleAreaCalc }
{------------------------------------------------------------------------------}

function TTriangleAreaCalc.Area(): Double;
var
  p : Double;
begin
  p := (FSide1 + FSide2 + FSide3) / 2;
  Result := Sqrt(p * (p - FSide1) * (p - FSide2) *(p - FSide3));
end;

procedure TTriangleAreaCalc.SetSide1(
  const Value: Integer);
begin
  FSide1 := Value;
end;

procedure TTriangleAreaCalc.SetSide2(
  const Value: Integer);
begin
  FSide2 := Value;
end;

procedure TTriangleAreaCalc.SetSide3(
  const Value: Integer);
begin
  FSide3 := Value;
end;

{------------------------------------------------------------------------------}
{ TAreaCalcFacade }
{------------------------------------------------------------------------------}

function TAreaCalcFacade.SquareArea(
  const AWidth, AHeight: Integer): Double;
var
  Calc : TSquareAreaCalc;
begin
  Calc := TSquareAreaCalc.Create();
  try
    Calc.SetWidth(AWidth);
    Calc.SetHeight(AWidth);
    Result := Calc.Area();
  finally
    FreeAndNil(Calc);
  end;
end;

function TAreaCalcFacade.TriangleArea(
  const ASide1, ASide2, ASide3: Integer): Double;
var
  Calc : TTriangleAreaCalc;
begin
  Calc := TTriangleAreaCalc.Create();
  try
    Calc.SetSide1(ASide1);
    Calc.SetSide2(ASide2);
    Calc.SetSide3(ASide3);
    Result := Calc.Area();
  finally
    FreeAndNil(Calc);
  end;
end;
{$ENDREGION}

{------------------------------------------------------------------------------}
{ TImageDownload }
{------------------------------------------------------------------------------}

function TImageDownload.Download(
  const AURL: String): IMyImage;
begin
  Writeln('Downloading image from URL ' + AURL);
  Sleep(1000);
  Writeln('Done!');

  Result := TMyImage.Create();
end;

{------------------------------------------------------------------------------}
{ TImageFilter }
{------------------------------------------------------------------------------}

function TImageFilter.ApllyFilters(
  const AImage: IMyImage): IMyImage;
begin
  Writeln('Applying filters to image...');
  Sleep(1000);
  Writeln('Done!');

  Result := AImage;
end;

{------------------------------------------------------------------------------}
{ TImageLibrary }
{------------------------------------------------------------------------------}

procedure TImageLibrary.Save(
  const AImage: IMyImage);
begin
  Writeln('Saving image in library...');
  Sleep(1000);
  Writeln('Done!');
end;

{------------------------------------------------------------------------------}
{ TImageDownloadFacade }
{------------------------------------------------------------------------------}

constructor TImageDownloadFacade.Create(
  const AImageDownload : IImageDownload;
  const AImageFilter   : IImageFilter;
  const AImageLibrary  : IImageLibrary);
begin
  inherited Create();

  FImageDownload := AImageDownload;
  FImageFilter   := AImageFilter;
  FImageLibrary  := AImageLibrary;
end;

procedure TImageDownloadFacade.DownloadAndSave(
  const AURL: String);
var
  MyImage : IMyImage;
begin
  Writeln('Facade begin');

  MyImage := FImageDownload.Download(AURL);
  MyImage := FImageFilter.ApllyFilters(MyImage);
  FImageLibrary.Save(MyImage);

  Writeln('Facade end');
end;

{------------------------------------------------------------------------------}
{ TImageClient }
{------------------------------------------------------------------------------}

constructor TImageClient.Create(
  const AImageDownload: IImageDownloadFacade);
begin
  inherited Create();

  FImageDownload := AImageDownload;
end;

procedure TImageClient.DownloadImage(
  const AURL: String);
begin
  Writeln('Client is downloading image');
  FImageDownload.DownloadAndSave(AURL);
  Writeln('Client''s image is downloaded and saved');
end;

end.
