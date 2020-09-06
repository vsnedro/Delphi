unit FmMainView;

interface

uses
  {VCL}
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  {App}
  MainViewIntf;

type
  TFm_MainView = class(
    TForm,
    IMainView)
    {$REGION ' Components '}
    TEdt_C: TEdit;
    TEdt_F: TEdit;
    Lbl_C: TLabel;
    Lbl_F: TLabel;
    Btn_CtoF: TButton;
    Btn_FtoC: TButton;
    {$ENDREGION}
  private
    {$REGION ' IMainView '}
    function  GetCelsius() : Double;
    procedure SetCelsius(
      const AValue : Double);
    function  GetFahrenheit() : Double;
    procedure SetFahrenheit(
      const AValue : Double);
    { Events }
    procedure SetOnConvertCelsiusToFahrenheit(
      const AValue: TNotifyEvent);
    procedure SetOnConvertFahrenheitToCelsius(
      const AValue: TNotifyEvent);
    {$ENDREGION}
  public
    { Public declarations }
  end;

var
  Fm_MainView: TFm_MainView;

implementation

{$R *.dfm}

{------------------------------------------------------------------------------}
{ TFm_MainView }
{------------------------------------------------------------------------------}

{$REGION ' IMainView '}
function TFm_MainView.GetCelsius(): Double;
begin
  Result := StrToFloatDef(TEdt_C.Text, 0);
end;

procedure TFm_MainView.SetCelsius(
  const AValue: Double);
begin
  TEdt_C.Text := AValue.ToString();
end;

function TFm_MainView.GetFahrenheit(): Double;
begin
  Result := StrToFloatDef(TEdt_F.Text, 0);
end;

procedure TFm_MainView.SetFahrenheit(
  const AValue: Double);
begin
  TEdt_F.Text := AValue.ToString();
end;

{ Events }

procedure TFm_MainView.SetOnConvertCelsiusToFahrenheit(
  const AValue: TNotifyEvent);
begin
  Btn_CtoF.OnClick := AValue;
end;

procedure TFm_MainView.SetOnConvertFahrenheitToCelsius(
  const AValue: TNotifyEvent);
begin
  Btn_FtoC.OnClick := AValue;
end;
{$ENDREGION}

end.
