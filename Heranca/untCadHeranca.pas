unit untCadHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.Grids, Vcl.DBGrids,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, untDM, untEnum;

type
  TfrmCadHeranca = class(TForm)
    pnlRodape: TPanel;
    pcHerancaPrincipal: TPageControl;
    tbsListagem: TTabSheet;
    tbsMovimentacao: TTabSheet;
    pnlTopo: TPanel;
    grdListagem: TDBGrid;
    mskPesquisar: TMaskEdit;
    btnPesquisar: TBitBtn;
    btnFechar: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnApagar: TBitBtn;
    qryListagem: TZQuery;
    dsListagem: TDataSource;
    btnNavigator: TDBNavigator;
    lblPesquisaPor: TLabel;
    lblPesquisa: TLabel;
    edtCategoriaId: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure mskPesquisarChange(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
  private
    procedure ControlaBotoes (btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar: TBitBtn; btnNavigator: TDBNavigator;
                                             pcHerancaPrincipal: TPageControl; Flag: Boolean);
    procedure ControlaIndiceTab (pcHerancaPrincipal: TPageControl; Indice: Integer);
    function
     RetornaCampoTraduzido (Campo :string): string;
  public
    EstadoBotao: TEstadoDoCadastro;
    IndiceAtual: String;
    function Apagar:Boolean; virtual;
    function Gravar(EstadoBotao:TEstadoDoCadastro):Boolean; virtual;
    function ExisteCampoObrigatorio: Boolean;
    procedure LimpaEdits;
  end;

var
  frmCadHeranca: TfrmCadHeranca;

implementation

{$R *.dfm}

{$region 'Procedures e Functions desenvolvidas'}

  //Procedure que controla o Enabled dos botões
procedure TfrmCadHeranca.ControlaBotoes (btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar: TBitBtn; btnNavigator: TDBNavigator;
                                         pcHerancaPrincipal: TPageControl; Flag: Boolean);
begin
  btnNovo.Enabled := Flag;
  btnAlterar.Enabled := Flag;
  btnCancelar.Enabled := not(Flag);
  btnGravar.Enabled := not(Flag);
  btnNavigator.Enabled := Flag;
  pcHerancaPrincipal.Pages[0].TabVisible := Flag;
end;

  //Procedure que verifica se a primeira pagina esta visivel, se estiver é para mudar para a pagina no valor do indice (No caso dessa a primeira)
  //Este procedimento será usado somente em botôes como o btnGravar e btnCancelar (Podendo ser utilizado em outras telas conforme a necessidade
  //  mas no estagio em que estou nesse projeto esta sendo usado somente nisso)
procedure TfrmCadHeranca.ControlaIndiceTab (pcHerancaPrincipal: TPageControl; Indice: Integer);
begin
  if (pcHerancaPrincipal.Pages[0].TabVisible) then
      pcHerancaPrincipal.TabIndex := Indice;
end;

  function TfrmCadHeranca.RetornaCampoTraduzido (Campo :string): string;   //Função criada para retornar o DisplayLabel do titulo clicado no grid,
var i: Integer;                                                   //onde ele recebe um campo e retorna uma string(O DisplayLabel para ser inserido)
begin

   for I := 0 to qryListagem.Fields.Count-1 do  //Um Loop que passa por todos os campos do grid/banco de dados
    if qryListagem.Fields[i].FieldName = Campo then begin  //Se o field no index atual da contagem coincidir com o Campo
      Result := qryListagem.Fields[i].DisplayLabel;        //       recebido na função, ira retornar o DisplayLabel dele
      Break;
    end;


end;

{$region 'Funções com o metodo virtual'}

{
  Essas funções serão sobrescritas na tela de cadastro de categoria futuramente
}

function TfrmCadHeranca.Apagar: Boolean;
begin
  ShowMessage('Deletado');
  Result := True;
end;

function TfrmCadHeranca.Gravar(EstadoBotao: TEstadoDoCadastro): Boolean;
begin
  if (EstadoBotao = ecNovo) then
      ShowMessage('Inserido')
    else if (EstadoBotao = ecAlterar) then
      ShowMessage('Alterado')
    else
      ShowMessage('Nada Aconteceu');

      Result := True;
end;

{$endregion}

//Função para verificar se existe algum campo que é obrigatorio ser preenchido...
{
  Primeiro e passado o valor false, para que caso a condição não seja atendida nada aconteca, ou seja,
    se não houver campos obrigatorios a serem preenchidos somente sera retornado false e nada acontecera.

  Depois inicia-se um loop que percorre todos os componentes, ai é iniciado uma condição onde,
    se o componente que acabou de passar pelo loop for do tipo Edit, ele ira fazer outra verificação,
    para ver se é um campo obrigatorio ("Tag = 1") e se ele esta vazio... Se a condição for verdadeira (Existe um campo obrigatorio vazio),
    é mostrado uma mensagem dizendo que o campo em questão é um campo obrigatorio e logo em seguida da um break em toda a run, ou seja,
    "Pausa" o programa naquela parte até não houver mais um campo obrigatorio vazio (O resto do código não é executado)
}
function TfrmCadHeranca.ExisteCampoObrigatorio: Boolean;
var i:Integer;
begin
  Result := False;
  for I := 0 to ComponentCount-1 do
  begin
    if(Components[i] is TLabeledEdit) then begin
      if (TLabeledEdit(Components[i]).Tag = 1) and (TLabeledEdit(Components[i]).Text = EmptyStr)  then begin
        MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption + ' é um campo obrigatorio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
        TLabeledEdit(Components[i]).SetFocus;
        Result := True;
        Break;
      end;
    end;
  end;

end;

//Procedimento criado parar limpar dinamicamente todos os .Text de todos o tipos de edits na tela
procedure TfrmCadHeranca.LimpaEdits;
var i:Integer;
begin
  for I := 0 to ComponentCount-1 do begin          // Crio um loop onde percorre todos os componentes da tela
    if(Components[i] is TLabeledEdit) then         // Se algum dos componentes na tela for do tipo do edit especificado
      TLabeledEdit(Components[i]).Text := ''       //    vai limpar o que esta escrito nele
    else if (Components[i] is TEdit) then
      TEdit(Components[i]).Text := '';
  end;
end;

{$endregion}

procedure TfrmCadHeranca.btnNovoClick(Sender: TObject);
begin
  ControlaBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pcHerancaPrincipal, false);
  LimpaEdits;

  EstadoBotao := ecNovo;
