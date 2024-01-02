unit untDM;

interface

uses
  System.SysUtils, System.Classes, ZAbstractConnection, ZConnection;

type
  TDM = class(TDataModule)
    dbConexao: TZConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
