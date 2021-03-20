
{$i deltics.stringparsers.inc}

  unit Deltics.StringParsers;


interface

  uses
    Deltics.StringTypes,
    Deltics.StringParsers.Interfaces,
    Deltics.StringParsers.Class_;



  function Parse: ParseClass; overload;
  function Parse(const aString: AnsiString): Parser; overload;
  function Parse(const aString: UnicodeString): Parser; overload;
{$ifdef UNICODE}
  function Parse(const aString: Utf8String): Parser; overload;
  function Parse(const aString: WideString): Parser; overload;
{$endif}
  function ParseUtf8(const aString: Utf8String): Parser;



implementation



  function Parse: ParseClass;
  begin
    result := Parse_;
  end;


  function Parse(const aString: AnsiString): Parser;
  begin
    result := Parse_.Ansi(aString);
  end;


  function Parse(const aString: UnicodeString): Parser;
  begin
    result := Parse_.Wide(aString);
  end;


{$ifdef UNICODE}
  function Parse(const aString: Utf8String): Parser;
  begin
    result := Parse_.Ansi(AnsiString(aString));
  end;


  function Parse(const aString: WideString): Parser;
  begin
    result := Parse_.Wide(WideString(aString));
  end;
{$endif}


  function ParseUtf8(const aString: Utf8String): Parser;
  begin
    result := Parse_.Ansi(AnsiString(aString));
  end;



end.


