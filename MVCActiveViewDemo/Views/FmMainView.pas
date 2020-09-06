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
  MainControllerIntf,
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
    procedure Btn_CtoFClick(Sender: TObject);
    procedure Btn_FtoCClick(Sender: TObject);
  strict private
    FModel      : IConvertModel;
    FController : IMainController;
  private
    {$REGION ' IMainView '}
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
      AModel      : IConvertModel;
      AController : IMainController);
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
  AModel      : IConvertModel;
  AController : IMainController);
begin
  FModel      := AModel;
  FController := AController;

  FModel.Subscribe(Self);
end;

{$REGION ' IMainView '}
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

procedure TFm_MainView.Btn_CtoFClick(Sender: TObject);
begin
  FController.ConvertCelsiusToFahrenheit();
end;

procedure TFm_MainView.Btn_FtoCClick(Sender: TObject);
begin
  FController.ConvertFahrenheitToCelsius();
end;

end.
