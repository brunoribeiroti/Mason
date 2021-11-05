program TestORM;

uses
  Vcl.Forms,
  View.Main in 'Source\View\View.Main.pas' {Form1},
  Model.Entity.Empresa in 'Source\Model\Entity\Model.Entity.Empresa.pas',
  Model.Empresa.Interfaces in 'Source\Model\Model.Empresa.Interfaces.pas',
  Model.Empresa in 'Source\Model\Model.Empresa.pas',
  Model.Connection in 'Source\Model\Connection\Model.Connection.pas' {DmConexao: TDataModule},
  Controller.Empresa.Interfaces in 'Source\Controller\Controller.Empresa.Interfaces.pas',
  Controller.Empresa in 'Source\Controller\Controller.Empresa.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDmConexao, DmConexao);
  Application.Run;
end.
