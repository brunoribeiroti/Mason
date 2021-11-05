program Mason;

uses
  Vcl.Forms,
  Main in 'Source\Main.pas' {FrmMain},
  Vcl.Themes,
  Vcl.Styles,
  Utils.IniFile in 'Source\Utils\Utils.IniFile.pas',
  Utils.Functions in 'Source\Utils\Utils.Functions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Calypso SLE');
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;

end.
