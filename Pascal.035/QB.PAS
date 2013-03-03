unit qb;
{$O+}
{$V-}
{$F+}

interface
  uses dos, crt;
  type string255=string[255];
{New}
  function ltrim(s:string):string;
  function Rtrim(s:string):string;
  procedure beep;
  function spc(a:integer):string;
  procedure name(f1,f2:string);
  procedure mid(var s1:string; start,len:integer; s2:string);
  function len(s:string):integer;
  function ATN(degrees:real):real;
  function csrlin:byte;
  function time:string;
  function Date:string;
  function SGN(i:integer):integer;
  procedure cls;
  procedure color(fore, back:word);
  procedure locate(y,x:integer);
{ENd}
  function ASC(c:char):integer;
  function left(s:string; num:integer):string;
  function Right(s:string; num:integer):string;
  function value(s:string): integer;
  function space(a:integer): string;
  function ISTR(number:integer): string;
  function stringstring(length:integer; text:char): string;
  procedure swapint(i1, i2:longint);
  procedure swap(i1, i2:string);
  function ucase(s1:string): string;
  function lcase(s:string): string;
implementation
{New}

function time:string;
var
  h, m, s, hund : Word;

  function LeadingZero(w : Word) : String;
  var
    s : String;
  begin
    Str(w:0,s);
    if Length(s) = 1 then s := '0' + s;
    LeadingZero := s;
  end;
begin
  GetTime(h,m,s,hund);
  time := LeadingZero(h)+':'+LeadingZero(m)+':'+LeadingZero(s){+'.'+LeadingZero(hund)};
end;

function spc(a:integer):string;
begin
  spc := space(a);
end;

function SGN(i:integer):integer;
begin
  if i < 0 then SGN := -1
    else if i = 0 then SGN := 0
    else if i > 0 then SGN := 1;
end;

function ltrim(s:string):string;
var l:integer;
    t:string;
begin
  l:=1;
  while (s[l] = ' ')or(s[l]=#0) do inc(l);
  t := copy(s, l, length(s));
  ltrim := t;
end;

function rtrim(s:string):string;
var l:integer;
    t:string;
begin
  l:=length(s);
  while (s[l] = ' ')or(s[l]=#0) do dec(l);
  t := copy(s, 0, l);
  rtrim := t;
end;

procedure name(f1,f2:string);
var f:file;
begin
  assign(f,f1);
  Rename(f,f2);
end;

function len(s:string):integer;
begin
  len := length(s);
end;

procedure mid(var s1:string; start,len:integer; s2:string);
var l:integer;
begin
  for l := start to len do s1[l] := s2[l];
end;

procedure color(fore, back:word);
begin
  textcolor(fore);
  textbackground(back);
end;

procedure locate(y,x:integer);
{Uses the old MicroSoft fucked up graphing standards}
begin
  gotoxy(x,y);
end;

procedure cls; begin clrscr; end;

procedure beep;
begin
  sound(50);
  delay(10);
  nosound;
end;

function Date:string;
var
  y, m, d, dow : Word;
begin
  GetDate(y,m,d,dow);
  Date := istr(m)+'/'+istr(d)+'/'+istr(y);
end;

function csrlin:byte; begin csrlin := wherey; end;

function ATN(degrees:real):real;
begin
  ATN := degrees * (pi / 180);
end;
{EnD}

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

function lcase(s:string):string;
var t:string;
    l:integer;
begin
  t :='';
  for l := 1 to length(s) do t[l] := locase(s[l]);
  lcase := t;
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
  s:='';
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
        #8:if length(tempstring)>=1 then
             begin
               delete(tempstring,length(tempstring),1);
               write(#8+#32+#8);
             end else
               begin
                 sound(1000);
                 delay(500);
                 nosound;
               end;
        else if length(tempstring)<=len then
          begin
            tempstring:=tempstring+out[1];
            write(out[1]);
          end else
            begin
              sound(1000);
              delay(500);
              nosound;
            end;
      end;
    until out[1]=#13;
    writeln;
    readlim:=tempstring;
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

function ASC(c:char):integer;
begin
  ASC := ord(c);
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