unit Main;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Classes,
  Winapi.Windows,
  Winapi.Messages,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.CheckLst,
  Vcl.Grids,
  Vcl.ValEdit,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.FB,
  FireDAC.DApt,
  Utils.IniFile, Vcl.ComCtrls;

type
  TFrmMain = class(TForm)
    Panel: TPanel;
    ValueListEditor: TValueListEditor;
    chkTables: TCheckListBox;
    BtnMap: TButton;
    BtnAll: TButton;
    BtnNone: TButton;
    BtnCreateController: TButton;
    BtnConnection: TButton;
    BtnCreateEntity: TButton;
    BtnDisconnect: TButton;
    LblPathProject: TLabel;
    EdtPathProject: TEdit;
    BtnCreateModel: TButton;
    PageControl: TPageControl;
    TbsEntity: TTabSheet;
    MemoEntity: TMemo;
    TbsModel: TTabSheet;
    TbsiModel: TTabSheet;
    TbsController: TTabSheet;
    TbsiController: TTabSheet;
    MemoModel: TMemo;
    MemoiModel: TMemo;
    MemoController: TMemo;
    MemoiController: TMemo;
    EdtPathEntity: TEdit;
    EdtPathModel: TEdit;
    EdtPathiModel: TEdit;
    EdtPathController: TEdit;
    EdtPathiController: TEdit;
    BtnCreateiModel: TButton;
    BtnCreateiController: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnConnectionClick(Sender: TObject);
    procedure BtnDisconnectClick(Sender: TObject);
    procedure BtnMapClick(Sender: TObject);
    procedure BtnAllClick(Sender: TObject);
    procedure BtnNoneClick(Sender: TObject);
    procedure BtnCreateEntityClick(Sender: TObject);
    procedure BtnCreateModelClick(Sender: TObject);
    procedure BtnCreateiModelClick(Sender: TObject);
    procedure BtnCreateControllerClick(Sender: TObject);
    procedure BtnCreateiControllerClick(Sender: TObject);
  private
    procedure ReadInifile;
    procedure WriteInifile;
    procedure Connected;
    procedure MapDatabase;
    procedure CheckListBoxSelect(Selected : Boolean);
    procedure CreateEntity;
    procedure CreateModel;
    procedure CreateiModel;
    procedure CreateController;
    procedure CreateiController;
    function ClearNull(sTexto: String): String;
    function FirstLarge(Value: String): String;
    function FormatName(Nome: string): string;
    var
      FDConnection: TFDConnection;
      FQuery: TFDQuery;
      DirectoryEntity, DirectoryModel, DirectoryController: string;
  public
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FDConnection := TFDConnection.create(nil);
  FQuery := TFDQuery.create(nil);
  FQuery.Connection := FDConnection;
  EdtPathProject.Text := 'C:\';
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  ReadInifile;
end;

procedure TFrmMain.BtnConnectionClick(Sender: TObject);
begin
  Connected;
  if FDConnection.Connected then
  begin
    WriteInifile;
    BtnConnection.Enabled := False;
    BtnDisconnect.Enabled := True;
    BtnMap.Enabled := True;
  end;
end;

procedure TFrmMain.BtnDisconnectClick(Sender: TObject);
begin
  Try
    FDConnection.Connected := False;
    BtnConnection.Enabled := True;
    BtnDisconnect.Enabled := False;
    BtnMap.Enabled := False;
    BtnAll.Enabled := False;
    BtnNone.Enabled := False;
    BtnCreateEntity.Enabled := False;
    BtnCreateModel.Enabled := False;
    BtnCreateiModel.Enabled := False;
    BtnCreateController.Enabled := False;
    BtnCreateiController.Enabled := False;
    chkTables.Clear;
    MemoEntity.Clear;
    MemoModel.Clear;
    MemoiModel.Clear;
    MemoController.Clear;
    MemoiController.Clear;
    EdtPathEntity.Text := '';
    EdtPathModel.Text := '';
    EdtPathiModel.Text := '';
    EdtPathController.Text := '';
    EdtPathiController.Text := '';
  except
    ShowMessage('Houve um erro ao desconectar do banco de dados!');
  End;
end;

procedure TFrmMain.BtnMapClick(Sender: TObject);
begin
  Try
    MapDatabase;
    BtnAll.Enabled := True;
    BtnNone.Enabled := True;
    BtnCreateEntity.Enabled := True;
    BtnCreateModel.Enabled := True;
    BtnCreateiModel.Enabled := True;
    BtnCreateController.Enabled := True;
    BtnCreateiController.Enabled := True;
  except
    ShowMessage('Houve um erro ao mapear do banco de dados!');
  End;
end;

