unit Model.Entity.Empresa;

interface

uses
  System.Classes,
  System.Generics.Collections,
  System.JSON,
  Rest.Json,
  SimpleAttributes;

type
  [Tabela('Empresa')]
  TEmpresa = class
  private
    FId: Integer;
    FData_criacao: TDate;
    FSituacao: Boolean;
    FRemovido: Boolean;
    FRazao_social: String;
    FNome_fantasia: String;
    FCnpj: String;
    FIe: String;
    FIm: String;
    FCep: String;
    FCodigo_ibge: String;
    FCodigo_municipal: String;
    FPais: String;
    FEstado: String;
    FUf: String;
    FCidade: String;
    FBairro: String;
    FEndereco: String;
    FEndereco_numero: String;
    FComplemento: String;
    FTelefone: String;
    FCelular: String;
    FEmail: String;

  public
    constructor Create;
    destructor Destroy; override;

  published
    [Campo('Id'), PK, AutoInc]
    property Id: Integer read FId write FId;
    [Campo('Data_criacao')]
    property Data_criacao: TDate read FData_criacao write FData_criacao;
    [Campo('Situacao')]
    property Situacao: Boolean read FSituacao write FSituacao;
    [Campo('Removido')]
    property Removido: Boolean read FRemovido write FRemovido;
    [Campo('Razao_social')]
    property Razao_social: String read FRazao_social write FRazao_social;
    [Campo('Nome_fantasia')]
    property Nome_fantasia: String read FNome_fantasia write FNome_fantasia;
    [Campo('Cnpj')]
    property Cnpj: String read FCnpj write FCnpj;
    [Campo('Ie')]
    property Ie: String read FIe write FIe;
    [Campo('Im')]
    property Im: String read FIm write FIm;
    [Campo('Cep')]
    property Cep: String read FCep write FCep;
    [Campo('Codigo_ibge')]
    property Codigo_ibge: String read FCodigo_ibge write FCodigo_ibge;
    [Campo('Codigo_municipal')]
    property Codigo_municipal: String read FCodigo_municipal write FCodigo_municipal;
    [Campo('Pais')]
    property Pais: String read FPais write FPais;
    [Campo('Estado')]
    property Estado: String read FEstado write FEstado;
    [Campo('Uf')]
    property Uf: String read FUf write FUf;
    [Campo('Cidade')]
    property Cidade: String read FCidade write FCidade;
    [Campo('Bairro')]
    property Bairro: String read FBairro write FBairro;
    [Campo('Endereco')]
    property Endereco: String read FEndereco write FEndereco;
    [Campo('Endereco_numero')]
    property Endereco_numero: String read FEndereco_numero write FEndereco_numero;
    [Campo('Complemento')]
    property Complemento: String read FComplemento write FComplemento;
    [Campo('Telefone')]
    property Telefone: String read FTelefone write FTelefone;
    [Campo('Celular')]
    property Celular: String read FCelular write FCelular;
    [Campo('Email')]
    property Email: String read FEmail write FEmail;

    function ToJSONObject: TJsonObject;
    function ToJsonString: string;

  end;

implementation

constructor TEmpresa.Create;
begin

end;

destructor TEmpresa.Destroy;
begin

  inherited;
end;

function TEmpresa.ToJSONObject: TJsonObject;
begin
  Result := TJson.ObjectToJsonObject(Self);
end;

function TEmpresa.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

end.

