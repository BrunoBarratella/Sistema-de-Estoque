unit untCadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untCadHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls, classCadCategoria, untDM, untEnum;

type
  TfrmCadCategoria = class(TfrmCadHeranca)
    qryListagemCATEGORIA_ID: TZIntegerField;
    qryListagemDESCRICAO: TZUnicodeStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    objClassCadCategoria: TClassCadCategoria;
    function Apagar:Boolean; override;
    function Gravar(EstadoBotao:TEstadoDoCadastro):Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCategoria: TfrmCadCategoria;

implementation

{$R *.dfm}

{$region 'Overrides'}
function TfrmCadCategoria.Apagar: Boolean;
begin
  if objClassCadCategoria.Selecionar(qryListagem.FieldByName('CATEGORIA_ID').AsInteger) then begin
    Result := objClassCadCategoria.Apagar;
  end;
end;

function TfrmCadCategoria.Gravar(EstadoBotao: TEstadoDoCadastro): Boolean;
begin
  if edtCategoriaId.Text <> EmptyStr  then
    objClassCadCategoria.codigo := StrToInt(edtCategoriaId.Text)
  else
    objClassCadCategoria.codigo	:= 0;

  objClassCadCategoria.descricao := edtDescricao.Text;	


  if (EstadoBotao = ecNovo) then
    Result := objClassCadCategoria.Gravar
  else if (EstadoBotao = ecAlterar) then
    Result := objClassCadCategoria.Alterar;


end;
{$endregion}

procedure TfrmCadCategoria.btnAlterarClick(Sender: TObject);
begin
  if objClassCadCategoria.Selecionar(qryListagem.FieldByName('CATEGORIA_ID').AsInteger) then begin
    edtCategoriaId.Text	:= IntToStr(objClassCadCategoria.codigo);
    edtDescricao.Text	:= objClassCadCategoria.descricao;
  end
  else begin
    btnCancelar.Click;
    abort;
  end;


  inherited;

end;

procedure TfrmCadCategoria.btnGravarClick(Sender: TObject);
begin
  //ShowMessage(objClassCadCategoria.descricao);
  inherited;
end;

procedure TfrmCadCategoria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(objClassCadCategoria) then
    FreeAndNil(objClassCadCategoria);

end;

procedure TfrmCadCategoria.FormCreate(Sender: TObject);
begin
  inherited;
  objClassCadCategoria:= TClassCadCategoria.Create(DM.dbConexao);
end;

end.