end;

procedure TfrmCadHeranca.btnAlterarClick(Sender: TObject);
begin
  ControlaBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pcHerancaPrincipal, false);

  EstadoBotao := ecAlterar;
end;

procedure TfrmCadHeranca.btnCancelarClick(Sender: TObject);
begin
  ControlaBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pcHerancaPrincipal, true);

  ControlaIndiceTab(pcHerancaPrincipal, 0);
  LimpaEdits;

  EstadoBotao := ecNenhum;
end;

{
  Procedure que verifica se não existe nenhum campo obrigatorio sem preencher (Usando a função "ExisteCampoObrigatorio")
    depois verifica se houve ação de gravar retornou true ou false, caso ela tenha funciona (Retornou true), o botão faz
    todo o controle atribuido a ele
}
procedure TfrmCadHeranca.btnGravarClick(Sender: TObject);
begin
  if (ExisteCampoObrigatorio) then
  Abort;

  try
    if Gravar(EstadoBotao) then begin
      ControlaBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pcHerancaPrincipal, true);
      ControlaIndiceTab(pcHerancaPrincipal, 0);
      LimpaEdits;
      qryListagem.Refresh;
    end;
  finally
    EstadoBotao := ecNenhum;
  end;
end;

procedure TfrmCadHeranca.btnApagarClick(Sender: TObject);
begin
  if Apagar then begin
    ControlaBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pcHerancaPrincipal, true);
    ControlaIndiceTab(pcHerancaPrincipal, 0);
    LimpaEdits;
    EstadoBotao := ecNenhum;
    qryListagem.Refresh;
  end;
end;

procedure TfrmCadHeranca.btnFecharClick(Sender: TObject);
begin
 Close;
end;

procedure TfrmCadHeranca.FormCreate(Sender: TObject);
begin
  qryListagem.Connection  := DM.dbConexao;
  dsListagem.DataSet      := qryListagem;
  grdListagem.DataSource  := dsListagem;
  btnNavigator.DataSource := dsListagem;
end;

procedure TfrmCadHeranca.grdListagemDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TfrmCadHeranca.grdListagemTitleClick(Column: TColumn);
begin
  IndiceAtual                 := Column.FieldName;
  qryListagem.IndexFieldNames := IndiceAtual;
  lblPesquisa.Caption         := RetornaCampoTraduzido(IndiceAtual);
end;


procedure TfrmCadHeranca.mskPesquisarChange(Sender: TObject);
begin
  qryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text,[loPartialKey])
end;

procedure TfrmCadHeranca.FormShow(Sender: TObject);
begin
  if (qryListagem.SQL.Text<>EmptyStr) then begin
    qryListagem.Open;
  end;
  ControlaIndiceTab(pcHerancaPrincipal, 0);
  ControlaBotoes(btnNovo, btnAlterar, btnCancelar,btnGravar, btnApagar, btnNavigator, pcHerancaPrincipal, True);

end;

procedure TfrmCadHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryListagem.Close;
end;

end.