procedure TFrmMain.BtnAllClick(Sender: TObject);
begin
  CheckListBoxSelect(True);
end;

procedure TFrmMain.BtnNoneClick(Sender: TObject);
begin
  CheckListBoxSelect(False);
end;

procedure TFrmMain.BtnCreateEntityClick(Sender: TObject);
begin
  DirectoryEntity := EdtPathProject.Text + '\Model\Entity';
  if not DirectoryExists(DirectoryEntity) then
    ForceDirectories(DirectoryEntity);
  CreateEntity;
end;

procedure TFrmMain.BtnCreateModelClick(Sender: TObject);
begin
  DirectoryModel := EdtPathProject.Text + '\Model';
  if not DirectoryExists(DirectoryModel) then
    ForceDirectories(DirectoryModel);
  CreateModel;
end;

procedure TFrmMain.BtnCreateiModelClick(Sender: TObject);
begin
  DirectoryModel := EdtPathProject.Text + '\Model';
  if not DirectoryExists(DirectoryModel) then
    ForceDirectories(DirectoryModel);
  CreateiModel;
end;

procedure TFrmMain.BtnCreateControllerClick(Sender: TObject);
begin
  DirectoryController := EdtPathProject.Text + '\Controller';
  if not DirectoryExists(DirectoryController) then
    ForceDirectories(DirectoryController);
  CreateController;
end;

procedure TFrmMain.BtnCreateiControllerClick(Sender: TObject);
begin
  DirectoryController := EdtPathProject.Text + '\Controller';
  if not DirectoryExists(DirectoryController) then
    ForceDirectories(DirectoryController);
  CreateiController;
end;

procedure TFrmMain.ReadIniFile();
begin
  ValueListEditor.Values['Hostname'] := IniFileConfig.DatabaseHostname;
  ValueListEditor.Values['Username'] := IniFileConfig.DatabaseUsername;
  ValueListEditor.Values['Password'] := IniFileConfig.DatabasePassword;
  ValueListEditor.Values['Port']     := IniFileConfig.DatabasePort;
  ValueListEditor.Values['Path']     := IniFileConfig.DatabasePath;
  EdtPathProject.Text                := IniFileConfig.PathProject;
end;

procedure TFrmMain.WriteIniFile;
begin
  IniFileConfig.DatabaseHostname := ValueListEditor.Values['Hostname'];
  IniFileConfig.DatabaseUsername := ValueListEditor.Values['Username'];
  IniFileConfig.DatabasePassword := ValueListEditor.Values['Password'];
  IniFileConfig.DatabasePort     := ValueListEditor.Values['Port'];
  IniFileConfig.DatabasePath     := ValueListEditor.Values['Path'];
  IniFileConfig.PathProject      := EdtPathProject.Text;
end;

procedure TFrmMain.Connected;
begin

  FDConnection.Params.Clear;
  FDConnection.Params.Add('Server=' + ValueListEditor.Values['Hostname']);
  FDConnection.Params.Add('User_Name=' + ValueListEditor.Values['Username']);
  FDConnection.Params.Add('Password=' + ValueListEditor.Values['Password']);
  FDConnection.Params.Add('Database=' + ValueListEditor.Values['Path']);
  FDConnection.Params.Add('Port=' + ValueListEditor.Values['Port']);
  FDConnection.Params.Add('DriverID=FB');

  try
    FDConnection.Connected := True;
    FDConnection.ResourceOptions.AutoReconnect := True;
  except
    ShowMessage('Houve um erro ao tentar conectar com banco de dados!');
  end;
end;

procedure TFrmMain.MapDatabase;
var
  i: Integer;
begin

  try
    FQuery := TFDQuery.create(nil);
    FQuery.Connection := FDConnection;
    FQuery.Close;
    FQuery.SQL.Clear;
    chkTables.Items.Clear();

    with FQuery do
    begin
      SQL.Text :=
        'select rdb$relation_name from rdb$relations where rdb$system_flag = 0 order by rdb$relation_name;';
      Open();
      First();
      while not Eof do
      begin
        chkTables.Items.Add(ClearNull(Fields[0].AsString));
        Next();
      end;
    end;

    for i := 0 to chkTables.Count - 1 do
    begin
      chkTables.Checked[i] := True;
    end;
  except
    ShowMessage('Houve um erro ao maperar banco de dados');
  end;
end;

procedure TFrmMain.CheckListBoxSelect(Selected: Boolean);
var
  i : Integer;
begin
  for i := 0 to chkTables.Count - 1 do
  begin
    chkTables.Checked[i] := Selected;
  end;
end;

procedure TFrmMain.CreateEntity;
var
  tabela, campo: string;
  i, j: Integer;
