
{$i deltics.strings.parsers.inc}

  unit Deltics.Strings.Parsers.Wide;


interface

  uses
    Deltics.InterfacedObjects,
    Deltics.StringTypes;


  type
    WideParser = interface
    ['{C495749A-25E7-499F-9F25-32DB8130A63F}']
      function AsBoolean: Boolean;
      function AsBooleanOrDefault(const aDefault: Boolean): Boolean;
      function AsInt64: Int64;
      function AsInt64OrDefault(const aDefault: Int64): Int64;
      function AsInteger: Integer;
      function AsIntegerOrDefault(const aDefault: Integer): Integer;
      function IsBoolean: Boolean; overload;
      function IsBoolean(var aValue: Boolean): Boolean; overload;
      function IsInt64: Boolean; overload;
      function IsInt64(var aValue: Int64): Boolean; overload;
      function IsInteger: Boolean; overload;
      function IsInteger(var aValue: Integer): Boolean; overload;
    end;



    TWideParser = class(TComInterfacedObject, WideParser)
    public // WideParser
      function AsBoolean: Boolean;
      function AsBooleanOrDefault(const aDefault: Boolean): Boolean;
      function AsInt64: Int64;
      function AsInt64OrDefault(const aDefault: Int64): Int64;
      function AsInteger: Integer;
      function AsIntegerOrDefault(const aDefault: Integer): Integer;
      function IsBoolean: Boolean; overload;
      function IsBoolean(var aValue: Boolean): Boolean; overload;
      function IsInt64: Boolean; overload;
      function IsInt64(var aValue: Int64): Boolean; overload;
      function IsInteger: Boolean; overload;
      function IsInteger(var aValue: Integer): Boolean; overload;

    private
      fBuffer: PWideChar;
      fNumChars: Integer;
      function get_AsString: String;
    public
      constructor Create(const aBuffer: PWideChar; const aNumChars: Integer);
      property AsString: String read get_AsString;
    end;




implementation

  uses
    SysUtils,
  {$ifNdef UNICODE}
    Windows,
  {$endif}
    Deltics.Memory,
    Deltics.Unicode,
    Deltics.Strings.Parsers.Wide.AsBoolean,
    Deltics.Strings.Parsers.Wide.AsInteger;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  constructor TWideParser.Create(const aBuffer: PWideChar;
                                 const aNumChars: Integer);
  begin
    inherited Create;

    fBuffer   := aBuffer;
    fNumChars := aNumChars;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWideParser.AsString: String;
{$ifdef UNICODE}
  begin
    SetLength(result, fNumChars);
    Memory.Copy(fBuffer, fNumChars * 2, PWideChar(result));
  end;
{$else}
  var
    len: Integer;
  begin
    len := WideCharToMultiByte(CP_ACP, 0, fBuffer, fNumChars, NIL, 0, NIL, NIL);
    if fNumChars = -1 then
      Dec(len);

    SetLength(result, len);
    WideCharToMultiByte(CP_ACP, 0, fBuffer, fNumChars, PAnsiChar(result), len, NIL, NIL);
  end;
{$endif}


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWideParser.AsBoolean: Boolean;
  begin
    if NOT ParseBoolean(fBuffer, fNumChars, result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid boolean expression', [AsString]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWideParser.AsBooleanOrDefault(const aDefault: Boolean): Boolean;
  begin
    if NOT ParseBoolean(fBuffer, fNumChars, result) then
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWideParser.AsInt64: Int64;
  begin
    if NOT ParseInt64(fBuffer, fNumChars, result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid 64-bit integer expression', [AsString]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWideParser.AsInt64OrDefault(const aDefault: Int64): Int64;
  begin
    if NOT ParseInt64(fBuffer, fNumChars, result) then
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWideParser.AsInteger: Integer;
  begin
    if NOT ParseInteger(fBuffer, fNumChars, result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid integer expression', [AsString]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWideParser.AsIntegerOrDefault(const aDefault: Integer): Integer;
  begin
    if NOT ParseInteger(fBuffer, fNumChars, result) then
      result := aDefault;
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWideParser.IsBoolean: Boolean;
  begin
    result := CheckBoolean(fBuffer, fNumChars);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWideParser.IsBoolean(var aValue: Boolean): Boolean;
  begin
    result := ParseBoolean(fBuffer, fNumChars, aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWideParser.IsInt64: Boolean;
  begin
    result := CheckInteger(fBuffer, fNumChars);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWideParser.IsInt64(var aValue: Int64): Boolean;
  begin
    result := ParseInt64(fBuffer, fNumChars, aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWideParser.IsInteger: Boolean;
  begin
    result := CheckInteger(fBuffer, fNumChars);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWideParser.IsInteger(var aValue: Integer): Boolean;
  begin
    result := ParseInteger(fBuffer, fNumChars, aValue);
  end;






end.


