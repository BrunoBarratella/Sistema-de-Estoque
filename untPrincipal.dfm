object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'frmPrincipal'
  ClientHeight = 681
  ClientWidth = 1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mnuPrincipal
  WindowState = wsMaximized
  OnCreate = FormCreate
  TextHeight = 15
  object mnuPrincipal: TMainMenu
    Left = 1040
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object Cadastro2: TMenuItem
        Caption = 'Cliente'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Categoria1: TMenuItem
        Caption = 'Categoria'
        OnClick = Categoria1Click
      end
      object Produto1: TMenuItem
        Caption = 'Produto'
      end
      object Produto2: TMenuItem
        Caption = '-'
      end
      object Fechar1: TMenuItem
        Caption = 'Fechar'
        OnClick = Fechar1Click
      end
    end
    object Movimentao1: TMenuItem
      Caption = 'Movimenta'#231#227'o'
      object Venda1: TMenuItem
        Caption = 'Venda'
      end
    end
    object Relatorios1: TMenuItem
      Caption = 'Relatorios'
      object Cliente1: TMenuItem
        Caption = 'Cliente'
      end
      object Produto3: TMenuItem
        Caption = '-'
      end
      object VendaporData1: TMenuItem
        Caption = 'Produto'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Vendapordata2: TMenuItem
        Caption = 'Venda por data'
      end
    end
  end
end