begin

  try
    for j := 0 to chkTables.Count - 1 do
    begin
      Application.ProcessMessages;
      if chkTables.Checked[j] then
      begin
        tabela := chkTables.Items[j].Trim;

        FQuery.Close;
        FQuery.SQL.Clear;
        FQuery.SQL.Add('select * from ' + tabela);
        FQuery.Open;

        PageControl.ActivePage := TbsEntity;
        MemoEntity.lines.Clear;
        MemoEntity.lines.Add('unit Model.Entity.' + FormatName(tabela) + ';');
        MemoEntity.lines.Add('');
        MemoEntity.lines.Add('interface');
        MemoEntity.lines.Add('');
        MemoEntity.lines.Add('uses');
        MemoEntity.lines.Add('  System.Classes,');
        MemoEntity.lines.Add('  System.Generics.Collections,');
        MemoEntity.lines.Add('  System.JSON,');
        MemoEntity.lines.Add('  Rest.Json,');
        MemoEntity.lines.Add('  SimpleAttributes;');
        MemoEntity.lines.Add('');
        MemoEntity.lines.Add('type');
        MemoEntity.lines.Add('  [Tabela(' + QuotedStr(FormatName(tabela)) + ')]');
        MemoEntity.lines.Add('  T' + FormatName(tabela) + ' = class');
        MemoEntity.lines.Add('  private');
        for i := 0 to FQuery.FieldCount - 1 do
        begin
          if FQuery.Fields[i].ClassName = 'TStringField' then campo := 'String;'
          else if FQuery.Fields[i].ClassName = 'TDateField' then campo := 'TDate;'
          else if FQuery.Fields[i].ClassName = 'TBooleanField' then campo := 'Boolean;'
          else if FQuery.Fields[i].ClassName = 'TIntegerField' then campo := 'Integer;'
          else
          campo := 'String;' + '   {' + FQuery.Fields[i].ClassName + '}';
          MemoEntity.lines.Add('    F' + FormatName(FQuery.Fields[i].FieldName) + ': ' + campo);
        end;

        MemoEntity.lines.Add('');
        MemoEntity.lines.Add('  public');
        MemoEntity.lines.Add('    constructor Create;');
        MemoEntity.lines.Add('    destructor Destroy; override;');
        MemoEntity.lines.Add('');
        MemoEntity.lines.Add('  published');
        for i := 0 to FQuery.FieldCount - 1 do
        begin
          if FQuery.Fields[i].ClassName = 'TStringField' then campo := 'String'
          else if FQuery.Fields[i].ClassName = 'TDateField' then campo := 'TDate'
          else if FQuery.Fields[i].ClassName = 'TBooleanField' then campo := 'Boolean'
          else if FQuery.Fields[i].ClassName = 'TIntegerField' then campo := 'Integer'
          else
          campo := 'String;' + '   {' + FQuery.Fields[i].ClassName + '}';

          if i = 0 then
            MemoEntity.lines.Add('    [Campo(' +
              QuotedStr(FormatName(FQuery.Fields[i].FieldName)) +
                '), PK, AutoInc]')
          else
            MemoEntity.lines.Add('    [Campo(' +
              QuotedStr(FormatName(FQuery.Fields[i]
              .FieldName)) + ')]');
          MemoEntity.lines.Add('    property ' + FormatName
            (FQuery.Fields[i].FieldName) + ': ' + campo + ' read F' +
            FormatName(FQuery.Fields[i].FieldName) +
            ' write F' + FormatName(FQuery.Fields[i]
            .FieldName) + ';');
        end;
        MemoEntity.lines.Add('');
        MemoEntity.lines.Add('    function ToJSONObject: TJsonObject;');
        MemoEntity.lines.Add('    function ToJsonString: string;');
        MemoEntity.lines.Add('');
        MemoEntity.lines.Add('  end;');
        MemoEntity.lines.Add('');
        MemoEntity.lines.Add('implementation');
        MemoEntity.lines.Add('');
        MemoEntity.lines.Add('constructor T' + FormatName(tabela) + '.Create;');
        MemoEntity.lines.Add('begin');
        MemoEntity.lines.Add('');
        MemoEntity.lines.Add('end;');
        MemoEntity.lines.Add('');
        MemoEntity.lines.Add('destructor T' + FormatName (tabela) + '.Destroy;');
        MemoEntity.lines.Add('begin');
        MemoEntity.lines.Add('');
        MemoEntity.lines.Add('  inherited;');
        MemoEntity.lines.Add('end;');
        MemoEntity.lines.Add('');
        MemoEntity.lines.Add('function T' + FormatName(tabela) + '.ToJSONObject: TJsonObject;');
        MemoEntity.lines.Add('begin');
        MemoEntity.lines.Add('  Result := TJson.ObjectToJsonObject(Self);');
        MemoEntity.lines.Add('end;');
        MemoEntity.lines.Add('');
        MemoEntity.lines.Add('function T' + FormatName(tabela) + '.ToJsonString: string;');
        MemoEntity.lines.Add('begin');
        MemoEntity.lines.Add('  result := TJson.ObjectToJsonString(self);');
        MemoEntity.lines.Add('end;');
        MemoEntity.lines.Add('');
        MemoEntity.lines.Add('end.');
        EdtPathEntity.Text := DirectoryEntity + '\Model.Entity.' + FormatName(tabela) + '.pas';
        MemoEntity.lines.SaveToFile(EdtPathEntity.Text);
      end;
    end;
    ShowMessage('Criado arquivo com sucesso!');
  except
    ShowMessage('Houve um erro ao criar arquivo!');
  end;
