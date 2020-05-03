program Project2;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainF},
  Format in 'Format.pas' {FormatF};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainF, MainF);
  Application.CreateForm(TFormatF, FormatF);
  Application.Run;
end.
