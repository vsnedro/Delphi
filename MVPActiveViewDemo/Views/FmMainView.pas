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
  MainPresenterIntf,
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
    procedure Btn_CtoFClick(Sender: TObject);
    procedure Btn_FtoCClick(Sender: TObject);
  strict private
    FPresenter : IMainPresenter;
  private
    {$REGION ' IMainView '}
    function  GetCelsius() : Double;
    procedure SetCelsius(
      const AValue : Double);
    function  GetFahrenheit() : Double;
    procedure SetFahrenheit(
      const AValue : Double);
    {$ENDREGION}
  public
    { Public declarations }
    procedure Init(
      APresenter : IMainPresenter);
  end;

var
  Fm_MainView: TFm_MainView;

implementation

{$R *.dfm}

{------------------------------------------------------------------------------}
{ TFm_MainView }
{------------------------------------------------------------------------------}

procedure TFm_MainView.Init(
  APresenter : IMainPresenter);
begin
  FPresenter := APresenter;
end;

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
{$ENDREGION}

procedure TFm_MainView.Btn_CtoFClick(Sender: TObject);
begin
  FPresenter.ConvertCelsiusToFahrenheit();
end;

procedure TFm_MainView.Btn_FtoCClick(Sender: TObject);
begin
  FPresenter.ConvertFahrenheitToCelsius();
end;

end.
