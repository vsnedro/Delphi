unit Command;

interface

uses
  System.Generics.Collections;

type
  /// <summary>
  /// My Editor
  /// </summary>
  IMyEditor = interface
    ['{1C6875B3-4035-4FE0-A755-576728B935AC}']
    function  GetText() : String;
    procedure SetText(
      const AValue : String);

    function  GetSelection() : String;
    procedure DeleteSelection();
    procedure ReplaceSelection(
      const AText : String);

    procedure Backup();
    procedure Restore();

    property Text: String read GetText write SetText;
  end;

type
  /// <summary>
  /// My Command
  /// </summary>
  IMyCommand = interface
    ['{63DDAFA5-046A-4E34-8E16-83664D417AE2}']
    function  Execute() : Boolean;
    procedure Undo();
  end;

type
  /// <summary>
  /// My Application
  /// </summary>
  IMyApplication = interface
    ['{E39BB911-5571-4D78-9B62-1F7C291C6FF1}']
    function  GetClipboard() : String;
    procedure SetClipboard(
      const AValue : String);
    function GetCopyCommand() : IMyCommand;
    function GetPasteCommand() : IMyCommand;
    function GetCutCommand() : IMyCommand;
    function GetUndoCommand() : IMyCommand;

    procedure CreateUI();

    procedure ExecuteCommand(
      const ACommand : IMyCommand);
    procedure Undo();

    property Clipboard    : String     read GetClipboard write SetClipboard;
    property CopyCommand  : IMyCommand read GetCopyCommand;
    property PasteCommand : IMyCommand read GetPasteCommand;
    property CutCommand   : IMyCommand read GetCutCommand;
    property UndoCommand  : IMyCommand read GetUndoCommand;
  end;

type
  /// <summary>
  /// My Editor
  /// </summary>
  TMyEditor = class(
    TInterfacedObject, IMyEditor)
  strict private
    FText   : String;
    FBackup : TStack<String>;
  private
    function  GetText() : String;
    procedure SetText(
      const AValue : String);
  public
    constructor Create();
    destructor  Destroy(); override;

    function  GetSelection() : String;
    procedure DeleteSelection();
    procedure ReplaceSelection(
      const AText : String);

    procedure Backup();
    procedure Restore();
  end;

type
  /// <summary>
  /// My Application
  /// </summary>
  TMyApplication = class(
    TInterfacedObject, IMyApplication)
  strict private
    FEditor   : IMyEditor;
    FClipboard: String;
    FHistory  : TStack<IMyCommand>;

    FCopyCommand  : IMyCommand;
    FPasteCommand : IMyCommand;
    FCutCommand   : IMyCommand;
    FUndoCommand  : IMyCommand;
  private
    function  GetClipboard() : String;
    procedure SetClipboard(
      const AValue : String);
    function GetCopyCommand() : IMyCommand;
    function GetPasteCommand() : IMyCommand;
    function GetCutCommand() : IMyCommand;
    function GetUndoCommand() : IMyCommand;
  public
    constructor Create(
      const AText : String = '');
    destructor  Destroy(); override;

    procedure CreateUI();

    procedure ExecuteCommand(
      const ACommand : IMyCommand);
    procedure Undo();
  end;

type
  /// <summary>
  /// My Command
  /// </summary>
  TMyCustomCommand = class abstract(
    TInterfacedObject, IMyCommand)
  strict protected
    FEditor      : IMyEditor;
    FApplication : IMyApplication;

    procedure DoBackup();
  public
    constructor Create(
      const AApplication : IMyApplication;
      const AEditor      : IMyEditor);

    function  Execute() : Boolean; virtual; abstract;
    procedure Undo();
  end;

type
  /// <summary>
  /// My Copy Command
  /// </summary>
  TMyCopyCommand = class(TMyCustomCommand)
  public
    function  Execute() : Boolean; override;
  end;

type
  /// <summary>
  /// My Paste Command
  /// </summary>
  TMyPasteCommand = class(TMyCustomCommand)
  public
    function  Execute() : Boolean; override;
  end;

type
  /// <summary>
  /// My Cut Command
  /// </summary>
  TMyCutCommand = class(TMyCustomCommand)
  public
    function  Execute() : Boolean; override;
  end;

type
  /// <summary>
  /// My Undo Command
  /// </summary>
  TMyUndoCommand = class(TMyCustomCommand)
  public
    function  Execute() : Boolean; override;
  end;

implementation

uses
  System.SysUtils;

{------------------------------------------------------------------------------}
{ TMyEditor }
{------------------------------------------------------------------------------}

constructor TMyEditor.Create();
begin
  inherited Create();

  FBackup := TStack<String>.Create();
end;

