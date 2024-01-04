unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, untDM, untCadCategoria;

type
  TfrmPrincipal = class(TForm)
    mnuPrincipal: TMainMenu;
    Cadastro1: TMenuItem;
    Cadastro2: TMenuItem;
    N1: TMenuItem;
    Categoria1: TMenuItem;
    Produto1: TMenuItem;
    Produto2: TMenuItem;
    Fechar1: TMenuItem;
    Movimentao1: TMenuItem;
    Venda1: TMenuItem;
    Relatorios1: TMenuItem;
    Cliente1: TMenuItem;
    Produto3: TMenuItem;
    VendaporData1: TMenuItem;
    N2: TMenuItem;
    Vendapordata2: TMenuItem;
    procedure Fechar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Categoria1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

{
  Procedimentos, para mostrar minha tela de cadastro de categoria
}
procedure TfrmPrincipal.Categoria1Click(Sender: TObject);
begin
  frmCadCategoria := TfrmCadCategoria.Create(Self);
  frmCadCategoria.ShowModal;
  frmCadCategoria.Release;
end;

procedure TfrmPrincipal.Fechar1Click(Sender: TObject);
begin
  Close;
end;

{
  Passo os valores a serem recebido no meu componente de conexão com a DB
    para garantir que ao criar meu formulario sejam todos passados de forma correta
}
procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  DM := TDM.Create(self);
  with DM.dbConexao do begin
    SQLHourGlass := True;
    Protocol     := 'firebird';
    Port         := 3050;
    HostName     := 'Localhost';
    User         := 'SYSDBA';
    Password     := 'kim12345';
    Database     := 'VENDAS';
    Connected := True;
  end;
end;

end.
