
{$i deltics.strings.parsers.inc}

  unit Deltics.Strings.Parsers.Class_;


interface

  uses
    Deltics.StringTypes,
    Deltics.Strings.Parsers.Interfaces;


  type
    Parse_ = class
    public
      class function Ansi(const aBuffer: PAnsiChar; const aNumChars: Integer): Parser; overload;
      class function Ansi(const aString: AnsiString): Parser; overload;
      class function Wide(const aBuffer: PWideChar; const aNumChars: Integer): Parser; overload;
      class function Wide(const aString: UnicodeString): Parser; overload;
    end;
    ParseClass = class of Parse_;


implementation

  uses
    Deltics.Strings.Parsers.Ansi,
    Deltics.Strings.Parsers.Wide;



{ Parse }

  class function Parse_.Ansi(const aBuffer: PAnsiChar; const aNumChars: Integer): Parser;
  begin
    result := TAnsiParser.Create(aBuffer, aNumChars);
  end;


  class function Parse_.Ansi(const aString: AnsiString): Parser;
  begin
    result := TAnsiParser.Create(PAnsiChar(aString), Length(aString));
  end;



  class function Parse_.Wide(const aBuffer: PWideChar; const aNumChars: Integer): Parser;
  begin
    result := TWideParser.Create(aBuffer, aNumChars);
  end;


  class function Parse_.Wide(const aString: UnicodeString): Parser;
  begin
    result := TWideParser.Create(PWideChar(aString), Length(aString));
  end;


end.


