
  unit Test.Parsers;

interface

  uses
    Deltics.Smoketest;


  type
    Parsers = class(TTest)
      procedure AnsiAsString;
      procedure AnsiIsInteger;
      procedure AnsiIsSingle;
      procedure AnsiIsDouble;
      procedure AnsiIsExtended;
      procedure AnsiIsCurrency;
      procedure WideAsString;
      procedure WideIsInteger;
      procedure WideIsSingle;
      procedure WideIsDouble;
      procedure WideIsExtended;
      procedure WideIsCurrency;
    end;



implementation

  uses
    SysUtils,
    Deltics.StringTypes,
    Deltics.Strings.Parsers;


  type
    AnsiIsExtendedTestCase = record Value: AnsiString; IsExtended: Boolean; AsExtended: Extended; end;
    AnsiIsIntTestCase = record Value: AnsiString; IsInteger: Boolean; IsInt64: Boolean; AsInteger: Integer; AsInt64: Int64; end;
    WideIsExtendedTestCase = record Value: UnicodeString; IsExtended: Boolean; AsExtended: Extended; end;
    WideIsIntTestCase = record Value: UnicodeString; IsInteger: Boolean; IsInt64: Boolean; AsInteger: Integer; AsInt64: Int64; end;



  procedure Parsers.AnsiAsString;
  var
    buf: AnsiString;
    result: String;
  begin
    buf     := 'test';
    result  := Parse(buf).AsString;

    Test('Parse.Ansi().AsString').Assert(result).Equals('test');
  end;


  procedure Parsers.AnsiIsCurrency;
  begin

  end;


  procedure Parsers.AnsiIsDouble;
  begin

  end;


  procedure Parsers.AnsiIsExtended;
  const
    DATA  : array[1..15] of AnsiIsExtendedTestCase = (
      (Value: '42.0';           IsExtended: TRUE;   AsExtended: 42.0),
      (Value: '4.2e1';          IsExtended: TRUE;   AsExtended: 4.2e1),
      (Value: '-4.2e-1';        IsExtended: TRUE;   AsExtended: -4.2e-1),
      (Value: '42.';            IsExtended: TRUE;   AsExtended: 42.0),
      (Value: '4.2+e1';         IsExtended: FALSE;  AsExtended: 0),
      (Value: '4.2e+1';         IsExtended: TRUE;   AsExtended: 4.2e+1),
      (Value: '4/2';            IsExtended: FALSE;  AsExtended: 0),
      (Value: 'abc';            IsExtended: FALSE;  AsExtended: 0),
      (Value: '1,024';          IsExtended: FALSE;  AsExtended: 0),
      (Value: '42';             IsExtended: TRUE;   AsExtended: 42.0),
      (Value: '4 e3';           IsExtended: FALSE;  AsExtended: 0),
      (Value: '4294967295';     IsExtended: TRUE;   AsExtended: 4294967295.0),
      (Value: '2147483647';     IsExtended: TRUE;   AsExtended: 2147483647.0),
      (Value: '-2147483648';    IsExtended: TRUE;   AsExtended: -2147483648.0),
      (Value: '3.37e-4932';     IsExtended: TRUE;   AsExtended: 3.37e-4932)
    );
  var
    i: Integer;
    isReal: Boolean;
    isExtended: Boolean;
    asExtended: Extended;
  begin
    for i := Low(DATA) to High(DATA) do
    begin
      isReal := Parse.Ansi(DATA[i].Value).IsReal;
      Test('Parse.Ansi({test}).IsExtended', [DATA[i].Value]).Assert(isReal).Equals(DATA[i].IsExtended);

      isExtended := Parse.Ansi(DATA[i].Value).IsExtended(asExtended);
      Test('Parse.Ansi({test}).IsExtended(var)', [DATA[i].Value]).Assert(isExtended).Equals(DATA[i].IsExtended);

      if DATA[i].IsExtended then
        Test('Parse.Ansi({test}).AsExtended', [DATA[i].Value]).Assert(asExtended = DATA[i].AsExtended);
    end;
  end;


  procedure Parsers.AnsiIsInteger;
  const
    DATA  : array[1..13] of AnsiIsIntTestCase = (
      (Value: '42.0';           IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: '4.2e1';          IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: '-4.2e-1';        IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: '42.';            IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: '4.2+e1';         IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: '4/2';            IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: 'abc';            IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: '1,024';          IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: '42';             IsInteger: TRUE;  IsInt64: TRUE;  AsInteger: 42;  AsInt64: 42),
      (Value: '4 e3';           IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;             AsInt64:  0),
      (Value: '4294967295';     IsInteger: FALSE; IsInt64: TRUE;  AsInteger: 0;             AsInt64:  High(Cardinal)),
      (Value: '2147483647';     IsInteger: TRUE;  IsInt64: TRUE;  AsInteger: High(Integer); AsInt64:  High(Integer)),
      (Value: '-2147483648';    IsInteger: TRUE;  IsInt64: TRUE;  AsInteger: Low(Integer);  AsInt64:  Low(Integer))
    );
  var
    i: Integer;
    isInteger: Boolean;
    isInt64: Boolean;
    asInteger: Integer;
    asInt64: Int64;
  begin
    for i := Low(DATA) to High(DATA) do
    begin
      isInt64   := Parse.Ansi(DATA[i].Value).IsInt64(asInt64);
      isInteger := Parse.Ansi(DATA[i].Value).IsInteger(asInteger);

      Test('Parse.Ansi({value}).IsInt64', [DATA[i].Value]).Assert(isInt64).Equals(DATA[i].IsInt64);
      Test('Parse.Ansi({value}).IsInteger', [DATA[i].Value]).Assert(isInteger).Equals(DATA[i].IsInteger);

      if DATA[i].IsInt64 then
        Test('Parse.Ansi({value}).AsInt64', [DATA[i].Value]).Assert(asInt64).Equals(DATA[i].AsInt64);

      if DATA[i].IsInteger then
        Test('Parse.Ansi({value}).AsInteger', [DATA[i].Value]).Assert(asInteger).Equals(DATA[i].AsInteger);
    end;
  end;


  procedure Parsers.AnsiIsSingle;
  begin

  end;


  procedure Parsers.WideAsString;
  var
    buf: UnicodeString;
    result: String;
  begin
    buf     := 'test';
    result  := Parse(buf).AsString;

    Test('Parse.Wide().AsString').Assert(result).Equals('test');
  end;


  procedure Parsers.WideIsCurrency;
  begin

  end;


  procedure Parsers.WideIsDouble;
  begin

  end;


  procedure Parsers.WideIsExtended;
  const
    DATA  : array[1..15] of WideIsExtendedTestCase = (
      (Value: '42.0';           IsExtended: TRUE;   AsExtended: 42.0),
      (Value: '4.2e1';          IsExtended: TRUE;   AsExtended: 4.2e1),
      (Value: '-4.2e-1';        IsExtended: TRUE;   AsExtended: -4.2e-1),
      (Value: '42.';            IsExtended: TRUE;   AsExtended: 42.0),
      (Value: '4.2+e1';         IsExtended: FALSE;  AsExtended: 0),
      (Value: '4.2e+1';         IsExtended: TRUE;   AsExtended: 4.2e+1),
      (Value: '4/2';            IsExtended: FALSE;  AsExtended: 0),
      (Value: 'abc';            IsExtended: FALSE;  AsExtended: 0),
      (Value: '1,024';          IsExtended: FALSE;  AsExtended: 0),
      (Value: '42';             IsExtended: TRUE;   AsExtended: 42.0),
      (Value: '4 e3';           IsExtended: FALSE;  AsExtended: 0),
      (Value: '4294967295';     IsExtended: TRUE;   AsExtended: 4294967295.0),
      (Value: '2147483647';     IsExtended: TRUE;   AsExtended: 2147483647.0),
      (Value: '-2147483648';    IsExtended: TRUE;   AsExtended: -2147483648.0),
      (Value: '3.37e-4932';     IsExtended: TRUE;   AsExtended: 3.37e-4932)
    );
  var
    i: Integer;
    isReal: Boolean;
    isExtended: Boolean;
    asExtended: Extended;
  begin
    for i := Low(DATA) to High(DATA) do
    begin
      isReal := Parse.Wide(DATA[i].Value).IsReal;
      Test('Parse.Wide({test}).IsExtended', [DATA[i].Value]).Assert(isReal).Equals(DATA[i].IsExtended);

      isExtended := Parse.Wide(DATA[i].Value).IsExtended(asExtended);
      Test('Parse.Wide({test}).IsExtended(var)', [DATA[i].Value]).Assert(isExtended).Equals(DATA[i].IsExtended);

      if DATA[i].IsExtended then
        Test('Parse.Wide({test}).AsExtended', [DATA[i].Value]).Assert(asExtended = DATA[i].AsExtended);
    end;
  end;


  procedure Parsers.WideIsInteger;
  const
    DATA  : array[1..13] of WideIsIntTestCase = (
      (Value: '42.0';           IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: '4.2e1';          IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: '-4.2e-1';        IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: '42.';            IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: '4.2+e1';         IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: '4/2';            IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: 'abc';            IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: '1,024';          IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;   AsInt64: 0),
      (Value: '42';             IsInteger: TRUE;  IsInt64: TRUE;  AsInteger: 42;  AsInt64: 42),
      (Value: '4 e3';           IsInteger: FALSE; IsInt64: FALSE; AsInteger: 0;             AsInt64:  0),
      (Value: '4294967295';     IsInteger: FALSE; IsInt64: TRUE;  AsInteger: 0;             AsInt64:  High(Cardinal)),
      (Value: '2147483647';     IsInteger: TRUE;  IsInt64: TRUE;  AsInteger: High(Integer); AsInt64:  High(Integer)),
      (Value: '-2147483648';    IsInteger: TRUE;  IsInt64: TRUE;  AsInteger: Low(Integer);  AsInt64:  Low(Integer))
    );
  var
    i: Integer;
    isInteger: Boolean;
    isInt64: Boolean;
    asInteger: Integer;
    asInt64: Int64;
  begin
    for i := Low(DATA) to High(DATA) do
    begin
      isInt64   := Parse.Wide(DATA[i].Value).IsInt64(asInt64);
      isInteger := Parse.Wide(DATA[i].Value).IsInteger(asInteger);

      Test('Parse.Wide({value}).IsInt64', [DATA[i].Value]).Assert(isInt64).Equals(DATA[i].IsInt64);
      Test('Parse.Wide({value}).IsInteger', [DATA[i].Value]).Assert(isInteger).Equals(DATA[i].IsInteger);

      if DATA[i].IsInt64 then
        Test('Parse.Wide({value}).AsInt64', [DATA[i].Value]).Assert(asInt64).Equals(DATA[i].AsInt64);

      if DATA[i].IsInteger then
        Test('Parse.Wide({value}).AsInteger', [DATA[i].Value]).Assert(asInteger).Equals(DATA[i].AsInteger);
    end;
  end;





procedure Parsers.WideIsSingle;
begin

end;

end.
