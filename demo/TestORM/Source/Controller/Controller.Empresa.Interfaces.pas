unit Controller.EMPRESA.Interfaces;

interface

uses

  Data.DB,
  System.JSON,
  System.Generics.Collections,
  VCL.Forms,
  Model.Entity.EMPRESA;

type
  iControllerEMPRESA = interface
    ['{8937F610-F66D-4298-BE67-788F242BE50F}']
    function DataSource (aDataSource : TDataSource) : iControllerEMPRESA; overload;
    function DataSource : TDataSource; overload;
    function Buscar : iControllerEMPRESA; overload;
    function Buscar(aID : integer) : iControllerEMPRESA; overload;
    function Buscar(aFiltro : TJsonobject; aOrdem : string) : iControllerEMPRESA; overload;
    function Buscar(aSQL : string) : iControllerEMPRESA; overload;
    function Insert : iControllerEMPRESA;
    function Delete : iControllerEMPRESA;
    function Update : iControllerEMPRESA;
    function Clear: iControllerEMPRESA;
    function Ultimo(where : string) : iControllerEMPRESA;
    function EMPRESA : TEMPRESA;
    function FromJsonObject(aJson : TJsonObject) : iControllerEMPRESA;
    function List : TObjectList<TEMPRESA>;
    function ExecSQL(sql : string) : iControllerEMPRESA;
    function BindForm(aForm : TForm) : iControllerEMPRESA;
  end;

implementation

end.
