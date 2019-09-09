{***********************************************************}
{ Exemplo de lançamento de nota fiscal orientado a objetos, }
{ com banco de dados Oracle                                 }
{ Reinaldo Silveira - reinaldopsilveira@gmail.com           }
{ Franca/SP - set/2019                                      }
{***********************************************************}

unit U_Conexao;

interface

uses
  System.Classes, Vcl.Forms, Data.DB, Data.SqlExpr, Data.DBXOracle,
  System.SysUtils;

type
  TConexao = class(TComponent)
  private
    { private declarations }
    FConexao: TSQLConnection;
    class var FInstance: TConexao;
    function GetConexao: TSQLConnection;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Conexao: TSQLConnection read GetConexao;

    class function GetInstance: TConexao;
  end;

implementation

{ TConexao }

constructor TConexao.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FConexao := TSQLConnection.Create(Self);
  try
    FConexao.LoginPrompt := False;
    FConexao.Params.Values['VendorLib']   := 'oci.dll';
    FConexao.Params.Values['LibraryName'] := 'dbxora.dll';
    FConexao.Params.Values['DataBase']    := 'xe';
    FConexao.Params.Values['User_Name']   := 'SYSTEM';
    FConexao.Params.Values['Password']    := '123456';
    FConexao.Params.Values['Decimal Separator'] := FormatSettings.DecimalSeparator;
    FConexao.Connected := True;
  except on E: Exception do
    raise Exception.CreateFmt('Erro ao conectar com o banco de dados: %s', [E.Message]);
  end;
end;

destructor TConexao.Destroy;
begin
  FConexao.Free;
  inherited;
end;

function TConexao.GetConexao: TSQLConnection;
begin
  Result := FConexao;
end;

class function TConexao.GetInstance: TConexao;
begin
  if not Assigned(FInstance) then
    FInstance := TConexao.Create(Application);
  Result := FInstance;
end;

end.
