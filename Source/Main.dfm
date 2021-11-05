object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Mason'
  ClientHeight = 398
  ClientWidth = 771
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 390
    Height = 398
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      390
      398)
    object LblPathProject: TLabel
      Left = 15
      Top = 345
      Width = 59
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Path Project'
    end
    object ValueListEditor: TValueListEditor
      Left = 15
      Top = 10
      Width = 250
      Height = 127
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Strings.Strings = (
        'Hostname=Localhost'
        'Username=SYSDBA'
        'Password=masterkey'
        'Port=3060'
        'Path=')
      TabOrder = 0
      TitleCaptions.Strings = (
        'Parameters'
        'Values')
      ColWidths = (
        69
        175)
    end
    object chkTables: TCheckListBox
      Left = 15
      Top = 144
      Width = 250
      Height = 198
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Anchors = [akLeft, akTop, akBottom]
      BevelOuter = bvNone
      ItemHeight = 13
      TabOrder = 1
    end
    object BtnMap: TButton
      Left = 280
      Top = 72
      Width = 100
      Height = 25
      Caption = 'Map'
      Enabled = False
      TabOrder = 2
      OnClick = BtnMapClick
    end
    object BtnAll: TButton
      Left = 280
      Top = 144
      Width = 100
      Height = 25
      Caption = 'All'
      Enabled = False
      TabOrder = 3
      OnClick = BtnAllClick
    end
    object BtnNone: TButton
      Left = 280
      Top = 175
      Width = 100
      Height = 25
      Caption = 'Nome'
      Enabled = False
      TabOrder = 4
      OnClick = BtnNoneClick
    end
    object BtnCreateController: TButton
      Left = 280
      Top = 331
      Width = 100
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Create Controller'
      Enabled = False
      TabOrder = 5
      OnClick = BtnCreateControllerClick
    end
    object BtnConnection: TButton
      Left = 280
      Top = 10
      Width = 100
      Height = 25
      Caption = 'Connection'
      TabOrder = 6
      OnClick = BtnConnectionClick
    end
    object BtnCreateEntity: TButton
      Left = 280
      Top = 238
      Width = 100
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Create Entity'
      Enabled = False
      TabOrder = 7
      OnClick = BtnCreateEntityClick
    end
    object BtnDisconnect: TButton
      Left = 280
      Top = 41
      Width = 100
      Height = 25
      Caption = 'Disconnect'
      Enabled = False
      TabOrder = 8
      OnClick = BtnDisconnectClick
    end
    object EdtPathProject: TEdit
      Left = 15
      Top = 364
      Width = 250
      Height = 21
      Anchors = [akLeft, akBottom]
      TabOrder = 9
    end
    object BtnCreateModel: TButton
      Left = 280
      Top = 269
      Width = 100
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Create Model'
      Enabled = False
      TabOrder = 10
      OnClick = BtnCreateModelClick
    end
    object BtnCreateiModel: TButton
      Left = 280
      Top = 300
      Width = 100
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Create iModel'
      Enabled = False
      TabOrder = 11
      OnClick = BtnCreateiModelClick
    end
    object BtnCreateiController: TButton
      Left = 280
      Top = 362
      Width = 100
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Create iController'
      Enabled = False
      TabOrder = 12
      OnClick = BtnCreateiControllerClick
    end
  end
  object PageControl: TPageControl
    AlignWithMargins = True
    Left = 393
    Top = 3
    Width = 375
    Height = 392
    ActivePage = TbsEntity
    Align = alClient
    TabOrder = 1
    object TbsEntity: TTabSheet
      Caption = 'Entity'
      object MemoEntity: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 24
        Width = 361
        Height = 337
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object EdtPathEntity: TEdit
        Left = 0
        Top = 0
        Width = 367
        Height = 21
        Align = alTop
        TabOrder = 1
      end
    end
    object TbsModel: TTabSheet
      Caption = 'Model'
      ImageIndex = 1
      object MemoModel: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 24
        Width = 361
        Height = 337
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object EdtPathModel: TEdit
        Left = 0
        Top = 0
        Width = 367
        Height = 21
        Align = alTop
        TabOrder = 1
      end
    end
    object TbsiModel: TTabSheet
      Caption = 'Model.interfaces'
      ImageIndex = 2
      object MemoiModel: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 24
        Width = 361
        Height = 337
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object EdtPathiModel: TEdit
        Left = 0
        Top = 0
        Width = 367
        Height = 21
        Align = alTop
        TabOrder = 1
      end
    end
    object TbsController: TTabSheet
      Caption = 'Controller'
      ImageIndex = 3
      object MemoController: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 24
        Width = 361
        Height = 337
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object EdtPathController: TEdit
        Left = 0
        Top = 0
        Width = 367
        Height = 21
        Align = alTop
        TabOrder = 1
      end
    end
    object TbsiController: TTabSheet
      Caption = 'Controller.Interfaces'
      ImageIndex = 4
      object MemoiController: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 24
        Width = 361
        Height = 337
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object EdtPathiController: TEdit
        Left = 0
        Top = 0
        Width = 367
        Height = 21
        Align = alTop
        TabOrder = 1
      end
    end
  end
end