end;

procedure TFrmMain.CreateModel;
var
  tabela, campo: string;
  j: Integer;
begin

  try
    for j := 0 to chkTables.Count - 1 do
    begin
      Application.ProcessMessages;
      if chkTables.Checked[j] then
      begin
        tabela := chkTables.Items[j].Trim;
      end;
    end;

    PageControl.ActivePage := TbsModel;
    MemoModel.lines.Clear;
    MemoModel.lines.Add('unit Model.' + tabela + ';');
    MemoModel.lines.Add('');
    MemoModel.lines.Add('interface');
    MemoModel.lines.Add('');
    MemoModel.lines.Add('uses');
    MemoModel.lines.Add('  Data.DB,');
    MemoModel.lines.Add('  SimpleDAO,');
    MemoModel.lines.Add('  SimpleInterface,');
    MemoModel.lines.Add('  SimpleQueryRestDW,');
    MemoModel.lines.Add('  Model.Entity.' + tabela + ',');
    MemoModel.lines.Add('  Model.' + tabela + '.Interfaces;');
    MemoModel.lines.Add('');
    MemoModel.lines.Add('type');
    MemoModel.lines.Add('  TModel' + tabela + ' = class(TInterfacedObject, iModel' +
      tabela + ')');
    MemoModel.lines.Add('    private');
    MemoModel.lines.Add('      FEntidade : T' + tabela + ';');
    MemoModel.lines.Add('      FDAO : iSimpleDAO<T' + tabela + '>;');
    MemoModel.lines.Add('      FDataSource : TDataSource;');
    MemoModel.lines.Add('    public');
    MemoModel.lines.Add('      constructor Create;');
    MemoModel.lines.Add('      destructor Destroy; override;');
    MemoModel.lines.Add('      class function New : iModel' + tabela + ';');
    MemoModel.lines.Add('      function Entidade: T' + tabela + ';');
    MemoModel.lines.Add('      function DAO: iSimpleDAO<T' + tabela + '>;');
    MemoModel.lines.Add('      function DataSource(aDataSource: TDataSource): iModel'
      + tabela + ';');
    MemoModel.lines.Add('  end;');
    MemoModel.lines.Add('');
    MemoModel.lines.Add('implementation');
    MemoModel.lines.Add('');
    MemoModel.lines.Add('{ TModel' + tabela + ' }');
    MemoModel.lines.Add('');
    MemoModel.lines.Add('uses System.SysUtils;');
    MemoModel.lines.Add('');
    MemoModel.lines.Add('constructor TModel' + tabela + '.Create;');
    MemoModel.lines.Add('begin');
    MemoModel.lines.Add('  FEntidade := T' + tabela + '.Create;');
    MemoModel.lines.Add('  FDAO := TSimpleDAO<T' + tabela + '>.New;');
    MemoModel.lines.Add('end;');
    MemoModel.lines.Add('');
    MemoModel.lines.Add('function TModel' + tabela + '.DAO: iSimpleDAO<T' +
      tabela + '>;');
    MemoModel.lines.Add('begin');
    MemoModel.lines.Add('  Result := FDAO;');
    MemoModel.lines.Add('end;');
    MemoModel.lines.Add('');
    MemoModel.lines.Add('function TModel' + tabela +
      '.DataSource(aDataSource: TDataSource): iModel' + tabela + ';');
    MemoModel.lines.Add('begin');
    MemoModel.lines.Add('  Result := Self;');
    MemoModel.lines.Add('  FDataSource := aDataSource;');
    MemoModel.lines.Add('  FDAO.DataSource(FDatasource);');
    MemoModel.lines.Add('end;');
    MemoModel.lines.Add('');
    MemoModel.lines.Add('destructor TModel' + tabela + '.Destroy;');
    MemoModel.lines.Add('begin');
    MemoModel.lines.Add('  Freeandnil(FEntidade);');
    MemoModel.lines.Add('  inherited;');
    MemoModel.lines.Add('end;');
    MemoModel.lines.Add('');
    MemoModel.lines.Add('function TModel' + tabela + '.Entidade: T' + tabela + ';');
    MemoModel.lines.Add('begin');
    MemoModel.lines.Add('  Result := FEntidade;');
    MemoModel.lines.Add('end;');
    MemoModel.lines.Add('');
    MemoModel.lines.Add('class function TModel' + tabela + '.New : iModel' +
      tabela + ';');
    MemoModel.lines.Add('begin');
    MemoModel.lines.Add('  Result := Self.Create;');
    MemoModel.lines.Add('end;');
    MemoModel.lines.Add('');
    MemoModel.lines.Add('end.');
    EdtPathModel.Text := DirectoryModel + '\Model.' + FormatName(tabela) + '.pas';
    MemoModel.lines.SaveToFile(EdtPathModel.Text);
    ShowMessage('Criado arquivo com sucesso!');
  except
    ShowMessage('Houve um erro ao criar arquivo!');
  end;
