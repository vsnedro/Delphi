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
  ObserverIntf,
  ConvertModelIntf,
  MainViewIntf;

type
  TFm_MainView = class(
    TForm,
    IMainView,
    IObserver)
    {$REGION ' Components '}
    TEdt_C: TEdit;
    TEdt_F: TEdit;
    Lbl_C: TLabel;
    Lbl_F: TLabel;
    Btn_CtoF: TButton;
    Btn_FtoC: TButton;
    {$ENDREGION}
  strict private
    FModel: IConvertModel;
  private
    {$REGION ' IMainView '}
    procedure SetOnConvertCelsiusToFahrenheit(
      const AValue: TNotifyEvent);
    procedure SetOnConvertFahrenheitToCelsius(
      const AValue: TNotifyEvent);

    function GetCelsius() : Double;
    function GetFahrenheit() : Double;
    {$ENDREGION}
    {$REGION ' IObserver '}
    procedure Notify();
    {$ENDREGION}
  public
    { Public declarations }
    destructor Destroy(); override;

    procedure Init(
      AModel: IConvertModel);
  end;

var
  Fm_MainView: TFm_MainView;

implementation

{$R *.dfm}

{------------------------------------------------------------------------------}
{ TFm_MainView }
{------------------------------------------------------------------------------}

destructor TFm_MainView.Destroy();
begin
  FModel.Unsubscribe(Self);

  inherited Destroy();
end;

procedure TFm_MainView.Init(
  AModel: IConvertModel);
begin
  FModel := AModel;

  FModel.Subscribe(Self);
end;

{$REGION ' IMainView '}
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

function TFm_MainView.GetCelsius(): Double;
begin
  Result := StrToFloatDef(TEdt_C.Text, 0);
end;

function TFm_MainView.GetFahrenheit(): Double;
begin
  Result := StrToFloatDef(TEdt_F.Text, 0);
end;
{$ENDREGION}

{$REGION ' IObserver '}
procedure TFm_MainView.Notify();
begin
  TEdt_C.Text := FModel.Celsius.ToString();
  TEdt_F.Text := FModel.Fahrenheit.ToString();
end;
{$ENDREGION}

end.
