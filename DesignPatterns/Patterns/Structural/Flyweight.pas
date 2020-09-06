unit Flyweight;

interface

uses
  System.Classes,
  System.Generics.Collections;

{$REGION ' Trees '}
type
  /// <summary>
  /// Tree Type
  /// </summary>
  ITreeType = interface
    function GetName(): String;
    function GetColor(): String;
    function GetTexture(): String;

    property Name: String read GetName;
    property Color: String read GetColor;
    property Texture: String read GetTexture;
  end;

type
  /// <summary>
  /// Tree
  /// </summary>
  ITree = interface
    function GetX(): Integer;
    function GetY(): Integer;
    function GetTreeType(): ITreeType;
    procedure Draw();

    property X: Integer read GetX;
    property Y: Integer read GetY;
    property TreeType: ITreeType read GetTreeType;
  end;

type
  /// <summary>
  /// Tree Factory
  /// </summary>
  ITreeFactory = interface
    function New(
      const AName   : String;
      const AColor  : String;
      const ATexture: String;
      const AX      : Integer;
      const AY      : Integer) : ITree;
  end;

type
  /// <summary>
  /// Forest
  /// </summary>
  IForest = interface
    procedure PlantTree(
      const AName   : String;
      const AColor  : String;
      const ATexture: String;
      const AX      : Integer;
      const AY      : Integer);
    procedure Draw();
  end;

type
  /// <summary>
  /// Tree Type
  /// </summary>
  TTreeType = class(
    TInterfacedObject, ITreeType)
  strict private
    FName: String;
    FColor: String;
    FTexture: String;
  private
    function GetName(): String;
    function GetColor(): String;
    function GetTexture(): String;
  public
    constructor Create(
      const AName: String;
      const AColor: String;
      const ATexture: String);
  end;

type
  /// <summary>
  /// Tree
  /// </summary>
  TTree = class(
    TInterfacedObject, ITree)
  strict private
    FX: Integer;
    FY: Integer;
    FTreeType: ITreeType;
  private
    function GetX(): Integer;
    function GetY(): Integer;
    function GetTreeType(): ITreeType;
    procedure Draw();
  public
    constructor Create(
      const AX        : Integer;
      const AY        : Integer;
      const ATreeType : ITreeType);
  end;

type
  /// <summary>
  /// Tree Factory
  /// </summary>
  TTreeFactory = class(
    TInterfacedObject, ITreeFactory)
  strict private
    FTreeTypes : TList<ITreeType>;
  private
    function New(
      const AName   : String;
      const AColor  : String;
      const ATexture: String;
      const AX      : Integer;
      const AY      : Integer) : ITree;
  public
    constructor Create();
    destructor  Destroy(); override;
  end;

type
  /// <summary>
  /// Forest
  /// </summary>
  TForest = class(
    TInterfacedObject, IForest)
  strict private
    FTrees : TList<ITree>;
    FTreeFactory : ITreeFactory;
  private
    procedure PlantTree(
      const AName   : String;
      const AColor  : String;
      const ATexture: String;
      const AX      : Integer;
      const AY      : Integer);
    procedure Draw();
  public
    constructor Create();
    destructor  Destroy(); override;
  end;
{$ENDREGION}

type
  /// <summary>
  /// Animal Kind
  /// </summary>
  TAnimalKind = (
    akCat,
    akDog
  );

const
  /// <summary>
  /// Animal Name
  /// </summary>
  CAnimalName : array [TAnimalKind] of String = (
    'cat',
    'dog'
  );

type
  /// <summary>
  /// Animal
  /// </summary>
  IAnimal = interface
    function GetName() : String;
    function GetCountry() : String;
    function GetKind() : TAnimalKind;

    property Name: String read GetName;
    property Country: String read GetCountry;
    property Kind: TAnimalKind read GetKind;
  end;

type
  /// <summary>
  /// Animal Photo
  /// </summary>
  IAnimalPhoto = interface
  end;

type
  /// <summary>
  /// Animal In Catalog
  /// </summary>
  IAnimalInCatalog = interface
    function GetAnimal() : IAnimal;
    function GetPhoto() : IAnimalPhoto;

    property Animal: IAnimal read GetAnimal;
    property Photo: IAnimalPhoto read GetPhoto;
  end;

type
  /// <summary>
  /// Animal Catalog
  /// </summary>
  IAnimalCatalog = interface
    procedure Update(
      const AAnimal : IAnimal);
  end;

type
  /// <summary>
  /// Animal Photo Catalog
  /// </summary>
  IAnimalPhotoCatalog = interface
    function Photo(
      const AAnimal : IAnimal) : IAnimalPhoto;
  end;

type
  /// <summary>
  /// Animal Client
  /// </summary>
  IAnimalClient = interface
    procedure AddAnimalToCatalog(
      const AAnimal : IAnimal);
  end;

