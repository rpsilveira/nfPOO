{***********************************************************}
{ Exemplo de lançamento de nota fiscal orientado a objetos, }
{ com banco de dados Oracle                                 }
{ Reinaldo Silveira - reinaldopsilveira@gmail.com           }
{ Franca/SP - set/2019                                      }
{***********************************************************}

unit U_Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls,
  U_NotaFiscal, U_Fornecedor;

type
  TF_Principal = class(TForm)
    pnlPrincipal: TPanel;
    Label1: TLabel;
    edtCodForn: TEdit;
    edtNomeForn: TEdit;
    btnPesqForn: TSpeedButton;
    Label2: TLabel;
    edtNumeroNF: TEdit;
    Label3: TLabel;
    edtSerie: TEdit;
    edtDataEmissao: TMaskEdit;
    Label4: TLabel;
    edtDataEntrada: TMaskEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtValorItens: TEdit;
    Label7: TLabel;
    edtValorIPI: TEdit;
    edtBaseICMS: TEdit;
    Label8: TLabel;
    edtValorICMS: TEdit;
    Label9: TLabel;
    edtTotalNF: TEdit;
    Label10: TLabel;
    pnlBotoes: TPanel;
    btnEfetivar: TBitBtn;
    pnlItens: TPanel;
    lstItens: TListView;
    btnAddItem: TBitBtn;
    btnRemItem: TBitBtn;
    btnEditItem: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure edtCodFornChange(Sender: TObject);
    procedure edtCodFornExit(Sender: TObject);
    procedure edtNomeFornExit(Sender: TObject);
    procedure btnPesqFornClick(Sender: TObject);
    procedure btnEfetivarClick(Sender: TObject);
    procedure validaData(Sender: TObject);
    procedure btnRemItemClick(Sender: TObject);
    procedure btnAddItemClick(Sender: TObject);
    procedure btnEditItemClick(Sender: TObject);
    procedure KeyPressNumeric(Sender: TObject; var Key: Char);
    procedure FormatNumeric(Sender: TObject);
  private
    { Private declarations }
    nf: TNotaFiscal;
    forn: TFornecedor;
    procedure PreencheListView;
    procedure LimpaCampos;
  public
    { Public declarations }
  end;

var
  F_Principal: TF_Principal;

implementation

{$R *.dfm}

uses U_ItemNF;

procedure TF_Principal.btnEfetivarClick(Sender: TObject);
begin
  if Application.MessageBox('Confirma a efetivação da Nota Fiscal?', 'Confirmação', MB_ICONQUESTION+MB_YESNO+MB_DEFBUTTON2) = mrNo then
    Exit;

  nf.FORNECEDOR   := forn;
  nf.NUMERO       := StrToIntDef(edtNumeroNF.Text,0);
  nf.SERIE        := edtSerie.Text;
  nf.DT_EMISSAO   := StrToDate(edtDataEmissao.Text);
  nf.DT_ENTRADA   := StrToDate(edtDataEntrada.Text);
  nf.VR_ITENS     := StrToFloatDef(edtValorItens.Text,0);
  nf.VR_IPI       := StrToFloatDef(edtValorIPI.Text,0);
  nf.VR_BASE_ICMS := StrToFloatDef(edtBaseICMS.Text,0);
  nf.VR_ICMS      := StrToFloatDef(edtValorICMS.Text,0);
  nf.VR_TOTAL     := StrToFloatDef(edtTotalNF.Text,0);

  if nf.Incluir then
  begin
    Application.MessageBox('Nota Fiscal efetivada com sucesso!', 'Informação', MB_ICONINFORMATION);
    LimpaCampos;
    edtNumeroNF.SetFocus;
  end;
end;

procedure TF_Principal.btnPesqFornClick(Sender: TObject);
begin
  if forn.Pesquisa then
  begin
    edtCodForn.Text  := IntToStr(forn.FORNECEDOR_ID);
    edtNomeForn.Text := forn.RAZAOSOCIAL;
  end;
end;

