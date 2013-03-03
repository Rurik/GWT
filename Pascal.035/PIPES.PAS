unit pipes;
interface
  function ucase(s1:string):string;
  procedure sPipe(Strng:string);
  procedure sPipeLn(Strng:string);
implementation
uses crt,ddplus;

function ucase(s1: string): string;
var
 s2 : string;
 i1: integer;
begin
 s2:='';
 for i1:=1 to length(s1) do s2:=s2+upcase(s1[i1]);
 ucase:=s2;
end;

Procedure sPipe(Strng : String);
Var Flash,Cnter: Byte;
    c:string;
    ok, done:boolean;
Begin
  For Cnter:=1 to Length(Strng) do Begin
    done := true;    
    If Strng[Cnter] = '|' then Begin
      Inc(Cnter);
      ok := (ord(strng[cnter]) = 49) and (ord(strng[cnter+1]) in [48..53]);
      if ok then begin
        flash := 0;
        inc(Cnter);
        case Strng[Cnter] Of
          '0':set_color(10,current_background);
          '1':set_color(11,current_background);
          '2':set_color(12,current_background);
          '3':set_color(13,current_background);
          '4':set_color(14,current_background);
          '5':set_color(15,current_background);
        end;
      end
      else if not ok then begin
        if Strng[Cnter] = '0' then flash := 0 else flash := 15;
        Inc(Cnter);
        Case Strng[Cnter] Of
          '0':set_color(0,flash);
          '1':set_color(1,Flash);
          '2':set_color(2,Flash);
          '3':set_color(3,Flash);
          '4':set_color(4,Flash);
          '5':set_color(5,Flash);
          '6':set_color(6,Flash);
          '7':set_color(7,Flash);
          '8':set_color(8,Flash);
          '9':set_color(9,Flash);
        End;
      end;
    End
      else done := false;
    if not done then sWrite(Strng[Cnter]);
  End;
end;

Procedure sPipeLn(Strng : String);
Var Cnter: Byte;
Begin
  sPipe(Strng+#13#10);
End;

end.