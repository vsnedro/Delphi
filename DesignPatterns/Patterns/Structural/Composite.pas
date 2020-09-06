unit Composite;

interface

uses
  System.Generics.Collections;

type
  /// <summary>
  /// Leaf
  /// </summary>
  ILeaf = interface
    function GetName() : String;
    procedure Operation();

    property Name: String read GetName;
  end;

type
  /// <summary>
  /// Node
  /// </summary>
  INode = interface(ILeaf)
    procedure Add(
      const ALeaf : ILeaf);
    procedure Remove(
      const ALeaf : ILeaf);
  end;

type
  /// <summary>
  /// Custom Leaf
  /// </summary>
  TCustomLeaf = class abstract(
    TInterfacedObject, ILeaf)
  strict private
    FName: String;
  private
    function GetName() : String;
    procedure Operation(); virtual; abstract;
  public
    constructor Create(
      const AName : String);
  end;

type
  /// <summary>
  /// Leaf
  /// </summary>
  TLeaf = class(
    TCustomLeaf)
  private
    procedure Operation(); override;
  end;

type
  /// <summary>
  /// Leaf
  /// </summary>
  TNode = class(
    TCustomLeaf, INode)
  strict private
    FList : TList<ILeaf>;
  private
    procedure Operation(); override;
    procedure Add(
      const Value : ILeaf);
    procedure Remove(
      const Value : ILeaf);
  public
    constructor Create(
      const AName : String);
    destructor  Destroy(); override;
  end;

{==============================================================================}

type
  /// <summary>
  /// UI Theme
  /// </summary>
  IUITheme = interface
    function GetName() : String;
    function GetBackgroundColor() : String;
    procedure SetBackgroundColor(
      const Value : String);
    function GetHighlightColor() : String;
    procedure SetHighlightColor(
      const Value : String);
    function GetTextColor() : String;
    procedure SetTextColor(
      const Value : String);

    property Name: String read GetName;
    property BackgroundColor: String read GetBackgroundColor write SetBackgroundColor;
    property HighlightColor: String read GetHighlightColor write SetHighlightColor;
    property TextColor: String read GetTextColor write SetTextColor;
  end;

type
  /// <summary>
  /// UI Component
  /// </summary>
  IUIComponent = interface
    function GetName() : String;
    procedure SetTheme(
      const ATheme : IUITheme);

    property Name: String read GetName;
  end;

type
  /// <summary>
  /// UI Composite Component
  /// </summary>
  IUICompositeComponent = interface(IUIComponent)
    procedure Add(
      const AComponent : IUIComponent);
  end;

type
  /// <summary>
  /// UI Theme
  /// </summary>
  TUITheme = class(
    TInterfacedObject, IUITheme)
  strict private
    FName : String;
    FBackgroundColor : String;
    FHighlightColor : String;
    FTextColor : String;
  private
    function GetName() : String;
    function GetBackgroundColor() : String;
    procedure SetBackgroundColor(
      const Value : String);
    function GetHighlightColor() : String;
    procedure SetHighlightColor(
      const Value : String);
    function GetTextColor() : String;
    procedure SetTextColor(
      const Value : String);

    constructor Create(
      const AName           : String;
      const ABackgroundColor: String;
      const AHighlightColor : String;
      const ATextColor      : String);
  end;

type
  /// <summary>
  /// UI Custom Component
  /// </summary>
  TUICustomComponent = class abstract(
    TInterfacedObject, IUIComponent)
  strict protected
    FName : String;
  protected
    function GetName() : String;
    procedure SetTheme(
      const ATheme : IUITheme); virtual;

    constructor Create(
      const AParent : IUICompositeComponent;
      const AName   : String);
  end;

type
  /// <summary>
  /// UI Custom Composite Component
  /// </summary>
  TUICustomCompositeComponent = class abstract(
    TUICustomComponent, IUICompositeComponent)
  strict protected
    FList : TList<IUIComponent>;
  protected
    procedure SetTheme(
      const ATheme : IUITheme); override;
    procedure Add(
      const AComponent : IUIComponent);

    constructor Create(
      const AParent : IUICompositeComponent;
      const AName   : String);
    destructor  Destroy(); override;
  end;

type
  /// <summary>
  /// UI Form
  /// </summary>
  TUIForm = class(TUICustomCompositeComponent)
  strict private
    FBackgroundColor : String;
    FTextColor : String;
  protected
    procedure SetTheme(
      const ATheme : IUITheme); override;
  end;

type
  /// <summary>
  /// UI Label
  /// </summary>
  TUILabel = class(TUICustomComponent)
  strict private
    FBackgroundColor : String;
    FTextColor : String;
  protected
    procedure SetTheme(
      const ATheme : IUITheme); override;
  end;

type
  /// <summary>
  /// UI Button
  /// </summary>
  TUIButton = class(TUICustomComponent)
  strict private
    FBackgroundColor : String;
    FHighlightColor : String;
    FTextColor : String;
  protected
    procedure SetTheme(
      const ATheme : IUITheme); override;
  end;

implementation

uses
  System.SysUtils;

{------------------------------------------------------------------------------}
{ TCustomLeaf }
{------------------------------------------------------------------------------}

constructor TCustomLeaf.Create(
  const AName: String);
begin
  inherited Create();

  FName := AName;
end;

function TCustomLeaf.GetName(): String;
begin
  Result := FName;
