{***********************************************************}
{ Exemplo de lançamento de nota fiscal orientado a objetos, }
{ com banco de dados Oracle                                 }
{ Reinaldo Silveira - reinaldopsilveira@gmail.com           }
{ Franca/SP - set/2019                                      }
{***********************************************************}

unit U_Produto;

interface

uses U_BaseControl, System.SysUtils, Data.DB, Vcl.Controls;

type
  TTipoBusca = (tbID, tbDescricao);

  TProduto = class(TBaseControl)
  private
    FPRODUTO_ID: Integer;
    FPRECO: Double;
    FDESCRICAO: String;
    FUNIDADE: String;
    procedure SetDESCRICAO(const Value: String);
    procedure SetPRECO(const Value: Double);
    procedure SetPRODUTO_ID(const Value: Integer);
    procedure SetUNIDADE(const Value: String);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    property PRODUTO_ID: Integer read FPRODUTO_ID write SetPRODUTO_ID;
    property DESCRICAO: String read FDESCRICAO write SetDESCRICAO;
    property UNIDADE: String read FUNIDADE write SetUNIDADE;
    property PRECO: Double read FPRECO write SetPRECO;

    function BuscaDados(pBusca: Variant; pBuscarPor: TTipoBusca): Boolean;
    function Pesquisa(pPesq: String = ''): Boolean;
  end;

implementation

{ TProduto }

uses U_Pesquisa;

function TProduto.BuscaDados(pBusca: Variant; pBuscarPor: TTipoBusca): Boolean;
begin
  Query.Close;
  Query.SQL.Clear;
  Query.SQL.Add('select PRODUTO_ID, ');
  Query.SQL.Add('  DESCRICAO, ');
  Query.SQL.Add('  UNIDADE, ');
  Query.SQL.Add('  PRECO ');
  Query.SQL.Add('from TB_PRODUTO ');

  case pBuscarPor of
    tbID       : Query.SQL.Add(Format('where PRODUTO_ID = %d', [Integer(pBusca)]));
    tbDescricao: Query.SQL.Add(Format('where DESCRICAO = %s', [QuotedStr(pBusca)]));
  end;

  Query.Open;

  Result := not Query.IsEmpty;

  FPRODUTO_ID := Query.Fields[0].AsInteger;
  FDESCRICAO  := Query.Fields[1].AsString;
  FUNIDADE    := Query.Fields[2].AsString;
  FPRECO      := Query.Fields[3].AsFloat;
end;

function TProduto.Pesquisa(pPesq: String): Boolean;
begin
  if not Assigned(F_Pesquisa) then
    F_Pesquisa := TF_Pesquisa.Create(Self);
  try
    F_Pesquisa.Caption   := 'Pesquisa de Produtos';
    F_Pesquisa.SQL_BASE  := 'select PRODUTO_ID as "Código", DESCRICAO as "Descrição" from TB_PRODUTO';
    F_Pesquisa.SQL_WHERE := 'where DESCRICAO like %s';
    F_Pesquisa.SQL_ORDER := 'order by DESCRICAO';
    F_Pesquisa.edtPesquisa.Text := pPesq;
    F_Pesquisa.ShowModal;

    Result := F_Pesquisa.ModalResult = mrOk;

    if Result then
      Result := BuscaDados(F_Pesquisa.ID, tbID);
  finally
    FreeAndNil(F_Pesquisa);
  end;
end;

procedure TProduto.SetDESCRICAO(const Value: String);
begin
  FDESCRICAO := Value;
end;

procedure TProduto.SetPRECO(const Value: Double);
begin
  FPRECO := Value;
end;

procedure TProduto.SetPRODUTO_ID(const Value: Integer);
begin
  FPRODUTO_ID := Value;
end;

procedure TProduto.SetUNIDADE(const Value: String);
begin
  FUNIDADE := Value;
end;

end.
