inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro de Categoria'
  ClientWidth = 951
  ExplicitWidth = 963
  TextHeight = 15
  inherited pnlRodape: TPanel
    Width = 951
    ExplicitWidth = 945
    inherited btnFechar: TBitBtn
      Left = 853
      ExplicitLeft = 847
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited pcHerancaPrincipal: TPageControl
    Width = 951
    ExplicitWidth = 945
    inherited tbsListagem: TTabSheet
      ExplicitWidth = 943
      inherited pnlTopo: TPanel
        Width = 943
        ExplicitWidth = 937
      end
      inherited grdListagem: TDBGrid
        Width = 943
        Columns = <
          item
            Expanded = False
            FieldName = 'CATEGORIA_ID'
            Width = 112
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Width = 706
            Visible = True
          end>
      end
    end
    inherited tbsMovimentacao: TTabSheet
      ExplicitWidth = 943
    end
  end
  inherited qryListagem: TZQuery
    SQL.Strings = (
      'SELECT * FROM TBL_CATEGORIA')
    object qryListagemCATEGORIA_ID: TZIntegerField
      DisplayLabel = 'C'#243'd. Categoria'
      FieldName = 'CATEGORIA_ID'
      Required = True
    end
    object qryListagemDESCRICAO: TZUnicodeStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Size = 100
    end
  end
end
