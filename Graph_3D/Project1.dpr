program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  graph3d in 'graph3d.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