end;

procedure TFrmMain.CreateiModel;
var
  tabela, campo: string;
  j: Integer;
begin
  try
    for j := 0 to chkTables.Count - 1 do
    begin
      Application.ProcessMessages;
      if chkTables.Checked[j] then
      begin
        tabela := chkTables.Items[j].Trim;
      end;
    end;

    PageControl.ActivePage := TbsiModel;
    MemoiModel.lines.Clear;
    MemoiModel.lines.Add('unit Model.' + tabela + '.Interfaces;');
    MemoiModel.lines.Add('');
    MemoiModel.lines.Add('interface');
    MemoiModel.lines.Add('');
    MemoiModel.lines.Add('uses');
    MemoiModel.lines.Add('  Data.DB,');
    MemoiModel.lines.Add('  SimpleInterface,');
    MemoiModel.lines.Add('  Model.Entity.' + tabela + ';');
    MemoiModel.lines.Add('');
    MemoiModel.lines.Add('type');
    MemoiModel.lines.Add('  iModel' + tabela + ' = interface');
    MemoiModel.lines.Add('    [gerar assinatura]');
    MemoiModel.lines.Add('    function Entidade : T' + tabela + ';');
    MemoiModel.lines.Add('    function DAO : iSimpleDAO<T' + tabela + '>;');
    MemoiModel.lines.Add('    function DataSource(aDataSource : TDataSource) : iModel'
      + tabela + ';');
    MemoiModel.lines.Add('  end;');
    MemoiModel.lines.Add('');
    MemoiModel.lines.Add('implementation');
    MemoiModel.lines.Add('');
    MemoiModel.lines.Add('end.');
    EdtPathiModel.Text := DirectoryModel + '\Model.' + FormatName(tabela) + '.Interfaces.pas';
    MemoiModel.lines.SaveToFile(EdtPathiModel.Text);
    ShowMessage('Criado arquivo com sucesso!');
  except
    ShowMessage('Houve um erro ao criar arquivo!');
  end;
end;

procedure TFrmMain.CreateController;
var
  tabela, campo: string;
  j: Integer;
