unit classCadCategoria;

interface

uses  System.Classes,
      System.SysUtils,
      Vcl.Controls,
      Vcl.ExtCtrls,
      Vcl.Dialogs,
      ZAbstractConnection,
      ZConnection,
      ZAbstractRODataset,
      ZAbstractDataset,
      ZDataset;

type
  TClassCadCategoria = class
  private
    ConexaoDB: TZConnection;
    fieldCategoriaID: Integer;
    fieldDescricao: String;
    function getCodigo: Integer;
    function getDescricao: String;
    procedure setCodigo(const Value: Integer);
    procedure setDescricao(const Value: String);

  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Gravar: Boolean;
    function Alterar: Boolean;
    function Apagar: Boolean;
    function Selecionar(Id:integer):Boolean;

  published
     property codigo:Integer read getCodigo write setCodigo;
     property descricao:String read getDescricao write setDescricao;
  end;


implementation


{ TClassCadCategoria }

{$region 'Constructor e Destructor'}
constructor TClassCadCategoria.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TClassCadCategoria.Destroy;
begin
  //ShowMessage('Fui Destruído!');
  inherited;
end;
{$endregion}

{$region 'CRUD'}
function TClassCadCategoria.Gravar: Boolean;
var qryInserir: TZQuery;
begin
  try
    qryInserir := TZQuery.Create(nil);
    qryInserir.Connection := ConexaoDB;
    qryInserir.SQL.Clear;
    qryInserir.SQL.Add('INSERT INTO TBL_CATEGORIA (DESCRICAO) VALUES (:FDescricao)');
    qryInserir.ParamByName('FDescricao').AsString := Self.fieldDescricao;

    try
      qryInserir.ExecSQL;
    Except
      Result := False;
    end;

  finally
    if Assigned(qryInserir) then
      FreeAndNil(qryInserir);

  end;
end;

function TClassCadCategoria.Alterar: Boolean;
var qryAlterar: TZQuery;
begin
  try
    Result := True;
    qryAlterar := TZQuery.Create(nil);
    qryAlterar.Connection := ConexaoDB;
    qryAlterar.SQL.Clear;
    qryAlterar.SQL.Add('UPDATE TBL_CATEGORIA SET DESCRICAO = :descricao WHERE CATEGORIA_ID = :categoria_id');


    qryALterar.ParamByName('descricao').AsString := Self.fieldDescricao;
    qryAlterar.ParamByName('categoria_id').AsInteger := Self.fieldCategoriaID;

    try
      qryAlterar.ExecSQL;
    except
      Result := False;
    end;
  finally
    if Assigned(qryAlterar)	then
      FreeAndNil(qryAlterar);

  end;
end;

function TClassCadCategoria.Apagar: Boolean;
var qryApagar: TZQuery;
begin
  if  MessageDlg('Apagar o registro' +#13+#13+'De código: '+IntToStr(fieldCategoriaID)+#13+
                 'de decrição: '+fieldDescricao, TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrNo then
  begin
    Result := False;
    Abort;
  end;

  try
    Result := True;
    qryApagar:= TZQuery.Create(nil);
    qryApagar.Connection := ConexaoDB;
    qryApagar.SQl.Clear;
    qryApagar.SQL.Add('DELETE FROM TBL_CATEGORIA WHERE CATEGORIA_ID = :categoriaID');

    qryApagar.ParamByName('categoriaID').AsInteger := fieldCategoriaID;
    try
      qryApagar.ExecSQL;
    except
      Result := False;
    end;
  finally
    if Assigned(qryApagar) then
      FreeAndNil(qryApagar);
  end;
end;

function TClassCadCategoria.Selecionar(Id: integer): Boolean;
var qrySelecionar: TZQuery;
begin
  try
    Result := True;
    qrySelecionar := TZQuery.Create(nil);
    qrySelecionar.Connection := ConexaoDB;
    qrySelecionar.SQL.Clear;
    qrySelecionar.SQL.Add('SELECT * FROM TBL_CATEGORIA WHERE CATEGORIA_ID = :categoriaID');
    qrySelecionar.ParamByName('categoriaID').AsInteger := Id;

    try
      qrySelecionar.Open;

      Self.fieldCategoriaID := qrySelecionar.FieldByName('CATEGORIA_ID').AsInteger;
      Self.fieldDescricao := qrySelecionar.FieldByName('DESCRICAO').AsString;
    Except
      Result := False;
    end;

  finally
    if Assigned(qrySelecionar) then
      FreeAndNil(qrySelecionar);


  end;

end;
{$endregion}

{$region 'Getters'}
function TClassCadCategoria.getCodigo: Integer;
begin
  Result :=  Self.fieldCategoriaID;
end;

function TClassCadCategoria.getDescricao: String;
begin
  Result := Self.fieldDescricao;
end;
{$endregion}

{$region 'Setters'}
procedure TClassCadCategoria.setCodigo(const Value: Integer);
begin
  Self.fieldCategoriaID := Value;
end;

procedure TClassCadCategoria.setDescricao(const Value: String);
begin
  Self.fieldDescricao := Value;
end;
{$endregion}
end.
