
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
      function AsInt64: Int64;
      function AsInt64OrDefault(const aDefault: Int64): Int64;
      function AsInteger: Integer;
      function AsIntegerOrDefault(const aDefault: Integer): Integer;
      function AsString: String;
      function IsBoolean: Boolean; overload;
      function IsBoolean(var aValue: Boolean): Boolean; overload;
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






end.