type
  /// <summary>
  /// Animal
  /// </summary>
  TAnimal = class(
    TInterfacedObject, IAnimal)
  strict private
    FName: String;
    FCountry: String;
    FKind: TAnimalKind;
  private
    function GetName() : String;
    function GetCountry() : String;
    function GetKind() : TAnimalKind;
  public
    constructor Create(
      const AName   : String;
      const ACountry: String;
      const AKind   : TAnimalKind);
  end;

type
  /// <summary>
  /// Animal Photo
  /// </summary>
  TAnimalPhoto = class(
    TInterfacedObject, IAnimalPhoto)
  end;

type
  /// <summary>
  /// Animal In Catalog
  /// </summary>
  TAnimalInCatalog = class(
    TInterfacedObject, IAnimalInCatalog)
  strict private
    FAnimal: IAnimal;
    FPhoto: IAnimalPhoto;
  private
    function GetAnimal() : IAnimal;
    function GetPhoto() : IAnimalPhoto;
  public
    constructor Create(
      const AAnimal: IAnimal;
      const APhoto: IAnimalPhoto);
  end;

type
  /// <summary>
  /// Animal Catalog
  /// </summary>
  TAnimalCatalog = class(
    TInterfacedObject, IAnimalCatalog)
  strict private
    FAnimals      : TList<IAnimalInCatalog>;
    FPhotoCatalog : IAnimalPhotoCatalog;
  private
    procedure Update(
      const AAnimal : IAnimal);
  public
    constructor Create(
      APhotoCatalog : IAnimalPhotoCatalog);
    destructor  Destroy(); override;
  end;

type
  /// <summary>
  /// Animal Photo Catalog
  /// </summary>
  TAnimalPhotoCatalog = class(
    TInterfacedObject, IAnimalPhotoCatalog)
  strict private
    FPhotoCatalog : TDictionary<String, IAnimalPhoto>;
  private
    function Photo(
      const AAnimal : IAnimal) : IAnimalPhoto;
  public
    constructor Create();
    destructor  Destroy(); override;
  end;

type
  /// <summary>
  /// Animal Client
  /// </summary>
  TAnimalClient = class(
    TInterfacedObject, IAnimalClient)
  strict private
    FAnimalCatalog : IAnimalCatalog;
  private
    procedure AddAnimalToCatalog(
      const AAnimal : IAnimal);
  public
    constructor Create(
      const AAnimalCatalog : IAnimalCatalog);
  end;

implementation

uses
  System.SysUtils;

{$REGION ' Trees '}
{------------------------------------------------------------------------------}
{ TTreeType }
{------------------------------------------------------------------------------}

constructor TTreeType.Create(
  const AName: String;
  const AColor: String;
  const ATexture: String);
begin
  inherited Create();

  FName    := AName;
  FColor   := AColor;
  FTexture := ATexture;
end;

function TTreeType.GetName(): String;
begin
  Result := FName;
end;

function TTreeType.GetColor(): String;
begin
  Result := FColor;
end;

function TTreeType.GetTexture(): String;
begin
  Result := FTexture;
end;


{------------------------------------------------------------------------------}
{ TTree }
{------------------------------------------------------------------------------}

constructor TTree.Create(
  const AX        : Integer;
  const AY        : Integer;
  const ATreeType : ITreeType);
begin
  inherited Create();

  FX        := AX;
  FY        := AY;
  FTreeType := ATreeType;
end;

function TTree.GetX() : Integer;
begin
  Result := FX;
end;

function TTree.GetY() : Integer;
begin
  Result := FY;
end;

function TTree.GetTreeType() : ITreeType;
begin
  Result := FTreeType;
end;

procedure TTree.Draw();
begin
  Writeln(
    'I am tree "' + FTreeType.Name +
    '", my color is ' + FTreeType.Color +
    ', at ' + FX.ToString() + ', ' + FY.ToString());
end;

{------------------------------------------------------------------------------}
{ TTreeFactory }
{------------------------------------------------------------------------------}

constructor TTreeFactory.Create();
begin
  inherited Create();

  FTreeTypes := TList<ITreeType>.Create();
end;

destructor TTreeFactory.Destroy();
begin
  FreeAndNil(FTreeTypes);

  inherited Destroy();
end;

function TTreeFactory.New(
  const AName   : String;
  const AColor  : String;
  const ATexture: String;
  const AX      : Integer;
  const AY      : Integer) : ITree;
var
  i        : Integer;
  treeType : ITreeType;
begin
  treeType := nil;
  for i := 0 to FTreeTypes.Count - 1 do
    if AnsiSameText(FTreeTypes[i].Name, AName) and
       AnsiSameText(FTreeTypes[i].Color, AColor) and
       AnsiSameText(FTreeTypes[i].Texture, ATexture) then
    begin
      treeType := FTreeTypes[i];
      Writeln('Found tree type: ' + treeType.Name + ', ' + treeType.Color);
      Break;
    end;

  if not Assigned(treeType) then
  begin
    treeType := TTreeType.Create(AName, AColor, ATexture);
    FTreeTypes.Add(treeType);
    Writeln('New tree type: ' + treeType.Name + ', ' + treeType.Color);
  end;

  Result := TTree.Create(AX, AY, treeType);
