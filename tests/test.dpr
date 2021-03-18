
{$apptype CONSOLE}

  program test;


uses
  Deltics.Smoketest,
  Deltics.StringParsers in '..\src\Deltics.StringParsers.pas',
  Deltics.StringParsers.Class_ in '..\src\Deltics.StringParsers.Class_.pas',
  Deltics.StringParsers.Interfaces in '..\src\Deltics.StringParsers.Interfaces.pas',
  Deltics.StringParsers.Ansi in '..\src\Deltics.StringParsers.Ansi.pas',
  Deltics.StringParsers.Ansi.AsBoolean in '..\src\Deltics.StringParsers.Ansi.AsBoolean.pas',
  Deltics.StringParsers.Ansi.AsCurrency in '..\src\Deltics.StringParsers.Ansi.AsCurrency.pas',
  Deltics.StringParsers.Ansi.AsDatetime in '..\src\Deltics.StringParsers.Ansi.AsDatetime.pas',
  Deltics.StringParsers.Ansi.AsInteger in '..\src\Deltics.StringParsers.Ansi.AsInteger.pas',
  Deltics.StringParsers.Ansi.AsReal in '..\src\Deltics.StringParsers.Ansi.AsReal.pas',
  Deltics.StringParsers.Wide in '..\src\Deltics.StringParsers.Wide.pas',
  Deltics.StringParsers.Wide.AsBoolean in '..\src\Deltics.StringParsers.Wide.AsBoolean.pas',
  Deltics.StringParsers.Wide.AsCurrency in '..\src\Deltics.StringParsers.Wide.AsCurrency.pas',
  Deltics.StringParsers.Wide.AsDatetime in '..\src\Deltics.StringParsers.Wide.AsDatetime.pas',
  Deltics.StringParsers.Wide.AsInteger in '..\src\Deltics.StringParsers.Wide.AsInteger.pas',
  Deltics.StringParsers.Wide.AsReal in '..\src\Deltics.StringParsers.Wide.AsReal.pas',
  Test.Parsers in 'Test.Parsers.pas';

begin
  TestRun.Test(Parsers);
end.
