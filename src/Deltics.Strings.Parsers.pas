
{$i deltics.strings.parsers.inc}

  unit Deltics.Strings.Parsers;


interface

  uses
    Deltics.StringTypes,
    Deltics.Strings.Parsers.Ansi,
    Deltics.Strings.Parsers.Wide;


  type
    Parse = class
    public
      class function Ansi(const aBuffer: PAnsiChar; const aNumChars: Integer): AnsiParser; overload;
      class function Ansi(const aString: AnsiString): AnsiParser; overload;
      class function Wide(const aBuffer: PWideChar; const aNumChars: Integer): WideParser; overload;
      class function Wide(const aString: UnicodeString): WideParser; overload;
    end;




implementation



{ Parse }

  class function Parse.Ansi(const aBuffer: PAnsiChar; const aNumChars: Integer): AnsiParser;
  begin
    result := TAnsiParser.Create(aBuffer, aNumChars);
  end;


  class function Parse.Ansi(const aString: AnsiString): AnsiParser;
  begin
    result := TAnsiParser.Create(PAnsiChar(aString), Length(aString));
  end;



  class function Parse.Wide(const aBuffer: PWideChar; const aNumChars: Integer): WideParser;
  begin
    result := TWideParser.Create(aBuffer, aNumChars);
  end;


  class function Parse.Wide(const aString: UnicodeString): WideParser;
  begin
    result := TWideParser.Create(PWideChar(aString), Length(aString));
  end;


end.