end;

{------------------------------------------------------------------------------}
{ TForest }
{------------------------------------------------------------------------------}

constructor TForest.Create();
begin
  inherited Create();

  FTrees       := TList<ITree>.Create();
  FTreeFactory := TTreeFactory.Create();
end;

destructor TForest.Destroy();
begin
  FreeAndNil(FTrees);

  inherited Destroy();
end;

procedure TForest.PlantTree(
  const AName   : String;
  const AColor  : String;
  const ATexture: String;
  const AX      : Integer;
  const AY      : Integer);
var
  tree : ITree;
begin
  tree := FTreeFactory.New(AName, AColor, ATexture, AX, AY);
  FTrees.Add(tree);
end;

procedure TForest.Draw();
var
  i : Integer;
begin
  for i := 0 to FTrees.Count - 1 do
    FTrees[i].Draw();
end;
{$ENDREGION}

{------------------------------------------------------------------------------}
{ TAnimal }
{------------------------------------------------------------------------------}

constructor TAnimal.Create(
  const AName   : String;
  const ACountry: String;
  const AKind   : TAnimalKind);
begin
  inherited Create();

  FName    := AName;
  FCountry := ACountry;
  FKind    := AKind;
end;

function TAnimal.GetName(): String;
begin
  Result := FName;
end;

function TAnimal.GetCountry(): String;
begin
  Result := FCountry;
end;

function TAnimal.GetKind(): TAnimalKind;
begin
  Result := FKind;
end;

{------------------------------------------------------------------------------}
{ TAnimalInCatalog }
{------------------------------------------------------------------------------}

constructor TAnimalInCatalog.Create(
  const AAnimal: IAnimal;
  const APhoto : IAnimalPhoto);
begin
  inherited Create();

  FAnimal := AAnimal;
  FPhoto  := APhoto;
end;

function TAnimalInCatalog.GetAnimal(): IAnimal;
begin
  Result := FAnimal;
end;

function TAnimalInCatalog.GetPhoto(): IAnimalPhoto;
begin
  Result := FPhoto;
end;

{------------------------------------------------------------------------------}
{ TAnimalCatalog }
{------------------------------------------------------------------------------}

constructor TAnimalCatalog.Create(
  APhotoCatalog: IAnimalPhotoCatalog);
begin
  inherited Create();

  FPhotoCatalog := APhotoCatalog;
  FAnimals      := TList<IAnimalInCatalog>.Create();
end;

destructor TAnimalCatalog.Destroy();
begin
  FreeAndNil(FAnimals);

  inherited Destroy();
end;

procedure TAnimalCatalog.Update(
  const AAnimal: IAnimal);
begin
  Writeln(
    'Animal catalog: adding information about ' +
    CAnimalName[AAnimal.Kind] + ' "' + AAnimal.Name + '" from ' + AAnimal.Country);

  FAnimals.Add(TAnimalInCatalog.Create(
    {AAnimal}AAnimal,
    {APhoto }FPhotoCatalog.Photo(AAnimal)));

  Writeln('Animal catalog: information is added');
end;

{------------------------------------------------------------------------------}
{ TAnimalPhotoCatalog }
{------------------------------------------------------------------------------}

constructor TAnimalPhotoCatalog.Create();
begin
  inherited Create();

  FPhotoCatalog := TDictionary<String, IAnimalPhoto>.Create();
end;

destructor TAnimalPhotoCatalog.Destroy();
begin
  FreeAndNil(FPhotoCatalog);

  inherited Destroy();
end;

function TAnimalPhotoCatalog.Photo(
  const AAnimal: IAnimal): IAnimalPhoto;
var
  Photo : IAnimalPhoto;
begin
  if not FPhotoCatalog.TryGetValue(AAnimal.Name, {out}Photo) then
  begin
    Writeln('Photo catalog: can''t find photo for "' + AAnimal.Name + '", creating a new one');
    Photo := TAnimalPhoto.Create();
    FPhotoCatalog.Add(AAnimal.Name, Photo);
  end
  else
    Writeln('Photo catalog: photo for "' + AAnimal.Name + '" is found');

  Result := Photo;
end;

{------------------------------------------------------------------------------}
{ TAnimalClient }
{------------------------------------------------------------------------------}

constructor TAnimalClient.Create(
  const AAnimalCatalog: IAnimalCatalog);
begin
  inherited Create();

  FAnimalCatalog := AAnimalCatalog;
end;

procedure TAnimalClient.AddAnimalToCatalog(
  const AAnimal : IAnimal);
begin
  Writeln('Client: I want to add new animal in catalog');

  FAnimalCatalog.Update(AAnimal);
end;

end.
