{all coded by BeB =-]}
unit beb;
{$O+}
{$V-}
{$F+}

interface
uses dos, crt, ddplus,register;
type string255=string[255];
const timer:longint=50000; {sega000:word=$a000;}
function left(s:string; num:integer):string;
function Right(s:string; num:integer):string;
function value(s:string): integer;
function space(a:integer): string;
function ISTR(number:integer): string;
function stringstring(length:integer; text:char):string;
function writecorrect(s:string):string;
procedure swapint(i1, i2:longint);
procedure swap(i1, i2:string);
procedure Enter;
procedure PressKey;
function readlim(x,y,fg,bg,len:word):string255;
function sreadlim(x,y,fg,bg,len:word):string255;
function ucase(s1:string): string;
function file_exists(s:string): boolean;
function locase(c:char):char;
implementation

procedure swap(i1, i2:string);
var temp:string;
begin
  temp := i1;
  i1 := i2;
  i2 := temp;
end;

procedure swapint(i1, i2:longint);
var temp:longint;
begin
  temp := i1;
  i1 := i2;
  i2 := temp;
end;

function locase(c:char):char;
begin
  if c in ['A'..'Z'] then c := chr(ord(c)+32);
  locase := c;
end;

function writecorrect(s:string):string;
var temp:integer;
begin
  s[1] := upcase(s[1]);
  temp := 1;
  for temp := 2 to length(s) do begin
    if s[temp-1] = #32 then s[temp] := upcase(s[temp]) else s[temp] := locase(s[temp]);
  end;
  writecorrect := s;
end;

function value(s:string):integer;
var r, code:integer;
begin
val(s,r,code);
value := r;
end;

function ISTR(number:integer): string;
var s:string;
begin
  STR(number, s);
  istr:=s;
end;

function stringstring(length:integer; text:char):string;
var loop:integer;
    v:string;
begin
  v := '';
  for loop := 1 to length do v := v + text;
  stringstring := v;
end;

procedure PressKey;
var a:char;
begin
  sread_char(a);
end;

procedure Enter;
begin
  swriteln('');
end;

function left(s:string; num:integer):string;
begin
  left := copy(s, 1, num);
end;

function right(s:string; num:integer):string;
begin
  right := copy(s, length(s) - num, num);
end;

function space(a:integer): string;
var s:string;
    loop:integer;
begin
  for loop:= 1 to a do s:=s+' ';
  space:=s;
end;

  function readlim(x,y,fg,bg,len:word):string255;
  var
    out:string[1];
    charout:char;
    tempstring:string255;
  begin
    readlim:=''; tempstring:=''; textcolor(fg); textbackground(bg);
    gotoxy(x,y);
    out[1]:=#0;
    repeat
      charout:=readkey;
      out:=charout;
      case out[1] of
        #8:if length(tempstring)>=1 then begin
             delete(tempstring,length(tempstring),1);
             write(#8+#32+#8);
           end
           else begin
             sound(1000);
             delay(500);
             nosound;
           end;
           else if length(tempstring)<=len then begin
             tempstring:=tempstring+out[1];
             write(out[1]);
           end
           else begin
             sound(1000);
             delay(5);
             nosound;
           end;
      end;
    until out[1]=#13;
    writeln;
    writeln(tempstring,' ',length(tempstring));readln;
    readlim:=tempstring;
  end;

  function sreadlim(x,y,fg,bg,len:word):string255;
  var
    out:string[1];
    charout:char;
    tempstring:string255;
  begin
    sreadlim:=''; tempstring:=''; set_color(fg,bg);
    sgoto_xy(x,y);
    out[1]:=#0;
    repeat
      sread_char(charout);
      out:=charout;
      case out[1] of
        #8:if length(tempstring)>=1 then begin
             delete(tempstring,length(tempstring),1);
             swrite(#8+#32+#8);
           end else begin
             sound(1000);
             delay(500);
             nosound;
           end;
        else if length(tempstring)<=len then begin
            tempstring:=tempstring+out[1];
            swrite(out[1]);
          end else begin
              {sound(1000);
              delay(500);
              nosound;}
            end;
      end;
    until out[1]=#13;
    swriteln('');
    sreadlim:=tempstring;
  end;

function ucase(s1: string): string;
var
 s2 : string;
 i1: integer;
begin
 s2:='';
 for i1:=1 to length(s1) do s2:=s2+upcase(s1[i1]);
 ucase:=s2;
end;

function file_exists(s:string):boolean;
var a:text;
begin
  assign(a, s);
  {$I-}
  reset(a);
  {$I+}
  if ioresult <> 0 then file_exists := false else begin close(a); file_exists := true; end;
end;

end.