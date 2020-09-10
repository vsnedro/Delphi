unit TemplateMethod;

interface

type
  /// <summary>
  /// Game AI
  /// </summary>
  IGameAI = interface
    ['{D0C4F105-DFD8-4D06-9AFC-C876F45245FB}']
    procedure TakeTurn();
  end;

type
  /// <summary>
  /// Game Context
  /// </summary>
  IGameContext = interface
    ['{B664D536-A0A8-40A5-AD92-EA3385FAD30E}']
    procedure TakePlayerTurn();
    procedure TakeAITurn();
  end;

{------------------------------------------------------------------------------}

type
  /// <summary>
  /// Game Custom AI
  /// </summary>
  TGameCustomAI = class abstract(
    TInterfacedObject, IGameAI)
  private
    procedure TakeTurn();
  protected
    FGold   : Integer;
    FLumber : Integer;
  protected
    procedure CollectResources(); virtual;
    function BuildStructure() : Boolean; virtual; abstract;
    procedure StructureIsBuilt(); virtual;
    function BuildUnit() : Boolean; virtual; abstract;
    procedure UnitIsBuilt(); virtual;
  end;

type
  /// <summary>
  /// Game Human AI
  /// </summary>
  TGameHumanAI = class(
    TGameCustomAI)
  protected
    function BuildStructure() : Boolean; override;
    function BuildUnit() : Boolean; override;
  end;

type
  /// <summary>
  /// Game Orc AI
  /// </summary>
  TGameOrcAI = class(
    TGameCustomAI)
  protected
    function BuildStructure() : Boolean; override;
    procedure StructureIsBuilt(); override;
    function BuildUnit() : Boolean; override;
    procedure UnitIsBuilt(); override;
  end;

type
  /// <summary>
  /// Game Context
  /// </summary>
  TGameContext = class(
    TInterfacedObject, IGameContext)
  strict private
    FHumanAI : IGameAI;
    FOrcAI   : IGameAI;
  private
    procedure TakePlayerTurn();
    procedure TakeAITurn();
  public
    constructor Create();
  end;

implementation

{------------------------------------------------------------------------------}
{ TGameCustomAI }
{------------------------------------------------------------------------------}

procedure TGameCustomAI.TakeTurn();
begin
  CollectResources();
  if BuildStructure() then
    StructureIsBuilt();
  if BuildUnit() then
    UnitIsBuilt();
end;

procedure TGameCustomAI.CollectResources();
begin
  Inc(FGold, 100);
  Inc(FLumber, 150);
end;

procedure TGameCustomAI.StructureIsBuilt();
begin
  Writeln('Work complete!');
end;

procedure TGameCustomAI.UnitIsBuilt();
begin
  Writeln('Unit is ready!');
end;

{------------------------------------------------------------------------------}
{ TGameHumanAI }
{------------------------------------------------------------------------------}

function TGameHumanAI.BuildStructure() : Boolean;
begin
  Writeln('Human AI: Let''s build the Library');
  Result := True;
end;

function TGameHumanAI.BuildUnit() : Boolean;
begin
  Writeln('Human AI: Let''s build the Scout');
  Result := True;
end;

{------------------------------------------------------------------------------}
{ TGameOrcAI }
{------------------------------------------------------------------------------}

function TGameOrcAI.BuildStructure(): Boolean;
begin
  Writeln('Orc AI: Let''s build the Barracs');
  Result := True;
end;

procedure TGameOrcAI.StructureIsBuilt();
begin
  inherited;
  Writeln('Zag-zag!');
end;

function TGameOrcAI.BuildUnit(): Boolean;
begin
  Writeln('Orc AI: Let''s build Grunt');
  Result := True;
end;

procedure TGameOrcAI.UnitIsBuilt();
begin
  inherited;
  Writeln('Zag-zag!');
end;

{------------------------------------------------------------------------------}
{ TGameContext }
{------------------------------------------------------------------------------}

constructor TGameContext.Create();
begin
  inherited Create();

  FHumanAI := TGameHumanAI.Create();
  FOrcAI   := TGameOrcAI.Create();
end;


procedure TGameContext.TakePlayerTurn();
begin
  Writeln('Game: Now Player takes his turn...');
end;

procedure TGameContext.TakeAITurn();
begin
  Writeln('Game: Now AI takes his turn...');
  FHumanAI.TakeTurn();
  FOrcAI.TakeTurn();
end;

end.
