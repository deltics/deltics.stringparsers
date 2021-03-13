
  unit Test.Parsers;

interface

  uses
    Deltics.Smoketest;


  type
    Parsers = class(TTest)
      procedure AnsiAsString;
      procedure AnsiIsInteger;
      procedure WideAsString;
      procedure WideIsInteger;
    end;



implementation

  uses
    SysUtils,
    Deltics.StringTypes,
    Deltics.Strings.Parsers;


  type
    AnsiIsIntTestCase = record Value: AnsiString; IsInteger: Boolean; IsInt64: Boolean; AsInteger: Integer; AsInt64: Int64; end;
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


  procedure Parsers.WideAsString;
  var
    buf: UnicodeString;
    result: String;
  begin
    buf     := 'test';
    result  := Parse(buf).AsString;

    Test('Parse.Wide().AsString').Assert(result).Equals('test');
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





end.
