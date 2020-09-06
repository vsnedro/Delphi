unit AbstractFactory;

interface

type
  /// <summary>
  /// Chair
  /// </summary>
  IChair = interface
    procedure Info();
  end;

type
  /// <summary>
  /// Table
  /// </summary>
  ITable = interface
    procedure Info();
  end;

type
  /// <summary>
  /// Sofa
  /// </summary>
  ISofa = interface
    procedure Info();
  end;

type
  /// <summary>
  /// Furniture Factory
  /// </summary>
  IFurnitureFactory = interface
    function CreateChair() : IChair;
    function CreateTable() : ITable;
    function CreateSofa() : ISofa;
  end;

type
  /// <summary>
  /// Classic Chair
  /// </summary>
  TClassicChair = class(
    TInterfacedObject, IChair)
  private
    procedure Info();
  end;

type
  /// <summary>
  /// Classic Table
  /// </summary>
  TClassicTable = class(
    TInterfacedObject, ITable)
  private
    procedure Info();
  end;

type
  /// <summary>
  /// Classic Sofa
  /// </summary>
  TClassicSofa = class(
    TInterfacedObject, ISofa)
  private
    procedure Info();
  end;

type
  /// <summary>
  /// Classic Furniture Factory
  /// </summary>
  TClassicFurnitureFactory = class(
    TInterfacedObject, IFurnitureFactory)
  private
    function CreateChair() : IChair;
    function CreateTable() : ITable;
    function CreateSofa() : ISofa;
  end;

type
  /// <summary>
  /// Modern Chair
  /// </summary>
  TModernChair = class(
    TInterfacedObject, IChair)
  private
    procedure Info();
  end;

type
  /// <summary>
  /// Modern Table
  /// </summary>
  TModernTable = class(
    TInterfacedObject, ITable)
  private
    procedure Info();
  end;

type
  /// <summary>
  /// Modern Sofa
  /// </summary>
  TModernSofa = class(
    TInterfacedObject, ISofa)
  private
    procedure Info();
  end;

type
  /// <summary>
  /// Modern Furniture Factory
  /// </summary>
  TModernFurnitureFactory = class(
    TInterfacedObject, IFurnitureFactory)
  private
    function CreateChair() : IChair;
    function CreateTable() : ITable;
    function CreateSofa() : ISofa;
  end;

type
  /// <summary>
  /// Furniture Client
  /// </summary>
  IFurnitureClient = interface
    procedure DoOrder();
  end;

type
  /// <summary>
  /// Furniture Client
  /// </summary>
  TFurnitureClient = class(
    TInterfacedObject, IFurnitureClient)
  strict private
    FFurnitureFactory : IFurnitureFactory;
  private
    procedure DoOrder();
  public
    constructor Create(
      const AFurnitureFactory : IFurnitureFactory);
  end;

implementation

{------------------------------------------------------------------------------}
{ TClassicChair }
{------------------------------------------------------------------------------}

procedure TClassicChair.Info;
begin
  Writeln('I am Classic Chair');
end;

{------------------------------------------------------------------------------}
{ TClassicTable }
{------------------------------------------------------------------------------}

procedure TClassicTable.Info;
begin
  Writeln('I am Classic Table');
end;

{------------------------------------------------------------------------------}
{ TClassicSofa }
{------------------------------------------------------------------------------}

procedure TClassicSofa.Info;
begin
  Writeln('I am Classic Sofa');
end;

{------------------------------------------------------------------------------}
{ TClassicFurnitureFactory }
{------------------------------------------------------------------------------}

function TClassicFurnitureFactory.CreateChair: IChair;
begin
  Result := TClassicChair.Create();
end;

function TClassicFurnitureFactory.CreateTable: ITable;
begin
  Result := TClassicTable.Create();
end;

function TClassicFurnitureFactory.CreateSofa: ISofa;
begin
  Result := TClassicSofa.Create();
end;

{------------------------------------------------------------------------------}
{ TModernChair }
{------------------------------------------------------------------------------}

procedure TModernChair.Info;
begin
  Writeln('I am Modern Chair');
end;

{------------------------------------------------------------------------------}
{ TModernTable }
{------------------------------------------------------------------------------}

procedure TModernTable.Info;
begin
  Writeln('I am Modern Table');
end;

{------------------------------------------------------------------------------}
{ TModernSofa }
{------------------------------------------------------------------------------}

procedure TModernSofa.Info;
begin
  Writeln('I am Modern Sofa');
end;

{------------------------------------------------------------------------------}
{ TModernFurnitureFactory }
{------------------------------------------------------------------------------}

function TModernFurnitureFactory.CreateChair: IChair;
begin
  Result := TModernChair.Create();
end;

function TModernFurnitureFactory.CreateTable: ITable;
begin
  Result := TModernTable.Create();
end;

function TModernFurnitureFactory.CreateSofa: ISofa;
begin
  Result := TModernSofa.Create();
end;

{------------------------------------------------------------------------------}
{ TFurnitureClient }
{------------------------------------------------------------------------------}

constructor TFurnitureClient.Create(
  const AFurnitureFactory: IFurnitureFactory);
begin
  inherited Create();

  FFurnitureFactory := AFurnitureFactory;
end;

procedure TFurnitureClient.DoOrder();
begin
  FFurnitureFactory.CreateChair().Info();
  FFurnitureFactory.CreateChair().Info();
  FFurnitureFactory.CreateTable().Info();
  FFurnitureFactory.CreateSofa().Info();
end;

end.
