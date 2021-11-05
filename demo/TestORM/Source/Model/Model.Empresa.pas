unit Model.EMPRESA;

interface

uses
  Data.DB,
  SimpleDAO,
  SimpleInterface,
  Model.Entity.EMPRESA,
  Model.EMPRESA.Interfaces,
  SimpleQueryFiredac,
  Model.Connection;

type
  TModelEMPRESA = class(TInterfacedObject, iModelEMPRESA)
    private
      FEntidade : TEmpresa;
      FDAO : iSimpleDAO<TEmpresa>;
      FDataSource : TDataSource;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelEMPRESA;
      function Entidade: TEmpresa;
      function DAO: iSimpleDAO<TEmpresa>;
      function DataSource(aDataSource: TDataSource): iModelEMPRESA;
  end;

implementation

{ TModelEMPRESA }

uses System.SysUtils;

constructor TModelEMPRESA.Create;
begin
  FEntidade := TEMPRESA.Create;
//  FDAO := TSimpleDAO<TEMPRESA>
//    .New(TSimpleQueryFiredac<TEMPRESA>
//      .New(DmConexao.FDConnection));
end;

function TModelEMPRESA.DAO: iSimpleDAO<TEMPRESA>;
begin
  Result := FDAO;
end;

function TModelEMPRESA.DataSource(aDataSource: TDataSource): iModelEMPRESA;
begin
  Result := Self;
  FDataSource := aDataSource;
  FDAO.DataSource(FDatasource);
end;

destructor TModelEMPRESA.Destroy;
begin
  Freeandnil(FEntidade);
  inherited;
end;

function TModelEMPRESA.Entidade: TEMPRESA;
begin
  Result := FEntidade;
end;

class function TModelEMPRESA.New : iModelEMPRESA;
begin
  Result := Self.Create;
end;

end.
