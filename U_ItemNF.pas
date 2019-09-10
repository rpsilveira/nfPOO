{***********************************************************}
{ Exemplo de lançamento de nota fiscal orientado a objetos, }
{ com banco de dados Oracle                                 }
{ Reinaldo Silveira - reinaldopsilveira@gmail.com           }
{ Franca/SP - set/2019                                      }
{***********************************************************}

unit U_ItemNF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_Produto, U_NatOperacao, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls;

type
  TF_ItemNF = class(TForm)
    Label1: TLabel;
    btnPesqProd: TSpeedButton;
    Label2: TLabel;
    edtCodProd: TEdit;
    edtDescrProd: TEdit;
    edtCodNat: TMaskEdit;
    edtDescrNat: TEdit;
    Label3: TLabel;
    edtQuantidade: TEdit;
    edtValorUnit: TEdit;
    Label4: TLabel;
    edtAliqIPI: TEdit;
    Label5: TLabel;
    edtValorIPI: TEdit;
    Label6: TLabel;
    edtPercDesc: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    edtValorDesc: TEdit;
    edtAliqICMS: TEdit;
    Label9: TLabel;
    edtValorICMS: TEdit;
    Label10: TLabel;
    edtValorTotal: TEdit;
    Label11: TLabel;
    pnlBotoes: TPanel;
    btnConfirma: TBitBtn;
    btnCancela: TBitBtn;
    procedure edtCodProdChange(Sender: TObject);
    procedure edtCodProdExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtDescrProdExit(Sender: TObject);
    procedure btnPesqProdClick(Sender: TObject);
    procedure edtCodNatChange(Sender: TObject);
    procedure edtCodNatExit(Sender: TObject);
    procedure KeyPressNumeric(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormatNumeric(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    prod: TProduto;
    nat: TNatOperacao;
  end;

var
  F_ItemNF: TF_ItemNF;

implementation

{$R *.dfm}

procedure TF_ItemNF.btnPesqProdClick(Sender: TObject);
begin
  if prod.Pesquisa then
  begin
    edtCodProd.Text   := IntToStr(prod.PRODUTO_ID);
    edtDescrProd.Text := prod.DESCRICAO;
  end;
end;

procedure TF_ItemNF.edtCodNatChange(Sender: TObject);
begin
  if TEdit(Sender).Text = ' .   ' then
  begin
    edtCodNat.Text   := '';
    edtDescrNat.Text := '';
  end;
end;

procedure TF_ItemNF.edtCodNatExit(Sender: TObject);
begin
  if edtCodNat.Text <> ' .   ' then
  begin
    if nat.BuscaDados(edtCodNat.Text, U_NatOperacao.tbCodigo) then
    begin
      edtCodNat.Text   := nat.CODCFO;
      edtDescrNat.Text := nat.DESCRICAO;
    end
    else
    begin
      Application.MessageBox('Código não encontrado!', 'Informação', MB_ICONINFORMATION);
      edtCodProd.SetFocus;
      Abort;
    end;
  end;
end;

procedure TF_ItemNF.edtCodProdChange(Sender: TObject);
begin
  if TEdit(Sender).Text = '' then
  begin
    edtCodProd.Text   := '';
    edtDescrProd.Text := '';
  end;
end;

procedure TF_ItemNF.edtCodProdExit(Sender: TObject);
begin
  if edtCodProd.Text <> '' then
  begin
    if prod.BuscaDados(edtCodProd.Text, U_Produto.tbID) then
    begin
      edtCodProd.Text   := IntToStr(prod.PRODUTO_ID);
      edtDescrProd.Text := prod.DESCRICAO;
    end
    else
    begin
      Application.MessageBox('Código não encontrado!', 'Informação', MB_ICONINFORMATION);
      edtCodProd.SetFocus;
      Abort;
    end;
  end;
end;

procedure TF_ItemNF.edtDescrProdExit(Sender: TObject);
begin
  if edtDescrProd.Text <> '' then
  begin
    if not prod.BuscaDados(edtDescrProd.Text, U_Produto.tbDescricao) then
      if not prod.Pesquisa(edtDescrProd.Text) then
        Abort;

    edtCodProd.Text   := IntToStr(prod.PRODUTO_ID);
    edtDescrProd.Text := prod.DESCRICAO;
  end;
end;

procedure TF_ItemNF.FormatNumeric(Sender: TObject);
begin
  TEdit(Sender).Text := FormatFloat('#0.00', StrToFloatDef(TEdit(Sender).Text,0));
end;

procedure TF_ItemNF.FormCreate(Sender: TObject);
begin
  prod := TProduto.Create(Self.Owner);
  nat  := TNatOperacao.Create(Self.Owner);
end;

procedure TF_ItemNF.FormShow(Sender: TObject);
begin
  if prod.PRODUTO_ID > 0 then
  begin
    edtCodProd.Text := IntToStr(prod.PRODUTO_ID);
    edtCodProdExit(Sender);
  end;

  if nat.CODCFO <> '' then
  begin
    edtCodNat.Text := nat.CODCFO;
    edtCodNatExit(Sender);
  end;
end;

procedure TF_ItemNF.KeyPressNumeric(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, FormatSettings.DecimalSeparator]) then
    Key := #0;
end;

end.