begin

  try
    for j := 0 to chkTables.Count - 1 do
    begin
      Application.ProcessMessages;
      if chkTables.Checked[j] then
      begin
        tabela := chkTables.Items[j].Trim;
      end;
    end;

    PageControl.ActivePage := TbsController;
    MemoController.lines.Clear;
    MemoController.lines.Add('unit Controller.' + tabela + ';');
    MemoController.lines.Add('');
    MemoController.lines.Add('interface');
    MemoController.lines.Add('');
    MemoController.lines.Add('uses');
    MemoController.lines.Add('  System.SysUtils,');
    MemoController.lines.Add('  System.Json,');
    MemoController.lines.Add('  System.Generics.Collections,');
    MemoController.lines.Add('  REST.Json,');
    MemoController.lines.Add('  Data.DB,');
    MemoController.lines.Add('  SimpleRTTI,');
    MemoController.lines.Add('  VCL.Forms,');
    MemoController.lines.Add('  Model.Entity.' + tabela + ',');
    MemoController.lines.Add('  Model.' + tabela + '.Interfaces,');
    MemoController.lines.Add('  Controller.' + tabela + '.Interfaces;');
    MemoController.lines.Add('');
    MemoController.lines.Add('type');
    MemoController.lines.Add('  TController' + tabela +
      ' = class(TInterfacedObject, iController' + tabela + ')');
    MemoController.lines.Add('  private');
    MemoController.lines.Add('    FModel : iModel' + tabela + ';');
    MemoController.lines.Add('    FDataSource : TDataSource;');
    MemoController.lines.Add('    FList : TObjectList<T' + tabela + '>;');
    MemoController.lines.Add('    FEntidade : T' + tabela + ';');
    MemoController.lines.Add('  public');
    MemoController.lines.Add('    constructor Create;');
    MemoController.lines.Add('    destructor Destroy; override;');
    MemoController.lines.Add('    class function New: iController' + tabela + ';');
    MemoController.lines.Add
      ('    function DataSource(aDataSource: TDataSource): iController' + tabela +
      '; overload;');
    MemoController.lines.Add('    function DataSource : TDataSource; overload;');
    MemoController.lines.Add('    function Buscar: iController' + tabela + '; overload;');
    MemoController.lines.Add('    function Buscar(aID : integer) : iController' + tabela +
      '; overload;');
    MemoController.lines.Add
      ('    function Buscar(aFiltro : TJsonobject; aOrdem : string) : iController'
      + tabela + '; overload;');
    MemoController.lines.Add('    function Buscar(aSQL : string) : iController' + tabela +
      '; overload;');
    MemoController.lines.Add('    function Insert: iController' + tabela + ';');
    MemoController.lines.Add('    function Delete: iController' + tabela + ';');
    MemoController.lines.Add('    function Update: iController' + tabela + ';');
    MemoController.lines.Add('    function Clear: iController' + tabela + ';');
    MemoController.lines.Add('    function Ultimo(where : string) : iController' +
      tabela + ';');
    MemoController.lines.Add('    function ' + tabela + ': T' + tabela + ';');
    MemoController.lines.Add
      ('    function FromJsonObject(aJson : TJsonObject) : iController' +
      tabela + ';');
    MemoController.lines.Add('    function List : TObjectList<T' + tabela + '>;');
    MemoController.lines.Add('    function ExecSQL(sql : string) : iController' +
      tabela + ';');
    MemoController.lines.Add('    function BindForm(aForm : TForm) : iController' +
      tabela + ';');
    MemoController.lines.Add('');
    MemoController.lines.Add('  end;');
    MemoController.lines.Add('');
    MemoController.lines.Add('implementation');
    MemoController.lines.Add('');
    MemoController.lines.Add('{ TController' + tabela + ' }');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela + '.Buscar: iController' +
      tabela + ';');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  Result := Self;');
    MemoController.lines.Add('');
    MemoController.lines.Add('  if not Assigned(FList) then');
    MemoController.lines.Add('    FList := TObjectList<T' + tabela + '>.Create;');
    MemoController.lines.Add('');
    MemoController.lines.Add('  FModel.DAO.Find(FList);');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela +
      '.Buscar(aID: integer): iController' + tabela + ';');
    MemoController.lines.Add('var aux : string;');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  Result := Self;');
    MemoController.lines.Add('');
    MemoController.lines.Add('  if Assigned(FEntidade) then');
    MemoController.lines.Add('    Freeandnil(FEntidade);');
    MemoController.lines.Add('');
    MemoController.lines.Add('  FEntidade := FModel.DAO.Find(aID);');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela +
      '.Buscar(aFiltro : TJsonobject; aOrdem : string) : iController' +
      tabela + ';');
    MemoController.lines.Add('var');
    MemoController.lines.Add('  Item: TJSONPair;');
    MemoController.lines.Add('  sql : string;');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  Result := Self;');
    MemoController.lines.Add('  if not Assigned(FList) then');
    MemoController.lines.Add('    FList := TObjectList<T' + tabela + '>.Create;');
    MemoController.lines.Add('  try');
    MemoController.lines.Add('    for Item in afiltro do');
    MemoController.lines.Add('    begin');
    MemoController.lines.Add('      if item.JsonString.Value = ''SQL'' then');
    MemoController.lines.Add('      begin');
    MemoController.lines.Add('        sql := (Item.JsonValue.Value);');
    MemoController.lines.Add('      end');
    MemoController.lines.Add('      else');
    MemoController.lines.Add('      begin');
    MemoController.lines.Add('        if sql <> '' then');
    MemoController.lines.Add('          sql := sql + '' and '';');
    MemoController.lines.Add('');
    MemoController.lines.Add
      ('        if UpperCase(Item.JsonString.Value) = ''DESCRICAO'' then   // verificar o campo de descrição');
    MemoController.lines.Add
      ('          sql := sql + UpperCase(Item.JsonString.Value) + '' containing '' + Quotedstr(Item.JsonValue.Value)');
    MemoController.lines.Add('        else');
    MemoController.lines.Add
      ('          sql := sql + UpperCase(Item.JsonString.Value) + '' = '' + Quotedstr(Item.JsonValue.Value);');
    MemoController.lines.Add('      end;');
    MemoController.lines.Add('    end;');
    MemoController.lines.Add
      ('    FModel.DAO.SQL.Where(sql).OrderBy(aOrdem).&End.Find(FList);');
    MemoController.lines.Add('  finally');
    MemoController.lines.Add('    Item.Free;');
    MemoController.lines.Add('  end;');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela +
      '.Buscar(aSQL : string) : iController' + tabela + ';');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  Result := Self;');
    MemoController.lines.Add('  try');
    MemoController.lines.Add('    FModel.DAO.Find(aSQL, FList);');
    MemoController.lines.Add('  except');
    MemoController.lines.Add('  end;');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela +
      '.BindForm(aForm: TForm): iController' + tabela + ';');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  Result := Self;');
    MemoController.lines.Add('  Clear;');
    MemoController.lines.Add('  TSimpleRTTI<' + tabela +
      '>.New(nil).BindFormToClass(aForm, FEntidade);');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela + '.' + tabela + ': T' +
      tabela + ';');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  Result := FEntidade;');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela + '.Clear: iController' +
      tabela + ';');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  if Assigned(FEntidade) then');
    MemoController.lines.Add('    Freeandnil(FEntidade);');
    MemoController.lines.Add('  FEntidade := T' + tabela + '.Create;');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('constructor TController' + tabela + '.Create;');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  FModel := TModel.New.' + tabela + ';');
    MemoController.lines.Add('  FList := TObjectList<T' + tabela + '>.Create;');
    MemoController.lines.Add('  FEntidade := T' + tabela + '.Create;');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela + '.DataSource(');
    MemoController.lines.Add('  aDataSource: TDataSource): iController' + tabela + ';');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  Result := Self;');
    MemoController.lines.Add('  FDataSource := aDataSource;');
    MemoController.lines.Add('  FModel.DataSource(FDataSource);');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela +
      '.DataSource: TDataSource;');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  Result := FDataSource;');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela + '.Delete: iController' +
      tabela + ';');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  Result := Self;');
    MemoController.lines.Add('  try');
    MemoController.lines.Add('    FModel.DAO.Delete(FEntidade);');
    MemoController.lines.Add('  except');
    MemoController.lines.Add
      ('    raise Exception.Create(''Erro ao excluir o registro'');');
    MemoController.lines.Add('  end;');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('destructor TController' + tabela + '.Destroy;');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  if Assigned(FList) then');
    MemoController.lines.Add('    Freeandnil(FList);');
    MemoController.lines.Add('');
    MemoController.lines.Add('  if Assigned(FEntidade) then');
    MemoController.lines.Add('    Freeandnil(FEntidade);');
    MemoController.lines.Add('');
    MemoController.lines.Add('  inherited;');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela + '.Insert: iController' +
      tabela + ';');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  Result := Self;');
    MemoController.lines.Add('  FModel.DAO.Insert(FEntidade);');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela + '.List : TObjectList<T' +
      tabela + '>;');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  Result := FList;');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('class function TController' + tabela + '.New: iController' +
      tabela + ';');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  Result := Self.Create;');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela +
      '.ExecSQL(sql : string): iController' + tabela + ';');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  FModel.DAO.ExecSQL(sql);');
    MemoController.lines.Add('  Result := Self;');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela + '.Update: iController' +
      tabela + ';');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  Result := Self;');
    MemoController.lines.Add('  FModel.DAO.Update(FEntidade);');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela +
      '.Ultimo(where : string) : iController' + tabela + ';');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  Result := Self;');
    MemoController.lines.Add('  if not Assigned(FEntidade) then');
    MemoController.lines.Add('    Freeandnil(FEntidade);');
    MemoController.lines.Add('  if where = '' then');
    MemoController.lines.Add('    where := '' xxx_CODIGO = (select max(xxx_CODIGO) from '
      + tabela + ')'';');
    MemoController.lines.Add('  FEntidade := FModel.DAO.Max(where);');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');

    MemoController.lines.Add('function TController' + tabela +
      '.FromJsonObject(aJson : TJsonObject) : iController' + tabela + ';');
    MemoController.lines.Add('begin');
    MemoController.lines.Add('  FEntidade := TJson.JsonToObject<T' + tabela +
      '>(aJson);');
    MemoController.lines.Add('end;');
    MemoController.lines.Add('');
    MemoController.lines.Add('end.');
    EdtPathController.Text := DirectoryController + '\Controller.' + FormatName(tabela) + '.pas';
    MemoController.lines.SaveToFile(EdtPathController.Text);
    ShowMessage('Criado arquivo com sucesso!');
  except
    ShowMessage('Houve um erro ao criar arquivo!');
  end;
