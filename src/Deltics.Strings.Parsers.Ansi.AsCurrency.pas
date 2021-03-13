
{$i deltics.strings.parsers.inc}


  unit Deltics.Strings.Parsers.Ansi.AsCurrency;


interface

  function CheckCurrency(aBuffer: PAnsiChar; aLen: Integer): Boolean;
  function ParseCurrency(aBuffer: PAnsiChar; aLen: Integer; var aValue: Currency): Boolean;


implementation

  uses
    SysUtils,
    Deltics.Strings;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function Init(var aBuffer: PAnsiChar;
                var aLen: Integer;
                var aNeg: Boolean): Boolean; {$ifdef InlineMethods} inline; {$endif}
  begin
    aNeg := FALSE;

    while (aLen > 0) and (aBuffer[0] = ' ') do
    begin
      Inc(aBuffer);
      Dec(aLen);
    end;

    while (aLen > 0) and (aBuffer[aLen - 1] = ' ') do
      Dec(aLen);

    case aLen of

      0 : result := FALSE;

      1 : case aBuffer[0] of
            '0'..'9': result := TRUE;
          else
            result := FALSE;
          end;

    else
      case aBuffer[0] of
        '-'     : begin
                    aNeg := TRUE;
                    Inc(aBuffer);
                    Dec(aLen);

                    result := aLen > 0;
                  end;

        '+'     : begin
                    Inc(aBuffer);
                    Dec(aLen);

                    result := aLen > 0;
                  end;

        '0'..'9': result := TRUE;
      else
        result := FALSE;
      end;
    end;

    // Skip over any leading zeroes
    while (aLen > 0) and (aBuffer[0] = '0') do
    begin
      Inc(aBuffer);
      Dec(aLen);
    end;
  end;




  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function CheckCurrency(aBuffer: PAnsiChar;
                         aLen: Integer): Boolean;
  type
    Element = (eInt, eDec);
  var
    pc: PAnsiChar absolute aBuffer;
    i: Integer;
    neg: Boolean;
    e: Element;
  begin
    result := Init(aBuffer, aLen, neg);
    if NOT result then
      EXIT;

    result  := FALSE;
    e       := eInt;

    for i := 0 to Pred(aLen) do
    begin
      case pc[i] of
        '0'..'9'  : CONTINUE;

        '.'       : if e = eInt then
                      e := eDec
                    else
                      EXIT;
      else
        EXIT;
      end;
    end;

    result := TRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function ParseCurrency(    aBuffer: PAnsiChar;
                             aLen: Integer;
                         var aValue: Currency): Boolean;
  var
    s: String;
  begin
    s := Str.FromAnsi(aBuffer, aLen);
    result := TryStrToCurr(s, aValue);
  end;







end.
