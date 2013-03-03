unit routine;
{$F+,O+,V-}
interface
uses ddplus,crt,typedef,beb,pipes,dos,register;
procedure writeline;
function comma:string;
procedure kill(s:string);
procedure makeGwtPlay;
function time:string;
function datenow:string;
function filesizeofdata:longint;
function filesizeofmonster:integer;
procedure swrite_int(i:integer);
procedure printout(txt:string; cr:integer);
procedure EndNow(inplay:boolean);
procedure putplayer(num:word);
procedure getplayer(num:word);
procedure getmonster(number:integer);
procedure LineInput (a:string);
procedure makedot (dots, CR:integer);
procedure scentertext (text:string);
procedure pause;
procedure hPrintOut (text:string; CR:integer);
procedure getscreen (firsttag:string);
procedure MakeScores;
procedure PrintOutTAB (Space:integer; Text:string; CR:integer);
procedure MonstGet;
procedure plotplace(s1,s2,s3:string);
function input(valid:string255):char;
procedure gettrade(a:integer);
procedure puttrade(a:integer);
implementation

procedure gettrade(a:integer);
begin
end;

procedure writeline;
begin
  swriteln('ÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞÞÝÝÞ');
end;

procedure puttrade(a:integer);
begin
end;

function input(valid:string255):char;
var c:char;
    i:integer;
begin
  valid := ucase(valid);
  repeat
    sread_char(c);
    c := upcase(c);
  until pos(c,valid) > 0;
  swrite(c);
  input := c;
end;

procedure plotplace(s1,s2,s3:string);
begin
  spipe(' Locale |07>|08> |11Galactron |03>|09 |12');
  if length(S1)>0 then spipe('|01<|10>|09 '+s1);
  if length(S2)>0 then spipe('|01<|10>|09 '+s2);
  if length(S3)>0 then spipe('|01<|10>|09 '+s3);
  enter;
  spipe('|12 <|04<|12? |04-|12Menu|04>|12> |06Your choice|14, |15');
  swrite((RecStuff.Nam) + ' ');
end;

procedure swrite_int(i:integer);
var s:string;
begin
  s := istr(i);
  swrite(s);
end;

procedure MakeScores;
var bas, basi, basic:text;
    xyz, ls, float, i,leng:integer;
    People:array[1..99] of integer;
    PEx:array[1..99] of longint;
    XXX,dead:string;
