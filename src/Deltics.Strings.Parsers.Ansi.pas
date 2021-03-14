
{$i deltics.strings.parsers.inc}

  unit Deltics.Strings.Parsers.Ansi;


interface

  uses
    Deltics.InterfacedObjects,
    Deltics.StringTypes,
    Deltics.Strings.Parsers.Interfaces;


  type
    TAnsiParser = class(TComInterfacedObject, Parser)
    public // AnsiParser
      function AsBoolean: Boolean;
      function AsBooleanOrDefault(const aDefault: Boolean): Boolean;
      function AsCurrency: Currency;
      function AsCurrencyOrDefault(const aDefault: Currency): Currency;
      function AsExtended: Extended;
      function AsExtendedOrDefault(const aDefault: Extended): Extended;
      function AsInt64: Int64;
      function AsInt64OrDefault(const aDefault: Int64): Int64;
      function AsInteger: Integer;
      function AsIntegerOrDefault(const aDefault: Integer): Integer;
      function AsString: String;
      function IsBoolean: Boolean; overload;
      function IsBoolean(var aValue: Boolean): Boolean; overload;
      function IsCurrency: Boolean; overload;
      function IsCurrency(var aValue: Currency): Boolean; overload;
      function IsReal: Boolean; overload;
      function IsExtended: Boolean; overload;
      function IsExtended(var aValue: Extended): Boolean; overload;
      function IsInt64: Boolean; overload;
      function IsInt64(var aValue: Int64): Boolean; overload;
      function IsInteger: Boolean; overload;
      function IsInteger(var aValue: Integer): Boolean; overload;

    private
      fBuffer: PAnsiChar;
      fNumChars: Integer;
    public
      constructor Create(const aBuffer: PAnsiChar; const aNumChars: Integer);
    end;




implementation

  uses
    SysUtils,
  {$ifdef UNICODE}
    Windows,
  {$endif}
    Deltics.Memory,
    Deltics.Unicode,
    Deltics.Strings.Parsers.Ansi.AsBoolean,
    Deltics.Strings.Parsers.Ansi.AsCurrency,
    Deltics.Strings.Parsers.Ansi.AsReal,
    Deltics.Strings.Parsers.Ansi.AsInteger;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  constructor TAnsiParser.Create(const aBuffer: PAnsiChar;
                                 const aNumChars: Integer);
  begin
    inherited Create;

    fBuffer   := aBuffer;
    fNumChars := aNumChars;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.AsString: String;
{$ifdef UNICODE}
  var
    len: Integer;
  begin
    len := MultiByteToWideChar(CP_ACP, 0, fBuffer, fNumChars, NIL, 0);
    if fNumChars = -1 then
      Dec(len);

    SetLength(result, len);
    MultiByteToWideChar(CP_ACP, 0, fBuffer, fNumChars, PWideChar(result), len);
  end;
{$else}
  begin
    SetLength(result, fNumChars);
    Memory.Copy(fBuffer, fNumChars, PAnsiChar(result));
  end;
{$endif}


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.AsBoolean: Boolean;
  begin
    if NOT ParseBoolean(fBuffer, fNumChars, result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid boolean expression', [AsString]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.AsBooleanOrDefault(const aDefault: Boolean): Boolean;
  begin
    if NOT ParseBoolean(fBuffer, fNumChars, result) then
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.AsCurrency: Currency;
  begin
    if NOT ParseCurrency(fBuffer, fNumChars, result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid currency expression', [AsString]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.AsCurrencyOrDefault(const aDefault: Currency): Currency;
  begin
    if NOT ParseCurrency(fBuffer, fNumChars, result) then
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.AsExtended: Extended;
  begin
    if NOT ParseExtended(fBuffer, fNumChars, result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid extended precision expression', [AsString]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.AsExtendedOrDefault(const aDefault: Extended): Extended;
  begin
    if NOT ParseExtended(fBuffer, fNumChars, result) then
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.AsInt64: Int64;
  begin
    if NOT ParseInt64(fBuffer, fNumChars, result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid 64-bit integer expression', [AsString]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.AsInt64OrDefault(const aDefault: Int64): Int64;
  begin
    if NOT ParseInt64(fBuffer, fNumChars, result) then
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.AsInteger: Integer;
  begin
    if NOT ParseInteger(fBuffer, fNumChars, result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid integer expression', [AsString]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.AsIntegerOrDefault(const aDefault: Integer): Integer;
  begin
    if NOT ParseInteger(fBuffer, fNumChars, result) then
      result := aDefault;
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.IsBoolean: Boolean;
  begin
    result := CheckBoolean(fBuffer, fNumChars);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.IsBoolean(var aValue: Boolean): Boolean;
  begin
    result := ParseBoolean(fBuffer, fNumChars, aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.IsCurrency: Boolean;
  begin
    result := CheckCurrency(fBuffer, fNumChars);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.IsCurrency(var aValue: Currency): Boolean;
  begin
    result := ParseCurrency(fBuffer, fNumChars, aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.IsExtended: Boolean;
  var
    notUsed: Extended;
  begin
    result := ParseExtended(fBuffer, fNumChars, notUsed);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.IsExtended(var aValue: Extended): Boolean;
  begin
    result := ParseExtended(fBuffer, fNumChars, aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.IsInt64: Boolean;
  begin
    result := CheckInteger(fBuffer, fNumChars);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.IsInt64(var aValue: Int64): Boolean;
  begin
    result := ParseInt64(fBuffer, fNumChars, aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.IsInteger: Boolean;
  begin
    result := CheckInteger(fBuffer, fNumChars);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.IsInteger(var aValue: Integer): Boolean;
  begin
    result := ParseInteger(fBuffer, fNumChars, aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TAnsiParser.IsReal: Boolean;
  begin
    result := CheckReal(fBuffer, fNumChars);
  end;






end.


