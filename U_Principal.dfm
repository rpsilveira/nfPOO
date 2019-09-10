object F_Principal: TF_Principal
  Left = 0
  Top = 0
  Caption = 
    'Lan'#231'amento de Nota Fiscal de Compra, orientado a objetos [Reinal' +
    'do Silveira]'
  ClientHeight = 572
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 169
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 115
      Width = 55
      Height = 13
      Caption = 'Fornecedor'
    end
    object btnPesqForn: TSpeedButton
      Left = 405
      Top = 130
      Width = 23
      Height = 22
      Hint = 'Pesquisar'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnPesqFornClick
    end
    object Label2: TLabel
      Left = 16
      Top = 10
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
    end
    object Label3: TLabel
      Left = 151
      Top = 10
      Width = 24
      Height = 13
      Caption = 'S'#233'rie'
    end
    object Label4: TLabel
      Left = 224
      Top = 10
      Width = 64
      Height = 13
      Caption = 'Data emiss'#227'o'
    end
    object Label5: TLabel
      Left = 360
      Top = 10
      Width = 64
      Height = 13
      Caption = 'Data entrada'
    end
    object Label6: TLabel
      Left = 16
      Top = 64
      Width = 50
      Height = 13
      Caption = 'Valor itens'
    end
    object Label7: TLabel
      Left = 151
      Top = 64
      Width = 41
      Height = 13
      Caption = 'Valor IPI'
    end
    object Label8: TLabel
      Left = 288
      Top = 64
      Width = 86
      Height = 13
      Caption = 'Base c'#225'lculo ICMS'
    end
    object Label9: TLabel
      Left = 424
      Top = 64
      Width = 52
      Height = 13
      Caption = 'Valor ICMS'
    end
    object Label10: TLabel
      Left = 560
      Top = 64
      Width = 49
      Height = 13
      Caption = 'Valor total'
    end
    object edtCodForn: TEdit
      Left = 16
      Top = 131
      Width = 73
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      NumbersOnly = True
      TabOrder = 9
      OnChange = edtCodFornChange
      OnExit = edtCodFornExit
    end
    object edtNomeForn: TEdit
      Left = 95
      Top = 131
      Width = 306
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 60
      TabOrder = 10
      OnChange = edtCodFornChange
      OnExit = edtNomeFornExit
    end
    object edtNumeroNF: TEdit
      Left = 16
      Top = 26
      Width = 121
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      NumbersOnly = True
      TabOrder = 0
    end
    object edtSerie: TEdit
      Left = 151
      Top = 26
      Width = 58
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 1
    end
    object edtDataEmissao: TMaskEdit
      Left = 224
      Top = 26
      Width = 120
      Height = 21
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      OnExit = validaData
    end
    object edtDataEntrada: TMaskEdit
      Left = 360
      Top = 26
      Width = 120
      Height = 21
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      OnExit = validaData
    end
    object edtValorItens: TEdit
      Left = 16
      Top = 80
      Width = 121
      Height = 21
      Alignment = taRightJustify
      TabOrder = 4
      OnExit = FormatNumeric
      OnKeyPress = KeyPressNumeric
    end
    object edtValorIPI: TEdit
      Left = 151
      Top = 80
      Width = 121
      Height = 21
      Alignment = taRightJustify
      TabOrder = 5
      OnExit = FormatNumeric
      OnKeyPress = KeyPressNumeric
    end
    object edtBaseICMS: TEdit
      Left = 288
      Top = 80
      Width = 121
      Height = 21
      Alignment = taRightJustify
      TabOrder = 6
      OnExit = FormatNumeric
      OnKeyPress = KeyPressNumeric
    end
    object edtValorICMS: TEdit
      Left = 424
      Top = 80
      Width = 121
      Height = 21
      Alignment = taRightJustify
      TabOrder = 7
      OnExit = FormatNumeric
      OnKeyPress = KeyPressNumeric
    end
    object edtTotalNF: TEdit
      Left = 560
      Top = 80
      Width = 121
      Height = 21
      TabOrder = 8
      OnExit = FormatNumeric
      OnKeyPress = KeyPressNumeric
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 531
    Width = 792
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      792
      41)
    object btnEfetivar: TBitBtn
      Left = 688
      Top = 8
      Width = 89
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Efetivar'
      TabOrder = 0
      OnClick = btnEfetivarClick
    end
  end
  object pnlItens: TPanel
    Left = 0
    Top = 169
    Width = 792
    Height = 41
    Align = alTop
    Caption = 'Produtos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitLeft = 312
    ExplicitTop = 280
    ExplicitWidth = 185
    object btnAddItem: TBitBtn
      Left = 14
      Top = 9
      Width = 75
      Height = 25
      Hint = 'incluir Produto'
      Caption = 'incluir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnAddItemClick
    end
    object btnRemItem: TBitBtn
      Left = 176
      Top = 9
      Width = 75
      Height = 25
      Hint = 'remover Produto'
      Caption = 'remover'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnRemItemClick
    end
    object btnEditItem: TBitBtn
      Left = 95
      Top = 10
      Width = 75
      Height = 25
      Hint = 'alterar Produto'
      Caption = 'alterar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnEditItemClick
    end
  end
  object lstItens: TListView
    Left = 0
    Top = 210
    Width = 792
    Height = 321
    Hint = 'Duplo clique para visualizar/alterar o item'
    Align = alClient
    Columns = <
      item
        Caption = 'Item'
      end
      item
        Caption = 'Produto'
        Width = 300
      end
      item
        Alignment = taRightJustify
        Caption = 'Quantidade'
        Width = 90
      end
      item
        Alignment = taRightJustify
        Caption = 'Valor unit.'
        Width = 90
      end
      item
        Alignment = taRightJustify
        Caption = 'Valor total'
        Width = 90
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    ViewStyle = vsReport
    OnDblClick = btnEditItemClick
    ExplicitLeft = -152
    ExplicitTop = 175
  end
end
