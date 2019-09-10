{***********************************************************}
{ Exemplo de lançamento de nota fiscal orientado a objetos, }
{ com banco de dados Oracle                                 }
{ Reinaldo Silveira - reinaldopsilveira@gmail.com           }
{ Franca/SP - set/2019                                      }
{***********************************************************}

unit U_NotaFiscal;

interface

uses System.Classes, U_BaseControl, U_Fornecedor, U_Produto, U_NatOperacao,
  System.SysUtils, Data.DBXCommon;

type
  TNFItem = class(TCollectionItem)
  private
    FNAT_OPERACAO: TNatOperacao;
    FPRODUTO: TProduto;
    FVR_IPI: Double;
    FALIQ_ICMS: Double;
    FVR_DESCONTO: Double;
    FVR_UNITARIO: Double;
    FVR_ICMS: Double;
    FNF_ID: Integer;
    FITEM: Integer;
    FQUANTIDADE: Double;
    FVR_TOTAL_ITEM: Double;
    FALIQ_IPI: Double;
    FPERC_DESCONTO: Double;
    procedure SetALIQ_ICMS(const Value: Double);
    procedure SetALIQ_IPI(const Value: Double);
    procedure SetITEM(const Value: Integer);
    procedure SetNAT_OPERACAO(const Value: TNatOperacao);
    procedure SetNF_ID(const Value: Integer);
    procedure SetPERC_DESCONTO(const Value: Double);
    procedure SetPRODUTO(const Value: TProduto);
    procedure SetQUANTIDADE(const Value: Double);
    procedure SetVR_DESCONTO(const Value: Double);
    procedure SetVR_ICMS(const Value: Double);
    procedure SetVR_IPI(const Value: Double);
    procedure SetVR_TOTAL_ITEM(const Value: Double);
    procedure SetVR_UNITARIO(const Value: Double);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    property NF_ID: Integer read FNF_ID write SetNF_ID;
    property ITEM: Integer read FITEM write SetITEM;
    property PRODUTO: TProduto read FPRODUTO write SetPRODUTO;
    property QUANTIDADE: Double read FQUANTIDADE write SetQUANTIDADE;
    property VR_UNITARIO: Double read FVR_UNITARIO write SetVR_UNITARIO;
    property NAT_OPERACAO: TNatOperacao read FNAT_OPERACAO write SetNAT_OPERACAO;
    property ALIQ_IPI: Double read FALIQ_IPI write SetALIQ_IPI;
    property VR_IPI: Double read FVR_IPI write SetVR_IPI;
    property PERC_DESCONTO: Double read FPERC_DESCONTO write SetPERC_DESCONTO;
    property VR_DESCONTO: Double read FVR_DESCONTO write SetVR_DESCONTO;
    property ALIQ_ICMS: Double read FALIQ_ICMS write SetALIQ_ICMS;
    property VR_ICMS: Double read FVR_ICMS write SetVR_ICMS;
    property VR_TOTAL_ITEM: Double read FVR_TOTAL_ITEM write SetVR_TOTAL_ITEM;
  end;

  TItens = class(TOwnedCollection)
  private
    function GetItem(index: Integer): TNFItem;
    procedure SetItem(index: Integer; const Value: TNFItem);
  public
    function Add: TNFItem;
    procedure Delete(Index: Integer);
    property Items[index: Integer]: TNFItem read GetItem write SetItem;
  end;

  TNotaFiscal = class(TBaseControl)
  private
    FVR_IPI: Double;
    FDT_ENTRADA: TDate;
    FSERIE: String;
    FVR_ICMS: Double;
    FVR_ITENS: Double;
    FNUMERO: Integer;
    FNF_ID: Integer;
    FDT_EMISSAO: TDate;
    FVR_TOTAL: Double;
    FFORNECEDOR: TFornecedor;
    FVR_BASE_ICMS: Double;
    FItensNF: TItens;
    procedure SetDT_EMISSAO(const Value: TDate);
    procedure SetDT_ENTRADA(const Value: TDate);
    procedure SetFORNECEDOR(const Value: TFornecedor);
    procedure SetNF_ID(const Value: Integer);
    procedure SetNUMERO(const Value: Integer);
    procedure SetSERIE(const Value: String);
    procedure SetVR_BASE_ICMS(const Value: Double);
    procedure SetVR_ICMS(const Value: Double);
    procedure SetVR_IPI(const Value: Double);
    procedure SetVR_ITENS(const Value: Double);
    procedure SetVR_TOTAL(const Value: Double);
    procedure SetItensNF(const Value: TItens);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property NF_ID: Integer read FNF_ID write SetNF_ID;
    property FORNECEDOR: TFornecedor read FFORNECEDOR write SetFORNECEDOR;
    property NUMERO: Integer read FNUMERO write SetNUMERO;
    property SERIE: String read FSERIE write SetSERIE;
    property DT_EMISSAO: TDate read FDT_EMISSAO write SetDT_EMISSAO;
    property DT_ENTRADA: TDate read FDT_ENTRADA write SetDT_ENTRADA;
    property VR_ITENS: Double read FVR_ITENS write SetVR_ITENS;
    property VR_IPI: Double read FVR_IPI write SetVR_IPI;
    property VR_BASE_ICMS: Double read FVR_BASE_ICMS write SetVR_BASE_ICMS;
    property VR_TOTAL: Double read FVR_TOTAL write SetVR_TOTAL;
    property VR_ICMS: Double read FVR_ICMS write SetVR_ICMS;
    property ItensNF: TItens read FItensNF write SetItensNF;

    function Incluir: Boolean;
  end;