end;

procedure TFrmMain.CreateiController;
var
  tabela, campo: string;
  j: Integer;
begin

  try
    for j := 0 to chkTables.Count - 1 do
    begin
      Application.ProcessMessages;
      if chkTables.Checked[j] then
      begin
        tabela := chkTables.Items[j].Trim;
      end;
    end;

    PageControl.ActivePage := TbsiController;
    MemoiController.lines.Clear;
    MemoiController.lines.Add('unit Controller.' + tabela + '.Interfaces;');
    MemoiController.lines.Add('');
    MemoiController.lines.Add('interface');
    MemoiController.lines.Add('');
    MemoiController.lines.Add('uses');
    MemoiController.lines.Add('');
    MemoiController.lines.Add('  Data.DB,');
    MemoiController.lines.Add('  System.JSON,');
    MemoiController.lines.Add('  System.Generics.Collections,');
    MemoiController.lines.Add('  VCL.Forms,');
    MemoiController.lines.Add('  Model.Entity.' + tabela + ';');
    MemoiController.lines.Add('');
    MemoiController.lines.Add('type');
    MemoiController.lines.Add('  iController' + tabela + ' = interface');
    MemoiController.lines.Add('    [GERAR ASSINATURA]');
    MemoiController.lines.Add
      ('    function DataSource (aDataSource : TDataSource) : iController' +
      tabela + '; overload;');
    MemoiController.lines.Add('    function DataSource : TDataSource; overload;');
    MemoiController.lines.Add('    function Buscar : iController' + tabela +
      '; overload;');
    MemoiController.lines.Add('    function Buscar(aID : integer) : iController' + tabela +
      '; overload;');
    MemoiController.lines.Add
      ('    function Buscar(aFiltro : TJsonobject; aOrdem : string) : iController'
      + tabela + '; overload;');
    MemoiController.lines.Add('    function Buscar(aSQL : string) : iController' + tabela +
      '; overload;');
    MemoiController.lines.Add('    function Insert : iController' + tabela + ';');
    MemoiController.lines.Add('    function Delete : iController' + tabela + ';');
    MemoiController.lines.Add('    function Update : iController' + tabela + ';');
    MemoiController.lines.Add('    function Clear: iController' + tabela + ';');
    MemoiController.lines.Add('    function Ultimo(where : string) : iController' +
      tabela + ';');
    MemoiController.lines.Add('    function ' + tabela + ' : T' + tabela + ';');
    MemoiController.lines.Add
      ('    function FromJsonObject(aJson : TJsonObject) : iController' +
      tabela + ';');
    MemoiController.lines.Add('    function List : TObjectList<T' + tabela + '>;');
    MemoiController.lines.Add('    function ExecSQL(sql : string) : iController' +
      tabela + ';');
    MemoiController.lines.Add('    function BindForm(aForm : TForm) : iController' +
      tabela + ';');
    MemoiController.lines.Add('  end;');
    MemoiController.lines.Add('');
    MemoiController.lines.Add('implementation');
    MemoiController.lines.Add('');
    MemoiController.lines.Add('end.');
    EdtPathiController.Text := DirectoryController + '\Controller.' + FormatName(tabela) +'.Interfaces.pas';
    MemoiController.lines.SaveToFile(EdtPathiController.Text);
    ShowMessage('Criado arquivo com sucesso!');
  except
    ShowMessage('Houve um erro ao criar arquivo!');
  end;
