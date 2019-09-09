{***********************************************************}
{ Exemplo de lançamento de nota fiscal orientado a objetos, }
{ com banco de dados Oracle                                 }
{ Reinaldo Silveira - reinaldopsilveira@gmail.com           }
{ Franca/SP - set/2019                                      }
{***********************************************************}

unit U_NatOperacao;

interface

uses U_BaseControl, System.SysUtils, Data.DB;

type
  TTipoBusca = (tbCodigo, tbDescricao);

  TNatOperacao = class(TBaseControl)
  private
    FDESCRICAO: String;
    FCODCFO: String;
    procedure SetCODCFO(const Value: String);
    procedure SetDESCRICAO(const Value: String);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    property CODCFO: String read FCODCFO write SetCODCFO;
    property DESCRICAO: String read FDESCRICAO write SetDESCRICAO;

    function BuscaDados(pBusca: Variant; pBuscarPor: TTipoBusca): Boolean;
  end;

implementation

{ TNatOperacao }

function TNatOperacao.BuscaDados(pBusca: Variant; pBuscarPor: TTipoBusca): Boolean;
begin
  Query.Close;
  Query.SQL.Clear;
  Query.SQL.Add('select CODCFO, ');
  Query.SQL.Add('  DESCRICAO ');
  Query.SQL.Add('from TB_NATOPERACAO ');

  case pBuscarPor of
    tbCodigo   : Query.SQL.Add(Format('where CODCFO = %s', [QuotedStr(pBusca)]));
    tbDescricao: Query.SQL.Add(Format('where DESCRICAO = %s', [QuotedStr(pBusca)]));
  end;

  Query.Open;

  Result := not Query.IsEmpty;

  FCODCFO    := Query.Fields[0].AsString;
  FDESCRICAO := Query.Fields[1].AsString;
end;

procedure TNatOperacao.SetCODCFO(const Value: String);
begin
  FCODCFO := Value;
end;

procedure TNatOperacao.SetDESCRICAO(const Value: String);
begin
  FDESCRICAO := Value;
end;

end.
