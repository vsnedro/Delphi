unit Memento;

interface

uses
  System.Generics.Collections;

type
  /// <summary>
  /// Text Editor Data
  /// </summary>
  ITextEditorCore = interface
    ['{FBF0C9A3-0085-444B-9B14-9AEE29537205}']
    function  GetText() : String;
    procedure SetText(
      const AValue : String);
    function  GetColor() : String;
    procedure SetColor(
      const AValue : String);
    function  GetFont() : String;
    procedure SetFont(
      const AValue : String);

    property Text  : String read GetText write SetText;
    property Color : String read GetColor write SetColor;
    property Font  : String read GetFont write SetFont;
  end;

type
  /// <summary>
  /// Text Memento
  /// </summary>
  ITextMemento = interface
    ['{C207644A-6C41-4037-887E-15D1B4919648}']
    function GetTitle() : String;
    function GetDate() : TDateTime;

    property Title : String read GetTitle;
    property Date  : TDateTime read GetDate;
  end;

type
  /// <summary>
  /// Text Editor
  /// </summary>
  ITextEditor = interface(ITextEditorCore)
    ['{2B6589B6-D606-4F3B-B89C-F5A25073F6C7}']
    function  Backup(
      const ATitle : String) : ITextMemento;
    procedure Restore(
      const AMemento : ITextMemento);
  end;

type
  /// <summary>
  /// Text Editor Client
  /// </summary>
  ITextEditorClient = interface
    ['{F4C5E793-4774-431B-87F1-87259CC16776}']
    procedure DoSomeWork();
  end;

type
  /// <summary>
  /// Text Editor Data
  /// </summary>
  TTextEditorCore = class(
    TInterfacedObject, ITextEditorCore)
  strict protected
    FText  : String;
    FColor : String;
    FFont  : String;
  private
    function  GetText() : String;
    procedure SetText(
      const AValue : String);
    function  GetColor() : String;
    procedure SetColor(
      const AValue : String);
    function  GetFont() : String;
    procedure SetFont(
      const AValue : String);
  end;

type
  /// <summary>
  /// Text Memento
  /// </summary>
  TTextMemento = class(
    TTextEditorCore, ITextMemento)
  strict private
    FTitle : String;
    FDate  : TDateTime;
  private
    function GetTitle() : String;
    function GetDate() : TDateTime;
  public
    constructor Create(
      const ATitle : String;
      const ADate  : TDateTime);
  end;

type
  /// <summary>
  /// Text Editor
  /// </summary>
  TTextEditor = class(
    TTextEditorCore, ITextEditor)
  private
    function  Backup(
      const ATitle : String) : ITextMemento;
    procedure Restore(
      const AMemento : ITextMemento);
  end;

type
  /// <summary>
  /// Text Editor Client
  /// </summary>
  TTextEditorClient = class(
    TTextEditorCore, ITextEditorClient)
  strict private
    FEditor    : ITextEditor;
    FUndoStack : TStack<ITextMemento>;

    procedure WriteEditorState();
  private
    procedure DoSomeWork();
  end;

implementation

uses
  System.SysUtils;

{------------------------------------------------------------------------------}
{ TTextEditorCore }
{------------------------------------------------------------------------------}

function TTextEditorCore.GetColor(): String;
begin
  Result := FColor;
end;

procedure TTextEditorCore.SetColor(
  const AValue: String);
begin
  FColor := AValue;
end;

function TTextEditorCore.GetFont(): String;
begin
  Result := FFont;
end;

procedure TTextEditorCore.SetFont(
  const AValue: String);
begin
  FFont := AValue;
end;

function TTextEditorCore.GetText(): String;
begin
  Result := FText;
end;

procedure TTextEditorCore.SetText(
  const AValue: String);
begin
  FText := AValue;
end;

{------------------------------------------------------------------------------}
{ TTextMemento }
{------------------------------------------------------------------------------}

constructor TTextMemento.Create(
  const ATitle: String;
  const ADate: TDateTime);
begin
  inherited Create();

  FTitle := ATitle;
  FDate  := ADate;
end;

function TTextMemento.GetTitle(): String;
begin
  Result := FTitle;
end;

function TTextMemento.GetDate(): TDateTime;
begin
  Result := FDate;
end;

{------------------------------------------------------------------------------}
{ TTextEditor }
{------------------------------------------------------------------------------}

function TTextEditor.Backup(
  const ATitle : String): ITextMemento;
var
  M : TTextMemento;
begin
  M := TTextMemento.Create(ATitle, Now());
  M.SetText(FText);
  M.SetColor(FColor);
  M.SetFont(FFont);

  Result := M;
end;

procedure TTextEditor.Restore(
  const AMemento: ITextMemento);
var
  T : ITextEditorCore;
begin
  T := AMemento as ITextEditorCore;
  FText  := T.Text;
  FColor := T.Color;
  FFont  := T.Font;
end;

{------------------------------------------------------------------------------}
{ TTextEditorClient }
{------------------------------------------------------------------------------}

procedure TTextEditorClient.DoSomeWork();
begin
  FUndoStack := TStack<ITextMemento>.Create();
  try
    FEditor := TTextEditor.Create();

    Writeln('Client: Now I write some text with red color');
    FEditor.Color := 'Red';
    FEditor.Font  := 'Tahoma';
    FEditor.Text  := 'Some text';
    WriteEditorState();

    FUndoStack.Push(FEditor.Backup('Save1'));

    Writeln('Client: Now I write another text with black color');
    FEditor.Color := 'Black';
    FEditor.Font  := 'Courier';
    FEditor.Text  := 'Another text';
    WriteEditorState();

    FUndoStack.Push(FEditor.Backup('Save2'));

    Writeln('Client: Now I delete text');
    FEditor.Color := 'Default';
    FEditor.Font  := 'Default';
    FEditor.Text  := '';
    WriteEditorState();

    Writeln('Client: Now I undo last action');
    FEditor.Restore(FUndoStack.Pop());
    WriteEditorState();

    Writeln('Client: Now I undo last action once more');
    FEditor.Restore(FUndoStack.Pop());
    WriteEditorState();
  finally
    FreeAndNil(FUndoStack);
  end;
end;

procedure TTextEditorClient.WriteEditorState();
begin
  Writeln('Editor.Color = ' + FEditor.Color);
  Writeln('Editor.Font = ' + FEditor.Font);
  Writeln('Editor.Text = ' + FEditor.Text);
end;

end.
