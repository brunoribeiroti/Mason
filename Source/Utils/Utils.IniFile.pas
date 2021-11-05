unit Utils.IniFile;

interface

uses
  System.SysUtils,
  System.IniFiles;

type
  TIniFileConfig = class(TIniFile)
  private
    function GetDatabaseHostname: String;
    function GetDatabaseUsername: String;
    function GetDatabasePassword: String;
    function GetDatabasePort: String;
    function GetDatabasePath: String;
    function GetPathProject: String;
    procedure SetDatabaseHostname(const Value: String);
    procedure SetDatabaseUsername(const Value: String);
    procedure SetDatabasePassword(const Value: String);
    procedure SetDatabasePort(const Value: String);
    procedure SetDatabasePath(const Value: String);
    procedure SetPathProject(const Value: String);
  public
    property DatabaseHostname: String read GetDatabaseHostname write SetDatabaseHostname;
    property DatabaseUsername: String read GetDatabaseUsername write SetDatabaseUsername;
    property DatabasePassword: String read GetDatabasePassword write SetDatabasePassword;
    property DatabasePort: String read GetDatabasePort write SetDatabasePort;
    property DatabasePath: String read GetDatabasePath write SetDatabasePath;
    property PathProject: String read GetPathProject write SetPathProject;
  end;

var
  IniFileConfig: TIniFileConfig;

implementation

{ TCfg }

function TIniFileConfig.GetDatabaseHostname: String;
begin
  Result := ReadString('Database', 'Hostname', '');
end;

function TIniFileConfig.GetDatabaseUsername: String;
begin
  Result := ReadString('Database', 'Username', '');
end;

function TIniFileConfig.GetDatabasePassword: String;
begin
  Result := ReadString('Database', 'Password', '');
end;

function TIniFileConfig.GetDatabasePort: String;
begin
  Result := ReadString('Database', 'Port', '');
end;

function TIniFileConfig.GetDatabasePath: String;
begin
  Result := ReadString('Database', 'Path', '');
end;

function TIniFileConfig.GetPathProject: String;
begin
  Result := ReadString('Directory', 'PathProject', '');
end;

procedure TIniFileConfig.SetDatabaseHostname(const Value: String);
begin
  WriteString('Database', 'Hostname', Value);
end;

procedure TIniFileConfig.SetDatabaseUsername(const Value: String);
begin
  WriteString('Database', 'Username', Value);
end;

procedure TIniFileConfig.SetDatabasePassword(const Value: String);
begin
  WriteString('Database', 'Password', Value);
end;

procedure TIniFileConfig.SetDatabasePort(const Value: String);
begin
  WriteString('Database', 'Port', Value);
end;

procedure TIniFileConfig.SetDatabasePath(const Value: String);
begin
  WriteString('Database', 'Path', Value);
end;

procedure TIniFileConfig.SetPathProject(const Value: String);
begin
  WriteString('Directory', 'PathProject', Value);
end;

initialization
  IniFileConfig := TIniFileConfig.Create(ChangeFileExt(ParamStr(0), '.ini'));

finalization
  FreeAndNil(IniFileConfig);

end.