begin
  if ansibull then begin
    assign(bas, path + 'GWTScore.Ans');
    rewrite(bas);
  end; {' ANSi Scores}
  if asciibull then begin
    assign(basi, path + 'GWTScore.Txt');
    rewrite(basi);
  end; {' ASCii Scores}
  if rgbull then begin
    assign(basic, path + 'GWTScore.Asc');
    rewrite(basic);
  end; {pipe(|) Scores (for RG)}
  if ansibull then begin
    Writeln(bas, '');
    Writeln(bas, '[255D[36C[0;1;31mGWT Players');
    Writeln(bas, '[14C[30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=',
                 '[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=',
                 '[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=',
                 '[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-');
    Writeln(bas, '[16C[0;31mName[23CExperience[8CStatus');
    Writeln(bas, '[14C[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-',
                 '[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=',
                 '[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=',
                 '[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-[0m=[1;30m-');
  end;
  if asciibull then begin
    Writeln(basi, '');
    Writeln(basi, '                                  GWT Players');
    Writeln(basi, '            -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
    Writeln(basi, '              Name                       Experience          Status');
    Writeln(basi, '            -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
  end;
  if rgbull then begin
    Writeln(basic, '');
    Writeln(basic, '                                  |12GWT Players');
    Writeln(basic, '           |08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-',
                   '|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=',
                   '|08-|07=|08-|07=|08-|07=|08-|07=|08-');
    Writeln(basic, '             |04Name                       Experience         Status');
    Writeln(basic, '           |08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-',
                   '|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=|08-|07=',
                   '|08-|07=|08-|07=|08-|07=|08-|07=|08-');
  end;
  {t := '          \                   \  #############,           \   \'}
  leng := filesizeofdata;
  if leng = 0 then begin
    if ansibull then Writeln(bas, '[1;10m[31CNo players found!');
    if asciibull then Writeln(basi, '                              No players found!');
    if rgbull then Writeln(basic, '                              |10No players found!');
  end;
  FOR i := 1 TO leng do begin
    GETplayer(i);
    PEx[i] := RecStuff.exper;
    People[i] := i;
  end; {for .. i}
  repeat
    float := float + 1;
    FOR i := 1 TO leng - 1 do begin
      if PEx[i] < PEx[i + 1] then begin
         SWAPInt(People[i], People[i + 1]);
         SWAPInt(PEx[i], PEx[i + 1]);
      end;
    end; {for .. i}
  until float = leng;
  Ls := 5;
  FOR i := 1 TO leng do begin
    GETplayer(People[i]);
    if (((RecStuff.Nam)) <> 'X') AND ((RecStuff.Nam) <> '') then begin
      if RecStuff.currenthit <= 0 then dead := ' Dead' ELSE dead := 'Alive';
      if asciibull then Writeln(basi, '    ');
      {*if asciibull then Writeln(basi, USING t$, (RecStuff.Nam), RecStuff.exper, dead);*}
      xyz := 15 - Length(((ISTR(RecStuff.exper)))) - round((Length(((ISTR(RecStuff.exper)))) - 1) / 3);
      XXX:=StringString(Length(((ISTR(RecStuff.exper))))+round((Length(((ISTR(RecStuff.exper))))-1)/3),'#')+',';
      if ansibull then begin
        Writeln(bas, '[16C[1;31m', RecStuff.Nam, SPACE(xyz), '[37m');
        {*Writeln(bas, USING XXX$; RecStuff.exper;*}
        if (dead = ' Dead') and (ansibull) then Writeln(bas, '[10C[0;33mDead');
        if (dead = 'Alive') and (ansibull) then Writeln(bas, '[9CAlive');
      end;
      Ls := Ls + 1;
      if Ls = 24 then begin
        if rgbull then Writeln(basic, '%PA');
        Ls := 0;
      end;
      if rgbull then begin
        Writeln(basic, '             |12',RecStuff.Nam, SPACE(xyz), '|11');
        {*Writeln(basic, USING XXX$; RecStuff.exper;*}
        if dead = ' Dead' then Writeln(basic, '           |04Dead');
        if dead = 'Alive' then Writeln(basic, '          |15Alive');
      end;
    end;
  end; {for .. i}
  if ansibull then begin
    Writeln(bas, '[0m');
    close(bas);
  end;
  if rgbull then if Ls <> 1 then Writeln(basic, '%PA');
  if rgbull then begin Writeln(basic, '|07'); close(basic); end;
  if asciibull then close(basi);
  halt(0);
end;

procedure printout(txt:string; cr:integer);
begin
  if cr=1 then swriteln(txt) else swrite(txt);
end;

function filesizeofdata:longint;
var b:file of recstuf;
begin
  assign(b, 'gwtplay.dat');
  reset(b);
  filesizeofdata:=filesize(b);
  close(b);
end;

procedure EndNow(inplay:boolean);
var we,regt:string;
begin
  if reg then begin
    regt := ' R';
    we := ' ';
  end
  ELSE begin
    regt := 'Unr';
    we := '';
  end;
  set_color(7, 0); Enter;
  spipeln('|15ÚÄÄÄÄÄ|07ÄÄÄ|08ÄÄÄÄÄÄÄÄÄÄÄÄ|07ÄÄÄÄÄÄÄÄ|15ÄÄÄÄÄÄÄ¿');
  spipeln('|07³   |15'+regt + 'egiste'+'|07red versio|08n of GWT! ' + we + '   |07³');
  if not(reg) then spipeln('|07³       |15Get reg|07istered |08quick!|07       ³');
  spipeln('|15ÀÄÄÄÄÄÄÄÄÄ|07ÄÄ|08ÄÄÄÄÄÄÄÄÄÄÄÄÄÄ|07ÄÄÄÄÄ|15ÄÄÄÄÄÙ');
  RecStuff.Lastdate := DateNow;
  if inplay then putplayer(recordnum);
  if (rgbull) OR (ansibull) OR (asciibull) then MakeScores;
  halt;
end;

procedure makeGwtPlay;
var data:file of Recstuf;
begin
  assign(data,'Gwtplay.dat');
  rewrite(data);
  close(data);
end;

procedure getplayer(num:word);
var d:file;
begin
  assign(d, 'gwtplay.dat');
  reset(d,sizeof(recstuf));
  blockread(d, recstuff,num);
  close(d);
end;

procedure putplayer(num:word);
var d:file;
begin
  assign(d, 'gwtplay.dat');
  reset(d,sizeof(recstuf));
  blockwrite(d, recstuff,num);
  close(d);
end;

procedure SCenterText (Text:string);
begin
  sgoto_xy(((80 - length(Text)) div 2),wherey);
  swriteln(Text);
end;

function filesizeofmonster:integer;
begin
  assign(monstdata, 'enemy.dat');
  reset(monstdata);
  filesizeofmonster := filesize(monstdata);
  close(monstdata);
end;

procedure getmonster(number:integer);
var f:file;
begin
  assign(f, 'enemy.dat');
  reset(f);
  seek(f,number);
  close(f);
end;

procedure getscreen (firsttag:string);
var lala:text;
    dumb:string;
    inputc:char;
    c:integer;
begin
Enter;
sclrscr;
assign(lala,'menutxt' + RecStuff.Planet + '.dat');
reset(lala);
repeat
  readln(lala, dumb);
  if eof(lala) then exit;
until dumb = firsttag;

if dumb = firsttag then begin
  repeat
    if not eof(lala) then readln(lala,dumb);
    if inputc = CHR(32) then exit;
    if copy(dumb, 1,1) <> '{' then spipeln(dumb);
  until copy(dumb, 1,1) = '{';
 end
else begin
    swriteln(firsttag + ' missing from menu file!');
  end;
close(lala);
end;

procedure hPrintout(Text:string; CR:integer);
var a:integer;
begin
for a := 1 to length(Text) do begin
  swrite(copy(Text, a, 1));
  delay(Random(1500)+1);
end;
if CR=1 then Enter;
end;

procedure LineInput (a:string);
var l,top,tookin,posi,incount:integer;
    hit:string;
    i:char;
    go_on:boolean;
begin
l := wherex;
posi := l;
top := wherey;
go_on := false;
a := '';
incount := 0;
repeat
  sread_char(i);
  tookin := length(i);
  IF i = CHR(8) THEN begin
    IF incount=1 THEN begin
      IF posi > l THEN begin
        swrite(#8+#32+#8);
        posi := posi - 1;
        incount := incount - 1;
        a := copy(a,1, length(a) - 1);
      END;
    END;
  END;
  IF i = CHR(13) THEN go_on:=TRUE;
  IF i > CHR({&H1F}20) THEN begin
    sgoto_xy(posi, top);
    swrite(i);
    a := a + i;
    incount := incount + tookin;
    posi := posi + 1;
  END;
until go_on;
Enter;
End;

procedure makedot (dots, CR:integer);
var dotme:integer;
begin
for dotme := 1 TO dots do begin
  swrite('.');
  delay(800);
end;
IF CR=1 then Enter;
END;

function comma:string;
var experlen, lengthe:integer;
    exper, first, second, third, fourth, last:string;
begin
  experlen := 13;
  RecStuff.exper := 15000;
  exper := ((ISTR(RecStuff.exper)));
  lengthe := Length(exper);
  CASE lengthe of
    4:begin
      first := Left(exper, 1);
      last := Right(exper, 3);
      exper := first + ',' + last; end;
    5:begin
      first := Left(exper, 2);
      last := Right(exper, 3);
      exper := first + ',' + last; end;
    6:begin
      first := Left(exper, 3);
      last := Right(exper, 3);
      exper := first + ',' + last; end;
    7:begin
      first := Left(exper, 1);
      second := copy(exper, 2, 3);
      last := Right(exper, 3);
      exper := first + ',' + second + ',' + last; end;
    8:begin
      first := Left(exper, 2);
      second := copy(exper, 3, 3);
      last := Right(exper, 3);
      exper := first + ',' + second + ',' + last; end;
    9:begin
      first := Left(exper, 3);
      second := copy(exper, 4, 3);
      last := Right(exper, 3);
      exper := first + ',' + second + ',' + last; end;
    10:begin
      first := Left(exper, 1);
      second := copy(exper, 2, 3);
      third := copy(exper, 5, 3);
      last := Right(exper, 3);
      exper := first + ',' + second + ',' + third + ',' + last; end;
    11:begin
      first := Left(exper, 2);
      second := copy(exper, 3, 3);
      third := copy(exper, 6, 3);
      last := Right(exper, 3);
      exper := first + ',' + second + ',' + third + ',' + last; end;
    12:begin
      first := Left(exper, 3);
      second := copy(exper, 4, 3);
      third := copy(exper, 7, 3);
      last := Right(exper, 3);
      exper := first + ',' + second + ',' + third + ',' + last; end;
    13:begin
      first := Left(exper, 1);
      second := copy(exper, 2, 3);
      third := copy(exper, 5, 3);
      fourth := copy(exper, 8, 3);
      last := Right(exper, 3);
      exper := first + ',' + second + ',' + third + ',' + fourth + ',' + last; end;
  END; {SELECT}
  exper := exper + STRINGstring(experlen - lengthe, #32);
  comma := exper;
end;

procedure MonstGet;
var fff:file of Monsters;
    f:file of Monsters;
    mlevel, rlevel, mlengthg,zx,zxx,Monstflag:integer;
begin
  assign(f, 'Enemy.dat');
  if (not file_exists('enemy.dat')) then begin
    writeln('Enemy.dat cannot be found!  You cannot play without this!');
    halt(1);
  end;
  reset(f);
  mlengthg := filesize(f)-1;
  zx := 0;
  zxx := 0;
  while zx <> mlengthg do begin
    inc(zx);
    seek(f,zx);read(f,Monster);
    mlevel:=ord(Monster.Level);
    rlevel:=ord(RecStuff.Level);
    if MLevel = RLevel then begin
      inc(zxx);
      Monst[zxx] := zx;
    end;
  end;
  CLOSE(f);
  MonstFlag := zxx;
end;

function LZero(w : Word) : String;
var s : String;
begin
  Str(w:0,s);
  if Length(s) = 1 then s := '0' + s;
  LZero := s;
end;

function time:string;
var
  h, m, s, hund : Word;
begin
  GetTime(h,m,s,hund);
  Time := LZero(h)+':'+LZero(m)+':'+LZero(s)+'.'+LZero(hund);
end;

function datenow:string;
var year,day,month,dow:word;
begin
  getdate(year, month, day,dow);
  datenow := LZero(month) + '/' + LZero(day) + '/' + LZero(year);
end;

procedure pause;
var g,y,loop:integer;
    a:char;
begin
  g := (80 - length('<PAUSE>')) div 2;
  set_color(12, 0);
  if wherey > 24 then y := 24 else y := wherey;
  sgoto_xy(g, y);
  spipe('|12<|14PAUSE|12>');
  sread_char(a);
  sgoto_xy(1,wherey);
  for loop := 1 to 70 do swrite(' ');
  sgoto_xy(1,wherey);
end;

(*********************procedure pipe (Text:string; CR:integer);
var tempstr,C2, a:string;
    flag,flag2:boolean;
    code,valtemp,effer:integer;
begin
IF Text = '' then exit;
repeat
  a := copy(Text, 1,1);
  Text := copy(Text, 2, length(text) - 1);
  {Text = RIGHT(Text, length(Text) - 1)}
  IF a <> '|' THEN swrite(a);
  IF a = '|' THEN
  begin
    C2 := copy(text, 1, 2);
    Text := copy(text, 3,length(text) - 2);
    {Text = RIGHT(Text, length(Text) - 2)}
  end;
  val(C2, valtemp,code);
  IF C2 = 'CB' THEN
  begin
    boing := '';
    {effer := length(LTRIM$(RTRIM$(STR$(RecStuff.cashinbank))))}
    str(RecStuff^.cashinbank, tempstr);
    effer := length(tempstr);
    IF round(effer div 3) = effer div 3 THEN
    begin
      effer := (effer + round(effer div 3) - 1);
    end
    ELSE
    begin
      effer := (effer + round(effer div 3));
    end;
    boing := stringstring(effer, '#');
    boing := boing + ',';
    set_color(8,0); swrite('c'); set_color(7, 0);
    {this below goes above
    ** PrintOutUSING boing$, RecStuff.cashinbank; : PrintOutSPACE$(15 - length(boing$));}
  end;
  IF C2 = 'CH' THEN
  begin
    boing := '';
    str(RecStuff^.CashOnHand, tempstr);
    effer := length(tempstr);
    IF round(effer div 3) = effer div 3 THEN
    begin
      effer := (effer + round(effer div 3) - 1);
    end
    ELSE
    begin
      effer := (effer + round(effer div 3));
    end;
    boing := stringstring(effer, '#');
    boing := boing + ',';
    set_color(8, 0); swrite('c'); set_color(7,0);
    {This below goes above
    ** PrintOutUSING boing$; RecStuff.cashonhand; : PrintOutSPACE$(15 - length(boing$));}
  IF C2 = 'HN' THEN
  begin
    str(RecStuff^.totalhit - RecStuff^.currentHit, tempstr);
    swrite(tempstr);
    flag2:=true;
  end;
  IF C2 = 'HC' THEN
  begin
    swrite('25');
    flag2:=TRUE;
  end;
  {str(val(C2), tempstr);}
  if copy(C2, length(c2), 1) = copy(tempstr,length({tempstr}C2), 1) THEN
  {IF RIGHT$(C2$, 1) = RIGHT$(tempstr,length(tempstr), 1) THEN}
    IF (valtemp < 16) AND (valtemp > -1) THEN
    begin
      set_color(valtemp,0);
      flag2:=TRUE;
    IF (valtemp > 15) AND (valtemp < 24) THEN
    begin
      flag2:=TRUE;
      str(valtemp, C2);
      set_color(0, valtemp);
    end;
   if not flag2 then swrite(C2);
  End;
  IF Text = '' THEN flag := TRUE;
  end;
until flag;
{set_color(-1,0);}
set_color(7, 0);
IF CR = 1 THEN Enter;
End;*************)

procedure kill(s:string);
var f:file;
begin
  if file_exists(s) then begin
    assign(f,s);
    erase(f);
  end;
end;

procedure PrintOutTAB (Space:integer; Text:string; CR:integer);
begin
  if space >= wherex then Enter;
  sgoto_xy(Space, wherey);
  swrite(Text);
  if CR=1 then Enter;
End;
end.