procedure TF_Principal.btnAddItemClick(Sender: TObject);
begin
  if not Assigned(F_ItemNF) then
    F_ItemNF := TF_ItemNF.Create(Self);
  try
    F_ItemNF.ShowModal;
    if F_ItemNF.ModalResult = mrOk then
    begin
      with nf.ItensNF.Add do
      begin
        PRODUTO       := F_ItemNF.prod;
        NAT_OPERACAO  := F_ItemNF.nat;
        QUANTIDADE    := StrToFloatDef(F_ItemNF.edtQuantidade.Text,0);
        VR_UNITARIO   := StrToFloatDef(F_ItemNF.edtValorUnit.Text,0);
        ALIQ_IPI      := StrToFloatDef(F_ItemNF.edtAliqIPI.Text,0);
        VR_IPI        := StrToFloatDef(F_ItemNF.edtValorIPI.Text,0);
        PERC_DESCONTO := StrToFloatDef(F_ItemNF.edtPercDesc.Text,0);
        VR_DESCONTO   := StrToFloatDef(F_ItemNF.edtValorDesc.Text,0);
        ALIQ_ICMS     := StrToFloatDef(F_ItemNF.edtAliqICMS.Text,0);
        VR_ICMS       := StrToFloatDef(F_ItemNF.edtValorICMS.Text,0);
        VR_TOTAL_ITEM := StrToFloatDef(F_ItemNF.edtValorTotal.Text,0);
      end;

      PreencheListView;
    end;
  finally
    FreeAndNil(F_ItemNF);
  end;
end;

procedure TF_Principal.btnEditItemClick(Sender: TObject);
begin
  if not Assigned(lstItens.Selected) then
  begin
    Application.MessageBox('Nenhum item selecionado, verifique!', 'Informação', MB_ICONINFORMATION);
    lstItens.SetFocus;
    Abort;
  end;

  if not Assigned(F_ItemNF) then
    F_ItemNF := TF_ItemNF.Create(Self);
  try
    with nf.ItensNF.Items[lstItens.Selected.Index] do
    begin
      F_ItemNF.prod               := PRODUTO;
      F_ItemNF.nat                := NAT_OPERACAO;
      F_ItemNF.edtQuantidade.Text := FormatFloat('#0.00', QUANTIDADE);
      F_ItemNF.edtValorUnit.Text  := FormatFloat('#0.00', VR_UNITARIO);
      F_ItemNF.edtAliqIPI.Text    := FormatFloat('#0.00', ALIQ_IPI);
      F_ItemNF.edtValorIPI.Text   := FormatFloat('#0.00', VR_IPI);
      F_ItemNF.edtPercDesc.Text   := FormatFloat('#0.00', PERC_DESCONTO);
      F_ItemNF.edtValorDesc.Text  := FormatFloat('#0.00', VR_DESCONTO);
      F_ItemNF.edtAliqICMS.Text   := FormatFloat('#0.00', ALIQ_ICMS);
      F_ItemNF.edtValorICMS.Text  := FormatFloat('#0.00', VR_ICMS);
      F_ItemNF.edtValorTotal.Text := FormatFloat('#0.00', VR_TOTAL_ITEM);
    end;

    F_ItemNF.ShowModal;
    if F_ItemNF.ModalResult = mrOk then
    begin
      with nf.ItensNF.Items[lstItens.Selected.Index] do
      begin
        PRODUTO       := F_ItemNF.prod;
        NAT_OPERACAO  := F_ItemNF.nat;
        QUANTIDADE    := StrToFloatDef(F_ItemNF.edtQuantidade.Text,0);
        VR_UNITARIO   := StrToFloatDef(F_ItemNF.edtValorUnit.Text,0);
        ALIQ_IPI      := StrToFloatDef(F_ItemNF.edtAliqIPI.Text,0);
        VR_IPI        := StrToFloatDef(F_ItemNF.edtValorIPI.Text,0);
        PERC_DESCONTO := StrToFloatDef(F_ItemNF.edtPercDesc.Text,0);
        VR_DESCONTO   := StrToFloatDef(F_ItemNF.edtValorDesc.Text,0);
        ALIQ_ICMS     := StrToFloatDef(F_ItemNF.edtAliqICMS.Text,0);
        VR_ICMS       := StrToFloatDef(F_ItemNF.edtValorICMS.Text,0);
        VR_TOTAL_ITEM := StrToFloatDef(F_ItemNF.edtValorTotal.Text,0);
      end;

      PreencheListView;
    end;
  finally
    FreeAndNil(F_ItemNF);
  end;
