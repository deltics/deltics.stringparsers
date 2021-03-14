
{$apptype CONSOLE}

  program test;


uses
  Deltics.Smoketest,
  Deltics.Strings.Parsers in '..\src\Deltics.Strings.Parsers.pas',
  Deltics.Strings.Parsers.Class_ in '..\src\Deltics.Strings.Parsers.Class_.pas',
  Deltics.Strings.Parsers.Interfaces in '..\src\Deltics.Strings.Parsers.Interfaces.pas',
  Deltics.Strings.Parsers.Ansi in '..\src\Deltics.Strings.Parsers.Ansi.pas',
  Deltics.Strings.Parsers.Ansi.AsBoolean in '..\src\Deltics.Strings.Parsers.Ansi.AsBoolean.pas',
  Deltics.Strings.Parsers.Ansi.AsDatetime in '..\src\Deltics.Strings.Parsers.Ansi.AsDatetime.pas',
  Deltics.Strings.Parsers.Ansi.AsInteger in '..\src\Deltics.Strings.Parsers.Ansi.AsInteger.pas',
  Deltics.Strings.Parsers.Wide in '..\src\Deltics.Strings.Parsers.Wide.pas',
  Deltics.Strings.Parsers.Wide.AsBoolean in '..\src\Deltics.Strings.Parsers.Wide.AsBoolean.pas',
  Deltics.Strings.Parsers.Wide.AsDatetime in '..\src\Deltics.Strings.Parsers.Wide.AsDatetime.pas',
  Deltics.Strings.Parsers.Wide.AsInteger in '..\src\Deltics.Strings.Parsers.Wide.AsInteger.pas',
  Deltics.Strings.Parsers.Ansi.AsReal in '..\src\Deltics.Strings.Parsers.Ansi.AsReal.pas',
  Deltics.Strings.Parsers.Wide.AsReal in '..\src\Deltics.Strings.Parsers.Wide.AsReal.pas',
  Deltics.Strings.Parsers.Ansi.AsCurrency in '..\src\Deltics.Strings.Parsers.Ansi.AsCurrency.pas',
  Deltics.Strings.Parsers.Wide.AsCurrency in '..\src\Deltics.Strings.Parsers.Wide.AsCurrency.pas',
  Test.Parsers in 'Test.Parsers.pas';

begin
  TestRun.Test(Parsers);
end.
