unit FmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFm_Main = class(TForm)
    Pnl_1: TPanel;
    Lbl_1: TLabel;
    TEdt_Min: TEdit;
    Lbl_11: TLabel;
    TEdt_Max: TEdit;
    Btn_Generate: TButton;
    Label1: TLabel;
    TEdt_Result: TEdit;
    Btn_Reset: TButton;
    Lbl_Caption: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Btn_GenerateClick(Sender: TObject);
    procedure Btn_ResetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fm_Main: TFm_Main;

implementation

{$R *.dfm}

procedure TFm_Main.FormCreate(Sender: TObject);
begin
  Randomize();
end;

procedure TFm_Main.Btn_GenerateClick(Sender: TObject);
var
  Min, Max : Integer;
begin
  if (Length(TEdt_Min.Text) <= 0) or not TryStrToInt(TEdt_Min.Text, {out}Min) then
    TEdt_Min.Text := '1';
  if (Length(TEdt_Max.Text) <= 0) or not TryStrToInt(TEdt_Max.Text, {out}Max) then
    TEdt_Min.Text := '100';

  Min := StrToInt(TEdt_Min.Text);
  Max := StrToInt(TEdt_Max.Text);

  if (Max <= Min) then
  begin
    Max := Min + 1;
    TEdt_Max.Text := Max.ToString();
  end;

  TEdt_Result.Text := (Min + Random(Max - Min + 1)).ToString();
end;

procedure TFm_Main.Btn_ResetClick(Sender: TObject);
begin
  Randomize();
  TEdt_Min.Text := '1';
  TEdt_Max.Text := '100';
end;

end.