end;

procedure TF_Principal.btnRemItemClick(Sender: TObject);
begin
  if not Assigned(lstItens.Selected) then
  begin
    Application.MessageBox('Nenhum item selecionado, verifique!', 'Informação', MB_ICONINFORMATION);
    lstItens.SetFocus;
    Abort;
  end;

  nf.ItensNF.Delete(lstItens.Selected.Index);
  PreencheListView;
end;

procedure TF_Principal.edtCodFornChange(Sender: TObject);
begin
  if TEdit(Sender).Text = '' then
  begin
    edtCodForn.Text  := '';
    edtNomeForn.Text := '';
  end;
end;

procedure TF_Principal.edtCodFornExit(Sender: TObject);
begin
  if edtCodForn.Text <> '' then
  begin
    if forn.BuscaDados(edtCodForn.Text, U_Fornecedor.tbID) then
    begin
      edtCodForn.Text  := IntToStr(forn.FORNECEDOR_ID);
      edtNomeForn.Text := forn.RAZAOSOCIAL;
    end
    else
    begin
      Application.MessageBox('Código não encontrado!', 'Informação', MB_ICONINFORMATION);
      edtCodForn.SetFocus;
      Abort;
    end;
  end;
end;

procedure TF_Principal.edtNomeFornExit(Sender: TObject);
begin
  if edtNomeForn.Text <> '' then
  begin
    if not forn.BuscaDados(edtNomeForn.Text, U_Fornecedor.tbRazao) then
      if not forn.Pesquisa(edtNomeForn.Text) then
        Abort;

    edtCodForn.Text  := IntToStr(forn.FORNECEDOR_ID);
    edtNomeForn.Text := forn.RAZAOSOCIAL;
  end;
end;

procedure TF_Principal.FormatNumeric(Sender: TObject);
begin
  TEdit(Sender).Text := FormatFloat('#0.00', StrToFloatDef(TEdit(Sender).Text,0));
end;

procedure TF_Principal.FormCreate(Sender: TObject);
begin
  nf   := TNotaFiscal.Create(Self);
  forn := TFornecedor.Create(Self);
end;

procedure TF_Principal.KeyPressNumeric(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, FormatSettings.DecimalSeparator]) then
    Key := #0;
end;

procedure TF_Principal.LimpaCampos;
var
  i: Integer;
begin
  for i := 0 to pnlPrincipal.ControlCount -1 do
    if pnlPrincipal.Controls[i] is TCustomEdit then
      TCustomEdit(pnlPrincipal.Controls[i]).Clear;

  lstItens.Clear;
end;

procedure TF_Principal.PreencheListView;
var
  i: Integer;
begin
  lstItens.Clear;
  for i := 0 to nf.ItensNF.Count -1 do
  begin
    with lstItens.Items.Add do
    begin
      Caption := IntToStr(i +1);

      SubItems.Add(nf.ItensNF.Items[i].PRODUTO.DESCRICAO);
      SubItems.Add(FormatFloat(',#0.00', nf.ItensNF.Items[i].QUANTIDADE));
      SubItems.Add(FormatFloat(',#0.00', nf.ItensNF.Items[i].VR_UNITARIO));
      SubItems.Add(FormatFloat(',#0.00', nf.ItensNF.Items[i].VR_TOTAL_ITEM));
    end;
  end;
end;

procedure TF_Principal.validaData(Sender: TObject);
var
  dt: TDateTime;
begin
  if TMaskEdit(Sender).Text <> '  /  /    ' then
  begin
    if not TryStrToDate(TMaskEdit(Sender).Text, dt) then
    begin
      Application.MessageBox('Data inválida, verifique!', 'Aviso', MB_ICONWARNING);
      TMaskEdit(Sender).SetFocus;
      Abort;
    end;
  end;
end;

end.
