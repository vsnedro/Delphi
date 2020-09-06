unit Prototype;

interface

type
  /// <summary>
  /// Shape
  /// </summary>
  IShape = interface
    ['{DC38B1F9-29D8-4EED-810B-F7C643FE53E5}']
    function GetX() : Integer;
    function GetY() : Integer;
    function GetColor() : String;

    function Clone() : IShape;
    procedure Name();

    property X: Integer read GetX;
    property Y: Integer read GetY;
    property Color: String read GetColor;
  end;

type
  /// <summary>
  /// Circle
  /// </summary>
  ICircle = interface(IShape)
    ['{55D33A27-48F7-4CF2-89D4-77A42BFFB788}']
    function GetRadius() : Integer;

    function Clone() : ICircle;

    property Radius: Integer read GetRadius;
  end;

type
  /// <summary>
  /// Rectangle
  /// </summary>
  IRectangle = interface(IShape)
    ['{DD3C59A0-12BB-40D1-A066-BCC8394FFA87}']
    function GetWidth() : Integer;
    function GetHeight() : Integer;

    function Clone() : IRectangle;

    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
  end;

type
  /// <summary>
  /// Shape
  /// </summary>
  TShape = class abstract(
    TInterfacedObject, IShape)
  strict protected
    FX: Integer;
    FY: Integer;
    FColor: String;
  private
    function GetX() : Integer;
    function GetY() : Integer;
    function GetColor() : String;

    function Clone() : IShape; virtual; abstract;
    procedure Name(); virtual; abstract;
  protected
    constructor Create(
      const AX: Integer;
      const AY: Integer;
      const AColor: String); overload;
    constructor Create(
      const ARectangle : IShape); overload;
  end;

type
  /// <summary>
  /// Circle
  /// </summary>
  TCircle = class(
    TShape, ICircle)
  strict private
    FRadius: Integer;
  private
    function GetRadius() : Integer;

    function Clone() : IShape; override;
    function CloneCircle() : ICircle;
    function ICircle.Clone = CloneCircle;

    procedure Name(); override;
  public
    constructor Create(
      const AX: Integer;
      const AY: Integer;
      const AColor: String;
      const ARadius: Integer); overload;
    constructor Create(
      const ARectangle : ICircle); overload;
  end;

type
  /// <summary>
  /// Rectangle
  /// </summary>
  TRectangle = class(
    TShape, IRectangle)
  strict private
    FWidth: Integer;
    FHeight: Integer;
  private
    function GetWidth() : Integer;
    function GetHeight() : Integer;

    function Clone() : IShape; override;
    function CloneRectangle() : IRectangle;
    function IRectangle.Clone = CloneRectangle;

    procedure Name(); override;
  public
    constructor Create(
      const AX: Integer;
      const AY: Integer;
      const AColor: String;
      const AWidth: Integer;
      const AHeight: Integer); overload;
    constructor Create(
      const ARectangle : IRectangle); overload;
  end;

implementation

uses
  System.SysUtils;

{------------------------------------------------------------------------------}
{ TShape }
{------------------------------------------------------------------------------}

constructor TShape.Create(
  const AX: Integer;
  const AY: Integer;
  const AColor: String);
begin
  inherited Create();

  FX     := AX;
  FY     := AY;
  FColor := AColor;
end;

constructor TShape.Create(
  const ARectangle: IShape);
begin
  inherited Create();

  FX     := ARectangle.X;
  FY     := ARectangle.Y;
  FColor := ARectangle.Color;
end;

function TShape.GetColor: String;
begin
  Result := FColor;
end;

function TShape.GetX: Integer;
begin
  Result := FX;
end;

function TShape.GetY: Integer;
begin
  Result := FY;
end;

{------------------------------------------------------------------------------}
{ TCircle }
{------------------------------------------------------------------------------}

constructor TCircle.Create(
  const AX: Integer;
  const AY: Integer;
  const AColor: String;
  const ARadius: Integer);
begin
  inherited Create(AX, AY, AColor);

  FRadius := ARadius;
end;

constructor TCircle.Create(
  const ARectangle: ICircle);
begin
  inherited Create(ARectangle);

  FRadius := ARectangle.Radius;
end;

function TCircle.GetRadius(): Integer;
begin
  Result := FRadius;
end;

procedure TCircle.Name();
begin
  Writeln(Format(
    'I am circle with coords (%d, %d), radius %d and color "%s"',
    [FX, FY, FRadius, FColor]));
end;

function TCircle.Clone(): IShape;
begin
  Result := CloneCircle();
end;

function TCircle.CloneCircle(): ICircle;
begin
  Result := TCircle.Create(Self);
end;

{------------------------------------------------------------------------------}
{ TRectangle }
{------------------------------------------------------------------------------}

constructor TRectangle.Create(
  const AX: Integer;
  const AY: Integer;
  const AColor: String;
  const AWidth: Integer;
  const AHeight: Integer);
begin
  inherited Create(AX, AY, AColor);

  FWidth  := AWidth;
  FHeight := AHeight;
end;

constructor TRectangle.Create(
  const ARectangle: IRectangle);
begin
  inherited Create(ARectangle);

  FWidth  := ARectangle.Width;
  FHeight := ARectangle.Height;
end;

function TRectangle.GetWidth: Integer;
begin
  Result := FWidth;
end;

procedure TRectangle.Name;
begin
  Writeln(Format(
    'I am rectangle with coords (%d, %d), width %d, height %s and color "%s"',
    [FX, FY, FWidth, FHeight, FColor]));
end;

function TRectangle.GetHeight: Integer;
begin
  Result := FHeight;
end;

function TRectangle.Clone(): IShape;
begin
  Result := CloneRectangle();
end;

function TRectangle.CloneRectangle: IRectangle;
begin
  Result := TRectangle.Create(Self);
end;

end.