implementation

{ TNotaFiscal }

uses U_Conexao;

constructor TNotaFiscal.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItensNF := TItens.Create(Self, TNFItem);
end;

destructor TNotaFiscal.Destroy;
begin
  FItensNF.Free;
  inherited;
end;

function TNotaFiscal.Incluir: Boolean;
var
  tran: TDBXTransaction;
  i: Integer;
begin
  NF_ID := GetID('SEQ_TB_NOTAFISCAL');

  try
    tran := TConexao.GetInstance.Conexao.BeginTransaction;

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('insert into TB_NOTAFISCAL( ');
    Query.SQL.Add('  NF_ID, ');
    Query.SQL.Add('  FORNECEDOR_ID, ');
    Query.SQL.Add('  NUMERO, ');
    Query.SQL.Add('  SERIE, ');
    Query.SQL.Add('  DT_EMISSAO, ');
    Query.SQL.Add('  DT_ENTRADA, ');
    Query.SQL.Add('  VR_ITENS, ');
    Query.SQL.Add('  VR_IPI, ');
    Query.SQL.Add('  VR_BASE_ICMS, ');
    Query.SQL.Add('  VR_ICMS, ');
    Query.SQL.Add('  VR_TOTAL) ');
    Query.SQL.Add('values( ');
    Query.SQL.Add(Format('%d, ', [FNF_ID]));
    Query.SQL.Add(Format('%d, ', [FFORNECEDOR.FORNECEDOR_ID]));
    Query.SQL.Add(Format('%d, ', [FNUMERO]));
    Query.SQL.Add(Format('%s, ', [QuotedStr(FSERIE)]));
    Query.SQL.Add(Format('%s, ', [QuotedStr(FormatDateTime('dd/mm/yyyy', FDT_EMISSAO))]));
    Query.SQL.Add(Format('%s, ', [QuotedStr(FormatDateTime('dd/mm/yyyy', FDT_ENTRADA))]));
    Query.SQL.Add(Format('%s, ', [FloatToSQL(FVR_ITENS)]));
    Query.SQL.Add(Format('%s, ', [FloatToSQL(FVR_IPI)]));
    Query.SQL.Add(Format('%s, ', [FloatToSQL(FVR_BASE_ICMS)]));
    Query.SQL.Add(Format('%s, ', [FloatToSQL(FVR_ICMS)]));
    Query.SQL.Add(Format('%s) ', [FloatToSQL(FVR_TOTAL)]));
    Query.ExecSQL;

    for i := 0 to ItensNF.Count -1 do
    begin
      Query.Close;
      Query.SQL.Clear;
      Query.SQL.Add('insert into TB_NOTAFISCAL_ITEM( ');
      Query.SQL.Add('  NF_ID, ');
      Query.SQL.Add('  ITEM, ');
      Query.SQL.Add('  PRODUTO_ID, ');
      Query.SQL.Add('  QUANTIDADE, ');
      Query.SQL.Add('  VR_UNITARIO, ');
      Query.SQL.Add('  CODCFO, ');
      Query.SQL.Add('  ALIQ_IPI, ');
      Query.SQL.Add('  VR_IPI, ');
      Query.SQL.Add('  PERC_DESCONTO, ');
      Query.SQL.Add('  VR_DESCONTO, ');
      Query.SQL.Add('  ALIQ_ICMS, ');
      Query.SQL.Add('  VR_ICMS, ');
      Query.SQL.Add('  VR_TOTAL_ITEM) ');
      Query.SQL.Add('values( ');
      Query.SQL.Add(Format('%d, ', [FNF_ID]));
      Query.SQL.Add(Format('%d, ', [i + 1]));
      Query.SQL.Add(Format('%d, ', [FItensNF.Items[i].PRODUTO.PRODUTO_ID]));
      Query.SQL.Add(Format('%s, ', [FloatToSQL(FItensNF.Items[i].QUANTIDADE)]));
      Query.SQL.Add(Format('%s, ', [FloatToSQL(FItensNF.Items[i].VR_UNITARIO)]));
      Query.SQL.Add(Format('%s, ', [QuotedStr(FItensNF.Items[i].NAT_OPERACAO.CODCFO)]));
      Query.SQL.Add(Format('%s, ', [FloatToSQL(FItensNF.Items[i].ALIQ_IPI)]));
      Query.SQL.Add(Format('%s, ', [FloatToSQL(FItensNF.Items[i].VR_IPI)]));
      Query.SQL.Add(Format('%s, ', [FloatToSQL(FItensNF.Items[i].PERC_DESCONTO)]));
      Query.SQL.Add(Format('%s, ', [FloatToSQL(FItensNF.Items[i].VR_DESCONTO)]));
      Query.SQL.Add(Format('%s, ', [FloatToSQL(FItensNF.Items[i].ALIQ_ICMS)]));
      Query.SQL.Add(Format('%s, ', [FloatToSQL(FItensNF.Items[i].VR_ICMS)]));
      Query.SQL.Add(Format('%s) ', [FloatToSQL(FItensNF.Items[i].VR_TOTAL_ITEM)]));
      Query.ExecSQL;
    end;

    TConexao.GetInstance.Conexao.CommitFreeAndNil(tran);
    Result := True;
  except on E: Exception do
    begin
      TConexao.GetInstance.Conexao.RollbackFreeAndNil(tran);
      raise Exception.CreateFmt('Erro ao incluir a Nota Fiscal: %s', [E.Message]);
    end;
  end;
