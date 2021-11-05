unit Model.EMPRESA.Interfaces;

interface

uses
  Data.DB,
  SimpleInterface,
  Model.Entity.EMPRESA;

type
  iModelEMPRESA = interface
    ['{A0BCF476-8BE1-4450-B431-680872E8FC55}']
    function Entidade : TEMPRESA;
    function DAO : iSimpleDAO<TEMPRESA>;
    function DataSource(aDataSource : TDataSource) : iModelEMPRESA;
  end;

implementation

end.