end;

{------------------------------------------------------------------------------}
{ TLeaf }
{------------------------------------------------------------------------------}

procedure TLeaf.Operation();
begin
  Writeln('I am leaf ' + GetName());
end;

{------------------------------------------------------------------------------}
{ TNode }
{------------------------------------------------------------------------------}

constructor TNode.Create(
  const AName : String);
begin
  inherited Create(AName);

  FList := TList<ILeaf>.Create();
end;

destructor TNode.Destroy();
begin
  FreeAndNil(FList);

  inherited;
end;

procedure TNode.Operation();
var
  i : Integer;
begin
  Writeln('I am node ' + GetName());
  for i := 0 to FList.Count - 1 do
    FList[i].Operation();
end;

procedure TNode.Add(
  const Value: ILeaf);
begin
  FList.Add(Value);
end;

procedure TNode.Remove(
  const Value: ILeaf);
begin
  FList.Remove(Value);
end;

{==============================================================================}

{------------------------------------------------------------------------------}
{ TUITheme }
{------------------------------------------------------------------------------}

constructor TUITheme.Create(
  const AName           : String;
  const ABackgroundColor: String;
  const AHighlightColor : String;
  const ATextColor      : String);
begin
  inherited Create();

  FName            := AName;
  FBackgroundColor := ABackgroundColor;
  FHighlightColor  := AHighlightColor;
  FTextColor       := ATextColor;
end;

function TUITheme.GetName() : String;
begin
  Result := FName;
end;

function TUITheme.GetBackgroundColor() : String;
begin
  Result := FBackgroundColor;
end;

procedure TUITheme.SetBackgroundColor(
  const Value : String);
begin
  FBackgroundColor := Value;
end;

function TUITheme.GetHighlightColor() : String;
begin
  Result := FHighlightColor;
end;

procedure TUITheme.SetHighlightColor(
  const Value : String);
begin
  FHighlightColor := Value;
end;

function TUITheme.GetTextColor(): String;
begin
  Result := FTextColor;
end;

procedure TUITheme.SetTextColor(
  const Value: String);
begin
  FTextColor := Value;
end;

{------------------------------------------------------------------------------}
{ TUICustomComponent }
{------------------------------------------------------------------------------}

constructor TUICustomComponent.Create(
  const AParent: IUICompositeComponent;
  const AName  : String);
begin
  inherited Create();

  FName := AName;
  if Assigned(AParent) then
    AParent.Add(Self);
end;

function TUICustomComponent.GetName(): String;
begin
  Result := FName;
end;

procedure TUICustomComponent.SetTheme(
  const ATheme : IUITheme);
begin
  Writeln(Self.ClassName + ' ' + GetName() + ': Applying theme "' + ATheme.Name + '"');
end;

{------------------------------------------------------------------------------}
{ TUICustomCompositeComponent }
{------------------------------------------------------------------------------}
constructor TUICustomCompositeComponent.Create(
  const AParent: IUICompositeComponent;
  const AName  : String);
begin
  inherited Create(AParent, AName);

  FList := TList<IUIComponent>.Create();
end;

destructor TUICustomCompositeComponent.Destroy();
begin
  FreeAndNil(FList);

  inherited Destroy();
end;

procedure TUICustomCompositeComponent.SetTheme(
  const ATheme: IUITheme);
var
  i : Integer;
begin
  inherited;

  for i := 0 to FList.Count - 1 do
    FList[i].SetTheme(ATheme);
end;

procedure TUICustomCompositeComponent.Add(
  const AComponent: IUIComponent);
begin
  FList.Add(AComponent);
end;

{------------------------------------------------------------------------------}
{ TUIForm }
{------------------------------------------------------------------------------}

procedure TUIForm.SetTheme(
  const ATheme: IUITheme);
begin
  inherited;

  FBackgroundColor := ATheme.BackgroundColor;
  FTextColor       := ATheme.TextColor;

  Writeln(Self.ClassName + ' ' + GetName() + ': BackgroundColor = ' + FBackgroundColor);
  Writeln(Self.ClassName + ' ' + GetName() + ': TextColor = ' + FTextColor);
end;

{------------------------------------------------------------------------------}
{ TUILabel }
{------------------------------------------------------------------------------}

procedure TUILabel.SetTheme(
  const ATheme: IUITheme);
begin
  inherited;

  FBackgroundColor := ATheme.BackgroundColor;
  FTextColor       := ATheme.TextColor;

  Writeln(Self.ClassName + ' ' + GetName() + ': BackgroundColor = ' + FBackgroundColor);
  Writeln(Self.ClassName + ' ' + GetName() + ': TextColor = ' + FTextColor);
end;

{------------------------------------------------------------------------------}
{ TUIButton }
{------------------------------------------------------------------------------}

procedure TUIButton.SetTheme(
  const ATheme: IUITheme);
begin
  inherited;

  FBackgroundColor := ATheme.BackgroundColor;
  FHighlightColor  := ATheme.HighlightColor;
  FTextColor       := ATheme.TextColor;

  Writeln(Self.ClassName + ' ' + GetName() + ': BackgroundColor = ' + FBackgroundColor);
  Writeln(Self.ClassName + ' ' + GetName() + ': HighlightColor = ' + FHighlightColor);
  Writeln(Self.ClassName + ' ' + GetName() + ': TextColor = ' + FTextColor);
end;

end.
