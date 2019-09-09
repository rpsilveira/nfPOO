program projNF;

uses
  Vcl.Forms,
  U_Principal in 'U_Principal.pas' {F_Principal},
  U_BaseControl in 'U_BaseControl.pas',
  U_Conexao in 'U_Conexao.pas',
  U_Produto in 'U_Produto.pas',
  U_Fornecedor in 'U_Fornecedor.pas',
  U_NatOperacao in 'U_NatOperacao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TF_Principal, F_Principal);
  Application.Run;
end.