end;

procedure TNotaFiscal.SetDT_EMISSAO(const Value: TDate);
begin
  FDT_EMISSAO := Value;
end;

procedure TNotaFiscal.SetDT_ENTRADA(const Value: TDate);
begin
  FDT_ENTRADA := Value;
end;

procedure TNotaFiscal.SetFORNECEDOR(const Value: TFornecedor);
begin
  FFORNECEDOR := Value;
end;

procedure TNotaFiscal.SetItensNF(const Value: TItens);
begin
  FItensNF := Value;
end;

procedure TNotaFiscal.SetNF_ID(const Value: Integer);
begin
  FNF_ID := Value;
end;

procedure TNotaFiscal.SetNUMERO(const Value: Integer);
begin
  FNUMERO := Value;
end;

procedure TNotaFiscal.SetSERIE(const Value: String);
begin
  FSERIE := Value;
end;

procedure TNotaFiscal.SetVR_BASE_ICMS(const Value: Double);
begin
  FVR_BASE_ICMS := Value;
end;

procedure TNotaFiscal.SetVR_ICMS(const Value: Double);
begin
  FVR_ICMS := Value;
end;

procedure TNotaFiscal.SetVR_IPI(const Value: Double);
begin
  FVR_IPI := Value;
end;

procedure TNotaFiscal.SetVR_ITENS(const Value: Double);
begin
  FVR_ITENS := Value;
end;

procedure TNotaFiscal.SetVR_TOTAL(const Value: Double);
begin
  FVR_TOTAL := Value;
end;

{ TItens }

function TItens.Add: TNFItem;
begin
  Result := TNFItem(inherited Add);
end;

procedure TItens.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TItens.GetItem(index: Integer): TNFItem;
begin
  Result := TNFItem(inherited Items[Index]);
end;

procedure TItens.SetItem(index: Integer; const Value: TNFItem);
begin
  Items[Index].Assign(Value);
end;

{ TNFItem }

procedure TNFItem.SetALIQ_ICMS(const Value: Double);
begin
  FALIQ_ICMS := Value;
end;

procedure TNFItem.SetALIQ_IPI(const Value: Double);
begin
  FALIQ_IPI := Value;
end;

procedure TNFItem.SetITEM(const Value: Integer);
begin
  FITEM := Value;
end;

procedure TNFItem.SetNAT_OPERACAO(const Value: TNatOperacao);
begin
  FNAT_OPERACAO := Value;
end;

procedure TNFItem.SetNF_ID(const Value: Integer);
begin
  FNF_ID := Value;
end;

procedure TNFItem.SetPERC_DESCONTO(const Value: Double);
begin
  FPERC_DESCONTO := Value;
end;

procedure TNFItem.SetPRODUTO(const Value: TProduto);
begin
  FPRODUTO := Value;
end;

procedure TNFItem.SetQUANTIDADE(const Value: Double);
begin
  FQUANTIDADE := Value;
end;

procedure TNFItem.SetVR_DESCONTO(const Value: Double);
begin
  FVR_DESCONTO := Value;
end;

procedure TNFItem.SetVR_ICMS(const Value: Double);
begin
  FVR_ICMS := Value;
end;

procedure TNFItem.SetVR_IPI(const Value: Double);
begin
  FVR_IPI := Value;
end;

procedure TNFItem.SetVR_TOTAL_ITEM(const Value: Double);
begin
  FVR_TOTAL_ITEM := Value;
end;

procedure TNFItem.SetVR_UNITARIO(const Value: Double);
begin
  FVR_UNITARIO := Value;
end;

end.