end;

function TFrmMain.ClearNull(sTexto: String): String;
var
  nPos: Integer;
begin
  nPos := 1;
  while Pos(' ', sTexto) > 0 do
  begin
    nPos := Pos(' ', sTexto);
    Delete(sTexto, nPos, 1);
  end;
  Result := sTexto;
end;

function TFrmMain.FirstLarge(Value: String): String;
var
  P: Integer;
  Word: String;
begin
  Result := '';
  Value := Trim(LowerCase(Value));
  repeat
    P := Pos(' ', Value);
    if P <= 0 then
    begin
      P := length(Value) + 1;
    end;
    Word := UpperCase(Copy(Value, 1, P - 1));
    if (length(Word) <= 2) or (Word = 'DAS') or (Word = 'DOS') then
    begin
      Result := Result + Copy(Value, 1, P - 1)
    end
    else
    begin
      Result := Result + UpperCase(Value[1]) + Copy(Value, 2, P - 2);
    end;
    Delete(Value, 1, P);
    if Value <> '' then
    begin
      Result := Result + ' ';
    end;
  until Value = '';
end;

function TFrmMain.FormatName(Nome: string): string;
begin
  Result := UpperCase(Copy(nome,1,1))+LowerCase(Copy(nome,2,Length(nome)));
end;

end.