destructor TMyEditor.Destroy();
begin
  FreeAndNil(FBackup);

  inherited Destroy();
end;

function TMyEditor.GetText() : String;
begin
  Result := FText;
end;

procedure TMyEditor.SetText(
  const AValue : String);
begin
  FText := AValue;
  Writeln('Editor: Text was set and now is ' + FText.QuotedString('"'));
end;

function TMyEditor.GetSelection() : String;
begin
  Result := FText.Substring(0, 1);;
  Writeln('Editor: Selected text is ' + Result.QuotedString('"'));
end;

procedure TMyEditor.DeleteSelection();
begin
  FText := FText.Remove(0, 1);
  Writeln('Editor: Selected text was deleted and now text is ' + FText.QuotedString('"'));
end;

procedure TMyEditor.ReplaceSelection(
  const AText : String);
begin
  FText := FText + AText;
  Writeln('Editor: Selected text was replaced and now text is ' + FText.QuotedString('"'));
end;

procedure TMyEditor.Backup();
begin
  FBackup.Push(GetText());
end;

procedure TMyEditor.Restore();
begin
  SetText(FBackup.Pop());
end;

{------------------------------------------------------------------------------}
{ TMyApplication }
{------------------------------------------------------------------------------}

constructor TMyApplication.Create(
  const AText : String = '');
begin
  inherited Create();

  FEditor  := TMyEditor.Create();
  FHistory := TStack<IMyCommand>.Create();

  FEditor.Text := AText;
end;

destructor TMyApplication.Destroy();
begin
  FreeAndNil(FHistory);

  inherited Destroy();
end;

procedure TMyApplication.CreateUI();
begin
  FCopyCommand  := TMyCopyCommand .Create(Self, FEditor);
  FPasteCommand := TMyPasteCommand.Create(Self, FEditor);
  FCutCommand   := TMyCutCommand  .Create(Self, FEditor);
  FUndoCommand  := TMyUndoCommand .Create(Self, FEditor);
end;

function TMyApplication.GetClipboard(): String;
begin
  Result := FClipboard;
end;

procedure TMyApplication.SetClipboard(
  const AValue: String);
begin
  FClipboard := AValue;
end;

function TMyApplication.GetCopyCommand() : IMyCommand;
begin
  Result := FCopyCommand;
end;

function TMyApplication.GetCutCommand() : IMyCommand;
begin
  Result := FCutCommand;
end;

function TMyApplication.GetPasteCommand() : IMyCommand;
begin
  Result := FPasteCommand;
end;

function TMyApplication.GetUndoCommand() : IMyCommand;
begin
  Result := FUndoCommand;
end;

procedure TMyApplication.ExecuteCommand(
  const ACommand : IMyCommand);
begin
  if ACommand.Execute() then
    FHistory.Push(ACommand);
end;

procedure TMyApplication.Undo();
var
  Cmd : IMyCommand;
begin
  if (FHistory.Count > 0) then
  begin
    Cmd := FHistory.Pop();
    Cmd.Undo();
  end;
end;

{------------------------------------------------------------------------------}
{ TMyCustomCommand }
{------------------------------------------------------------------------------}

constructor TMyCustomCommand.Create(
  const AApplication : IMyApplication;
  const AEditor      : IMyEditor);
begin
  inherited Create();

  FApplication := AApplication;
  FEditor      := AEditor;
end;

procedure TMyCustomCommand.DoBackup();
begin
  FEditor.Backup();
end;

procedure TMyCustomCommand.Undo();
begin
  FEditor.Restore();
end;

{------------------------------------------------------------------------------}
{ TMyCopyCommand }
{------------------------------------------------------------------------------}

function TMyCopyCommand.Execute(): Boolean;
begin
  Writeln('Command: Copy');
  FApplication.Clipboard := FEditor.GetSelection();
  Result := False;
end;

{------------------------------------------------------------------------------}
{ TMyPasteCommand }
{------------------------------------------------------------------------------}

function TMyPasteCommand.Execute(): Boolean;
begin
  Writeln('Command: Paste');
  DoBackup();
  FEditor.ReplaceSelection(FApplication.Clipboard);
  Result := True;
end;

{------------------------------------------------------------------------------}
{ TMyCutCommand }
{------------------------------------------------------------------------------}

function TMyCutCommand.Execute(): Boolean;
begin
  Writeln('Command: Cut');
  DoBackup();
  FApplication.Clipboard := FEditor.GetSelection();
  FEditor.DeleteSelection();
  Result := True;
end;

{------------------------------------------------------------------------------}
{ TMyUndoCommand }
{------------------------------------------------------------------------------}

function TMyUndoCommand.Execute(): Boolean;
begin
  Writeln('Command: Undo');
  FApplication.Undo();
  Result := False;
end;

end.
