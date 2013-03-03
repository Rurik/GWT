
{$g+}
program test640x480x16; { mode 12h }
{ Mode 12h putpixel-routine, by Bas van Gaalen, Holland, PD }
uses crt;
const times:longint=50000; {sega000:word=$a000;}
var time:longint absolute $0:$46c; time1,time2,endtime1,endtime2:longint;

procedure setvideo(md:word); assembler; asm
  mov ax,md; int 10h; end;

procedure putpixel(x,y:word; c:byte);
var b:byte;
begin
  port[$3c4]:=2; port[$3c5]:=c;
  b:=mem[sega000:y*80+x shr 3];
  mem[sega000:y*80+x shr 3]:=b or (1 shl (7-(x and 7)));
end;

procedure asmputpix(x,y:word; c:byte); assembler;
asm
  mov dx,03c4h
  mov al,2
  out dx,al
  inc dx
  mov al,[c]
  out dx,al

  mov bx,80
  mov es,sega000
  mov ax,[y]
  mul bx
  mov di,[x]
  shr di,3
  add di,ax
  mov dl,[es:di]

  mov ch,[byte(x)]
  and ch,7
  mov cl,7
  sub cl,ch
  mov ch,1
  shl ch,cl
  or dl,ch
  mov [es:di],dl
end;

procedure clrgraph; assembler;
asm
  mov dx,03c4h
  mov al,2
  out dx,al
  inc dx
  mov al,15
  out dx,al
  mov es,sega000
  xor di,di
  xor ax,ax
  mov cx,80*480/2
  rep stosw
end;

var i:longint;
begin
  setvideo($12);
  randomize;
  time1:=time;
  for i:=1 to times do putpixel(random(640),random(480),random(16));
  endtime1:=time;
  clrgraph;
  time2:=time;
  for i:=1 to times do asmputpix(random(640),random(480),random(16));
  endtime2:=time;
  setvideo(3);
  writeln(time);
  writeln(time);
  writeln(times,' pixels in Pas takes ',((endtime1-time1)/18.2):0:2,' sec');
  writeln(times,' pixels in Asm takes ',((endtime2-time2)/18.2):0:2,' sec');
  repeat until keypressed; while keypressed do readkey;
end.
