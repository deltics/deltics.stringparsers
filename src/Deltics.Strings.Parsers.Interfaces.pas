
{$i deltics.strings.parsers.inc}

  unit Deltics.Strings.Parsers.Interfaces;


interface

  type
    Parser = interface
    ['{C495749A-25E7-499F-9F25-32DB8130A63F}']
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
      function IsExtended: Boolean; overload;
      function IsExtended(var aValue: Extended): Boolean; overload;
      function IsReal: Boolean; overload;
      function IsInt64: Boolean; overload;
      function IsInt64(var aValue: Int64): Boolean; overload;
      function IsInteger: Boolean; overload;
      function IsInteger(var aValue: Integer): Boolean; overload;
    end;


implementation



end.
