program TreinoVendas;

uses
  Vcl.Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untCadHeranca in 'Heranca\untCadHeranca.pas' {frmCadHeranca},
  untDM in 'untDM.pas' {DM: TDataModule},
  untCadCategoria in 'Cadastro\untCadCategoria.pas' {frmCadCategoria},
  untEnum in 'Heranca\untEnum.pas',
  classCadCategoria in 'Classes\classCadCategoria.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
