object F_ItemNF: TF_ItemNF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Item da Nota Fiscal'
  ClientHeight = 322
  ClientWidth = 586
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 19
    Width = 38
    Height = 13
    Caption = 'Produto'
  end
  object btnPesqProd: TSpeedButton
    Left = 530
    Top = 34
    Width = 23
    Height = 22
    Hint = 'Pesquisar'
    Caption = '...'
    ParentShowHint = False
    ShowHint = True
    OnClick = btnPesqProdClick
  end
  object Label2: TLabel
    Left = 24
    Top = 71
    Width = 109
    Height = 13
    Caption = 'Natureza da Opera'#231#227'o'
  end
  object Label3: TLabel
    Left = 24
    Top = 123
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object Label4: TLabel
    Left = 160
    Top = 123
    Width = 63
    Height = 13
    Caption = 'Valor unit'#225'rio'
  end
  object Label5: TLabel
    Left = 296
    Top = 123
    Width = 56
    Height = 13
    Caption = 'Al'#237'quota IPI'
  end
  object Label6: TLabel
    Left = 432
    Top = 123
    Width = 41
    Height = 13
    Caption = 'Valor IPI'
  end
  object Label7: TLabel
    Left = 24
    Top = 175
    Width = 59
    Height = 13
    Caption = '% Desconto'
  end
  object Label8: TLabel
    Left = 160
    Top = 175
    Width = 72
    Height = 13
    Caption = 'Valor Desconto'
  end
  object Label9: TLabel
    Left = 296
    Top = 175
    Width = 67
    Height = 13
    Caption = 'Al'#237'quota ICMS'
  end
  object Label10: TLabel
    Left = 432
    Top = 175
    Width = 52
    Height = 13
    Caption = 'Valor ICMS'
  end
  object Label11: TLabel
    Left = 24
    Top = 227
    Width = 72
    Height = 13
    Caption = 'Valor total item'
  end
  object edtCodProd: TEdit
    Left = 24
    Top = 35
    Width = 73
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 10
    NumbersOnly = True
    TabOrder = 0
    OnChange = edtCodProdChange
    OnExit = edtCodProdExit
  end
  object edtDescrProd: TEdit
    Left = 101
    Top = 35
    Width = 423
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 60
    TabOrder = 1
    OnChange = edtCodProdChange
    OnExit = edtDescrProdExit
  end
  object edtCodNat: TMaskEdit
    Left = 24
    Top = 87
    Width = 72
    Height = 21
    EditMask = '9\.999;1;_'
    MaxLength = 5
    TabOrder = 2
    Text = ' .   '
    OnChange = edtCodNatChange
    OnExit = edtCodNatExit
  end
  object edtDescrNat: TEdit
    Left = 101
    Top = 87
    Width = 452
    Height = 21
    TabStop = False
    CharCase = ecUpperCase
    MaxLength = 60
    ReadOnly = True
    TabOrder = 3
  end
  object edtQuantidade: TEdit
    Left = 24
    Top = 139
    Width = 121
    Height = 21
    Alignment = taRightJustify
    TabOrder = 4
    OnExit = FormatNumeric
    OnKeyPress = KeyPressNumeric
  end
  object edtValorUnit: TEdit
    Left = 160
    Top = 139
    Width = 121
    Height = 21
    Alignment = taRightJustify
    TabOrder = 5
    OnExit = FormatNumeric
    OnKeyPress = KeyPressNumeric
  end
  object edtAliqIPI: TEdit
    Left = 296
    Top = 139
    Width = 121
    Height = 21
    Alignment = taRightJustify
    TabOrder = 6
    OnExit = FormatNumeric
    OnKeyPress = KeyPressNumeric
  end
  object edtValorIPI: TEdit
    Left = 432
    Top = 139
    Width = 121
    Height = 21
    Alignment = taRightJustify
    TabOrder = 7
    OnExit = FormatNumeric
    OnKeyPress = KeyPressNumeric
  end
  object edtPercDesc: TEdit
    Left = 24
    Top = 191
    Width = 121
    Height = 21
    Alignment = taRightJustify
    TabOrder = 8
    OnExit = FormatNumeric
    OnKeyPress = KeyPressNumeric
  end
  object edtValorDesc: TEdit
    Left = 160
    Top = 191
    Width = 121
    Height = 21
    Alignment = taRightJustify
    TabOrder = 9
    OnExit = FormatNumeric
    OnKeyPress = KeyPressNumeric
  end
  object edtAliqICMS: TEdit
    Left = 296
    Top = 191
    Width = 121
    Height = 21
    Alignment = taRightJustify
    TabOrder = 10
    OnExit = FormatNumeric
    OnKeyPress = KeyPressNumeric
  end
  object edtValorICMS: TEdit
    Left = 432
    Top = 191
    Width = 121
    Height = 21
    Alignment = taRightJustify
    TabOrder = 11
    OnExit = FormatNumeric
    OnKeyPress = KeyPressNumeric
  end
  object edtValorTotal: TEdit
    Left = 24
    Top = 243
    Width = 121
    Height = 21
    Alignment = taRightJustify
    TabOrder = 12
    OnExit = FormatNumeric
    OnKeyPress = KeyPressNumeric
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 281
    Width = 586
    Height = 41
    Align = alBottom
    TabOrder = 13
    ExplicitLeft = 280
    ExplicitTop = 232
    ExplicitWidth = 185
    DesignSize = (
      586
      41)
    object btnConfirma: TBitBtn
      Left = 411
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Confirmar'
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 563
    end
    object btnCancela: TBitBtn
      Left = 492
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 644
    end
  end
end
