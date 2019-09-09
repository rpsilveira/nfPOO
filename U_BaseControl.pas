{***********************************************************}
{ Exemplo de lançamento de nota fiscal orientado a objetos, }
{ com banco de dados Oracle                                 }
{ Reinaldo Silveira - reinaldopsilveira@gmail.com           }
{ Franca/SP - set/2019                                      }
{***********************************************************}

unit U_BaseControl;

interface

uses
  System.Classes, Data.SqlExpr, System.SysUtils;

type
  TBaseControl = class(TComponent)
  private
    { private declarations }
    FQuery: TSQLQuery;
    function GetQuery: TSQLQuery;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Query: TSQLQuery read GetQuery;

    function GetID(pSeqName: String): Integer;
  end;

implementation

{ TBaseControl }

uses U_Conexao;

constructor TBaseControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FQuery := TSQLQuery.Create(Self);
  FQuery.SQLConnection := TConexao.GetInstance.Conexao;
end;

destructor TBaseControl.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function TBaseControl.GetID(pSeqName: String): Integer;
begin
  try
    Query.Close;
    Query.SQL.Text := Format('select %s.NEXTVAL from DUAL', [pSeqName]);
    Query.Open;

    Result := Query.Fields[0].AsInteger;
  except on E: Exception do
    raise Exception.CreateFmt('Erro ao obter o sequencial: %s', [E.message]);
  end;
end;

function TBaseControl.GetQuery: TSQLQuery;
begin
  Result := FQuery;
end;

end.
