unit Controller.EMPRESA;

interface

uses
  System.SysUtils,
  System.Json,
  System.Generics.Collections,
  REST.Json,
  Data.DB,
  SimpleRTTI,
  VCL.Forms,
  Model.Entity.EMPRESA,
  Model.EMPRESA.Interfaces,
  Controller.EMPRESA.Interfaces;

type
  TControllerEMPRESA = class(TInterfacedObject, iControllerEMPRESA)
  private
    FModel : iModelEMPRESA;
    FDataSource : TDataSource;
    FList : TObjectList<TEMPRESA>;
    FEntidade : TEMPRESA;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iControllerEMPRESA;
    function DataSource(aDataSource: TDataSource): iControllerEMPRESA; overload;
    function DataSource : TDataSource; overload;
    function Buscar: iControllerEMPRESA; overload;
    function Buscar(aID : integer) : iControllerEMPRESA; overload;
    function Buscar(aFiltro : TJsonobject; aOrdem : string) : iControllerEMPRESA; overload;
    function Buscar(aSQL : string) : iControllerEMPRESA; overload;
    function Insert: iControllerEMPRESA;
    function Delete: iControllerEMPRESA;
    function Update: iControllerEMPRESA;
    function Clear: iControllerEMPRESA;
    function Ultimo(where : string) : iControllerEMPRESA;
    function EMPRESA: TEMPRESA;
    function FromJsonObject(aJson : TJsonObject) : iControllerEMPRESA;
    function List : TObjectList<TEMPRESA>;
    function ExecSQL(sql : string) : iControllerEMPRESA;
    function BindForm(aForm : TForm) : iControllerEMPRESA;

  end;

implementation

{ TControllerEMPRESA }

function TControllerEMPRESA.Buscar: iControllerEMPRESA;
begin
  Result := Self;

  if not Assigned(FList) then
    FList := TObjectList<TEMPRESA>.Create;

  FModel.DAO.Find(FList);
end;

function TControllerEMPRESA.Buscar(aID: integer): iControllerEMPRESA;
var aux : string;
begin
  Result := Self;

  if Assigned(FEntidade) then
    Freeandnil(FEntidade);

  FEntidade := FModel.DAO.Find(aID);
end;

function TControllerEMPRESA.Buscar(aFiltro : TJsonobject; aOrdem : string) : iControllerEMPRESA;
var
  Item: TJSONPair;
  sql : string;
begin
  Result := Self;
  if not Assigned(FList) then
    FList := TObjectList<TEMPRESA>.Create;
  try
    for Item in afiltro do
    begin
      if item.JsonString.Value = 'SQL' then
      begin
        sql := (Item.JsonValue.Value);
      end
      else
      begin
        if sql <> '' then
          sql := sql + ' and ';

        if UpperCase(Item.JsonString.Value) = 'DESCRICAO' then   // verificar o campo de descrição
          sql := sql + UpperCase(Item.JsonString.Value) + ' containing ' + Quotedstr(Item.JsonValue.Value)
        else
          sql := sql + UpperCase(Item.JsonString.Value) + ' = ' + Quotedstr(Item.JsonValue.Value);
      end;
    end;
    FModel.DAO.SQL.Where(sql).OrderBy(aOrdem).&End.Find(FList);
  finally
    Item.Free;
  end;
end;

function TControllerEMPRESA.Buscar(aSQL : string) : iControllerEMPRESA;
begin
  Result := Self;
  try
    FModel.DAO.Find(aSQL);
  except
  end;
end;

function TControllerEMPRESA.BindForm(aForm: TForm): iControllerEMPRESA;
begin
  Result := Self;
  Clear;
  TSimpleRTTI<EMPRESA>.New(nil).BindFormToClass(aForm, FEntidade);
end;

function TControllerEMPRESA.EMPRESA: TEMPRESA;
begin
  Result := FEntidade;
end;

function TControllerEMPRESA.Clear: iControllerEMPRESA;
begin
  if Assigned(FEntidade) then
    Freeandnil(FEntidade);
  FEntidade := TEMPRESA.Create;
end;

constructor TControllerEMPRESA.Create;
begin
  FModel := TModel.New.EMPRESA;
  FList := TObjectList<TEMPRESA>.Create;
  FEntidade := TEMPRESA.Create;
end;

function TControllerEMPRESA.DataSource(
  aDataSource: TDataSource): iControllerEMPRESA;
begin
  Result := Self;
  FDataSource := aDataSource;
  FModel.DataSource(FDataSource);
end;

function TControllerEMPRESA.DataSource: TDataSource;
begin
  Result := FDataSource;
end;

function TControllerEMPRESA.Delete: iControllerEMPRESA;
begin
  Result := Self;
  try
    FModel.DAO.Delete(FEntidade);
  except
    raise Exception.Create('Erro ao excluir o registro');
  end;
end;

destructor TControllerEMPRESA.Destroy;
begin
  if Assigned(FList) then
    Freeandnil(FList);

  if Assigned(FEntidade) then
    Freeandnil(FEntidade);

  inherited;
end;

function TControllerEMPRESA.Insert: iControllerEMPRESA;
begin
  Result := Self;
  FModel.DAO.Insert(FEntidade);
end;

function TControllerEMPRESA.List : TObjectList<TEMPRESA>;
begin
  Result := FList;
end;

class function TControllerEMPRESA.New: iControllerEMPRESA;
begin
  Result := Self.Create;
end;

function TControllerEMPRESA.ExecSQL(sql : string): iControllerEMPRESA;
begin
  FModel.DAO.ExecSQL(sql);
  Result := Self;
end;

function TControllerEMPRESA.Update: iControllerEMPRESA;
begin
  Result := Self;
  FModel.DAO.Update(FEntidade);
end;

function TControllerEMPRESA.Ultimo(where : string) : iControllerEMPRESA;
begin
  Result := Self;
  if not Assigned(FEntidade) then
    Freeandnil(FEntidade);
  if where = ' then
    where := ' xxx_CODIGO = (select max(xxx_CODIGO) from EMPRESA)';
  FEntidade := FModel.DAO.Max(where);
end;

function TControllerEMPRESA.FromJsonObject(aJson : TJsonObject) : iControllerEMPRESA;
begin
  FEntidade := TJson.JsonToObject<TEMPRESA>(aJson);
end;

end.
