{***********************************************************}
{ Exemplo de lançamento de nota fiscal orientado a objetos, }
{ com banco de dados Oracle                                 }
{ Reinaldo Silveira - reinaldopsilveira@gmail.com           }
{ Franca/SP - set/2019                                      }
{***********************************************************}

unit U_Fornecedor;

interface

uses U_BaseControl, System.SysUtils, Data.DB;

type
  TTipoBusca = (tbID, tbRazao, tbFantasia, tbCNPJ);

  TFornecedor = class(TBaseControl)
  private
    FCNPJ: String;
    FRAZAOSOCIAL: String;
    FFORNECEDOR_ID: Integer;
    FNOMEFANTASIA: String;
    procedure SetCNPJ(const Value: String);
    procedure SetFORNECEDOR_ID(const Value: Integer);
    procedure SetNOMEFANTASIA(const Value: String);
    procedure SetRAZAOSOCIAL(const Value: String);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    property FORNECEDOR_ID: Integer read FFORNECEDOR_ID write SetFORNECEDOR_ID;
    property RAZAOSOCIAL: String read FRAZAOSOCIAL write SetRAZAOSOCIAL;
    property NOMEFANTASIA: String read FNOMEFANTASIA write SetNOMEFANTASIA;
    property CNPJ: String read FCNPJ write SetCNPJ;

    function BuscaDados(pBusca: Variant; pBuscarPor: TTipoBusca): Boolean;
  end;

implementation

{ TFornecedor }

function TFornecedor.BuscaDados(pBusca: Variant; pBuscarPor: TTipoBusca): Boolean;
begin
  Query.Close;
  Query.SQL.Clear;
  Query.SQL.Add('select FORNECEDOR_ID, ');
  Query.SQL.Add('  RAZAOSOCIAL, ');
  Query.SQL.Add('  NOMEFANTASIA, ');
  Query.SQL.Add('  CNPJ ');
  Query.SQL.Add('from TB_FORNECEDOR ');

  case pBuscarPor of
    tbID      : Query.SQL.Add(Format('where FORNECEDOR_ID = %d', [Integer(pBusca)]));
    tbRazao   : Query.SQL.Add(Format('where RAZAOSOCIAL = %s', [QuotedStr(pBusca)]));
    tbFantasia: Query.SQL.Add(Format('where NOMEFANTASIA = %s', [QuotedStr(pBusca)]));
    tbCNPJ    : Query.SQL.Add(Format('where CNPJ = %s', [QuotedStr(pBusca)]));
  end;

  Query.Open;

  Result := not Query.IsEmpty;

  FFORNECEDOR_ID := Query.Fields[0].AsInteger;
  FRAZAOSOCIAL   := Query.Fields[1].AsString;
  FNOMEFANTASIA  := Query.Fields[2].AsString;
  FCNPJ          := Query.Fields[3].AsString;
end;

procedure TFornecedor.SetCNPJ(const Value: String);
begin
  FCNPJ := Value;
end;

procedure TFornecedor.SetFORNECEDOR_ID(const Value: Integer);
begin
  FFORNECEDOR_ID := Value;
end;

procedure TFornecedor.SetNOMEFANTASIA(const Value: String);
begin
  FNOMEFANTASIA := Value;
end;

procedure TFornecedor.SetRAZAOSOCIAL(const Value: String);
begin
  FRAZAOSOCIAL := Value;
end;

end.
