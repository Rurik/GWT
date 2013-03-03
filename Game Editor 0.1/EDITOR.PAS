PROGRAM editor;

uses crt;
TYPE
 t_email = record
  Nam:string[20]; {who sent it}
  Flag:integer;    {dah.. figure it out yerself}
  msg:string[70]; {msg line}
 end;
 t_WepArm = record
  Nam:string[15];
  Cost:longint;
  Much:integer;
 end;
 t_Trade = record
  Nam:string[15];
  Cost:longint;
  Much:integer;
  Flag:byte;
 end;
 t_Cave = record
  Nam:string[50];
  Lastdate:string[6];
  Bless:byte;
 end;

function tab(a:integer):string;
begin
gotoxy(a,wherey);
tab := '';
end;

function space(a:integer): string;
 var s:string;loop:integer;
begin
 s:='';
 for loop:= 1 to a do s:=s+' ';
 space:=s;
end;

procedure centertext(s:string);
begin
 gotoxy(((80 - length(s)) div 2),wherey);
 writeln(s);
end;

function left(s:string; num:integer):string;
begin
left := copy(s, 1, num);
end;

function right(s:string; num:integer):string;
begin
right := copy(s, (length(s) - num+1), num);
end;

function mid(s1:string; start,len:integer):string;
var l:integer;s2:string;
begin
s2 := '';
for l := 0 to len-1 do s2 := s2 + s1[start+l];
mid := s2;
end;

function ucase(s:string):string;
var
  i : Integer;
begin
for i := 1 to Length(s) do s[i] := UpCase(s[i]);
ucase := s;
end;



procedure player_proc(choice:string);

TYPE
 t_player = record
  Nam:string[21];       {User's Player Name}
  RNam:string[50];   {Real Name of User (unused)}
  Pword:string[10];  {Users Password}
  Level:byte;  {Short int (unused)}
  Gems:byte;  {# of gems as Short Int}
  Race:char;   {# or A in string format}
  Job:char;    {# in string format}
  currenthit:integer;    {Hitpoints left}
  totalhit:integer;      {Total Hitpoints}
  exper:longint;         {Experience}
  cashonhand:longint;     { $$$ in your hands}
  cashinbank:longint;     { $$$ in the bank}
  Attacks:integer;        {Used for battle}
  Defences:integer;     {this has to be done later}
  SeenMaster:byte;   {boolean (unused)}
  WeaponN:string[15];   {Weapon Name}
  WeaponC:longint;       { $ received if weapon is sold}
  WeaponS:integer;       {Strength deducted if weapon is sold}
  ArmorN:string[15];    {Armor Name}
  ArmorC:longint;       { $ received if armor is sold}
  ArmorD:integer;       {Defence deducted if armor is sold}
  FightLeft:byte;  {Arena Fights left - short int}
  TotalFight:byte; {Total Arena Fights per day - short int}
  Playerkills:integer;   {# of players user killed (unused)}
  Sex:byte;        {1 if male 0 if female}
  lastdate:string[6];   {date of last played}
  wongame:byte;    {# of times won - short int (unused)}
  LockFights:byte; {fights in locker}
  Trip:byte;       {Did I trip bellgirl? 1 = YES 0 = huh?}
  Flirt:byte;      {Did I flirt? 1 = YES 0 = huh?}
  SFans:byte;      {Did I kill fans? 1 = YES 0 = huh?}
  Expert:byte;     {Expert Mode On 1 = Yes!}
  Blank:string[20];  {For the future... part of magic shop (unused)}
  Affect:byte;     {ditto (unused)}
  Much:longint;             {ditto (unused)}
  SeenM:byte;      {Seen Master Today (unused)}
  Sleeper:byte;    {Where sleeping (unused)}
  Planet:byte;     {Planet}
 end;
 t_playfile = file of t_player;

var playfile:t_playfile;
    playrecord:t_player;
    recordnum,leng:integer;
    raceS,jobS,sexS,dateonS,sfS,trS,flS:string;
    prompt:char;

procedure write_player(recnum:integer);forward;
procedure close_player;forward;
procedure open_player;forward;
procedure playedit;forward;
procedure read_player(recnum:integer);forward;
procedure packuser;forward;

procedure playedit;
label main;

procedure adduser;forward;


procedure race;
begin
writeln('1) Humanoid');
writeln('2) Cyborg');
writeln('3) Amphibian');
writeln('4) Alien');
writeln('5) Android');
writeln('6) Quadruped');
writeln('7) Arachnid');
writeln('8) Mutant');
writeln('9) Crossbreed');
writeln('0) Telepath');
writeln('A) Parasite');
writeln;
write('Enter Race: ');playrecord.race := readkey;writeln;
case playrecord.race of
 '0'..'9':exit;
 'A','a':exit;
end;
 race;
end;

procedure job;
begin
writeln('1) Sniper');
writeln('2) GWT Officer');
writeln('3) Mercenary');
writeln('4) Bounty Hunter');
writeln('5) Navigator');
writeln('6) IP Diplomatic');
writeln('7) Student');
writeln('8) Arena Fighter');
writeln('9) Self Employed');
writeln;
write('Enter Job: ');playrecord.job := readkey;
writeln;
case playrecord.job of
 '1'..'9': exit;
end;
 job;
end;


procedure adduser;
var dateonS,sexS:string;
begin
write('Enter Name: ');
readln(playrecord.nam);
write('Enter Attack: ');
readln(playrecord.attacks);
write('Enter Password: ');
readln(playrecord.pword);
write('Enter Gold on Hand: ');
readln(playrecord.cashonhand);
write('Enter Gold in Bank: ');
readln(playrecord.cashinbank);
write('Enter Race: ');
race;
write('Enter Job: ');
job;
write('Enter Current Hitpoints: ');
readln(playrecord.currenthit);
write('Enter Total Hitpoints: ');
readln(playrecord.totalhit);
write('Enter Defences: ');
readln(playrecord.defences);
write('Enter Exp: ');
readln(playrecord.exper);
write('Enter last played date: ');
readln(dateonS);
playrecord.lastdate := left(dateonS,2)+mid(dateonS,4,2)+
                       right(dateonS,2);
write('Enter Gems: ');
readln(playrecord.gems);
write('Enter Sex(M/f): ');
readln(sexS);
if left(ucase(sexS),1) = 'M' then playrecord.sex := 1 else
                                  playrecord.sex := 0;
recordnum := leng;
write_player(recordnum);
end;


begin
recordnum := 0;
main:
leng := filesize(playfile);
if recordnum > leng-1 then recordnum := 0;
if recordnum < 0 then recordnum := leng-1;
read_player(recordnum);
clrscr;
writeln('   User #',recordnum);
writeln('0) Real Name: ',playrecord.rnam);
write('1) Name: ',playrecord.nam);
gotoxy(40,wherey);
writeln('2) Password: ',playrecord.pword);
write('3) Attack: ',playrecord.attacks);
gotoxy(40,wherey);
writeln('4) Defences: ',playrecord.defences);
write('5) Weapon Name: ',playrecord.weaponN);
gotoxy(40,wherey);
writeln('6) Armor Name: ',playrecord.armorN);
write('7) Gold on Hand: ',playrecord.cashonhand);
gotoxy(40,wherey);
writeln('8 Gold in Bank: ',playrecord.cashinbank);
case playrecord.race of
 '1': raceS := 'Humanoid';
 '2': raceS := 'Cyborg';
 '3': raceS := 'Amphibian';
 '4': raceS := 'Alien';
 '5': raceS := 'Android';
 '6': raceS := 'Quadruped';
 '7': raceS := 'Arachnid';
 '8': raceS := 'Mutant';
 '9': raceS := 'Crossbreed';
 '0': raceS := 'Telepath';
 'A','a': raceS := 'Parasite';
end;
write('9) Race: ',raceS);
case playrecord.job of
 '1': jobS := 'Sniper';
 '2': jobS := 'GWT Officer';
 '3': jobS := 'Mercenary';
 '4': jobS := 'Bounty Hunter';
 '5': jobS := 'Navigator';
 '6': jobS := 'IP Diplomatic';
 '7': jobS := 'Student';
 '8': jobS := 'Arena Fighter';
 '9': jobS := 'Self Employed';
end;
gotoxy(40,wherey);
writeln('A) Job: ',jobS);
write('B) Hitpoints: ',playrecord.currenthit,'/',
                         playrecord.totalhit);
gotoxy(40,wherey);
writeln('C) Exp: ',playrecord.exper);
if playrecord.sex = 1 then sexS := 'Male' else sexS := 'Female';
write('D) Sex: ',sexS);
dateonS := left(playrecord.lastdate,2)+'/'+mid(playrecord.lastdate,
           3,2)+'/'+right(playrecord.lastdate,2);
gotoxy(40,wherey);
writeln('E) Last Played: ',dateonS);
write('F) Gems: ',playrecord.gems);
gotoxy(40,wherey);
writeln('G) Fights In Locker: ',playrecord.lockfights);
write('H) Level: ',playrecord.level);
if playrecord.sfans = 1 then sfS := 'Yes' else sfS := 'No';
if playrecord.trip = 1 then trS := 'Yes' else trS := 'No';
if playrecord.flirt = 1 then flS := 'Yes' else flS := 'No';
gotoxy(40,wherey);
writeln('I) Slaughtered Fan: ', sfS);
write('J) Tripped Bell-Boy: ',trS);
gotoxy(40,wherey);
writeln('K) Flirted: ',flS);
writeln;
writeln('X to Delete, Q to Quit, [ Backward, ] forwards, + to Add',
        ' player');
write('Enter Command: ');
prompt := upcase(readkey);
writeln;
case prompt of
 '[':
      begin;
      recordnum := recordnum - 1;
      goto main;
      end;
 ']':
     begin
      recordnum := recordnum + 1;
      goto main;
     end;
 '0':
     begin
      write('Enter Real Name: ');
      readln(playrecord.rnam);
      write_player(recordnum);
      goto main;
     end;
 '1':
     begin
      write('Enter Name: ');
      readln(playrecord.nam);
      write_player(recordnum);
      goto main;
     end;
 '2':
     begin
      write('Enter Password: ');
      readln(playrecord.pword);
      write_player(recordnum);
      goto main;
     end;
 '3':
     begin
      write('Enter Attack: ');
      readln(playrecord.attacks);
      write_player(recordnum);
      goto main;
     end;
 '4':
     begin
      write('Enter Defences: ');
      readln(playrecord.defences);
      write_player(recordnum);
      goto main;
     end;
 '5':
     begin
      write('Enter Weapon Name: ');
      readln(playrecord.weaponN);
      write_player(recordnum);
      goto main;
     end;
 '6':
     begin
      write('Enter Armor Name: ');
      readln(playrecord.armorN);
      write_player(recordnum);
      goto main;
     end;
 '7':
     begin
      write('Enter Gold on Hand: ');
      readln(playrecord.cashonhand);
      write_player(recordnum);
      goto main;
     end;
 '8':
     begin
      write('Enter Gold in Bank: ');
      readln(playrecord.cashinbank);
      write_player(recordnum);
      goto main;
     end;
 '9':
     begin
      race;
      write_player(recordnum);
      goto main;
     end;
 'A':
     begin
      job;
      write_player(recordnum);
      goto main;
     end;
 'B':
     begin
      write('Enter Current Hitpoints: ');
      readln(playrecord.currenthit);
      write('Enter Total Hitpoints: ');
      readln(playrecord.totalhit);
      write_player(recordnum);
      goto main;
     end;
 'C':
     begin
      write('Enter Exp: ');
      readln(playrecord.exper);
      write_player(recordnum);
      goto main;
     end;
 'D':
     begin
      if playrecord.sex = 1 then playrecord.sex := 0 else
         playrecord.sex := 1;
      write_player(recordnum);
      goto main;
     end;
 'E':
     begin
      write('Enter last played date: ');
      readln(dateonS);
      playrecord.lastdate := left(dateonS,2)+mid(dateonS,4,2)+
                             right(dateonS,2);
      write_player(recordnum);
      goto main;
     end;
 'F':
     begin
      write('Enter Gems:');
      readln(playrecord.gems);
      write_player(recordnum);
      goto main;
     end;
 'G':
     begin
      write('Enter Fights In Locker: ');
      readln(playrecord.lockfights);
      write_player(recordnum);
      goto main;
     end;
 'H':
     begin
      write('Enter Level: ');
      readln(playrecord.level);
      write_player(recordnum);
      goto main;
     end;
 'I':
     begin
      if playrecord.sfans = 1 then playrecord.sfans := 0 else
         playrecord.sfans := 1;
      write_player(recordnum);
      goto main;
     end;
 'J':
     begin
      if playrecord.trip = 1 then playrecord.trip := 0 else
         playrecord.trip := 1;
      write_player(recordnum);
      goto main;
     end;
 'K':
     begin
      if playrecord.flirt = 1 then playrecord.flirt := 0 else
         playrecord.flirt := 1;
      write_player(recordnum);
      goto main;
     end;
 'X':
     begin
      playrecord.nam := 'X';
      write_player(recordnum);
      goto main;
     end;
 'Q': exit;
 '+':
     begin
      adduser;
      goto main;
     end;

 end;
end;

procedure open_player;
begin
assign(playfile,'gwtplay.dat');
reset(playfile);
end;

procedure close_player;
begin
close(playfile);
end;

procedure write_player(recnum:integer);
begin
seek(playfile,recnum);
write(playfile,playrecord);
end;

procedure read_player(recnum:integer);
begin
seek(playfile,recnum);
read(playfile,playrecord);
end;

procedure packuser;
var
 temp_f:t_playfile;
 l:integer;
 f:file;
 c:char;

label packmain,endofthis;
begin
assign(temp_f,'x1.x1x');
rewrite(temp_f);
clrscr;
writeln;writeln;writeln;writeln('Packing player file....');
recordnum := 0;
leng := filesize(playfile);
packmain:
if recordnum > leng-1 then goto endofthis;
read_player(recordnum);
recordnum := recordnum + 1;
if playrecord.nam = 'X' then goto packmain;
l := l + 1;
write(temp_f,playrecord);
goto packmain;
endofthis:
close(temp_f);
assign(f,'gwtplay.dat');
erase(f);
assign(f,'x1.x1x');
rename(f,'gwtplay.dat');
writeln('Done....');
c := readkey;
end;

begin
open_player;
if choice = 'edit' then playedit;
if choice = 'pack' then packuser;
{more options}
close_player;
end;

procedure monsteredit;

type
 t_monster = record
  Level:byte;      {Level}
  Nam:string[15];       {Name}
  Sex:byte;        {1 = Male 0 = Female}
  Attack:integer;        {Attack strength}
  Health:integer;        {Hitpoints}
  Gold:longint;             {Gold you get if win}
  say:array[1..4] of string[75];  {Sayings (random)}
  Weapon:string[15];    {Weapon}
 end;
 t_monsterfile = file of t_monster;

var monstfile:t_monsterfile;
    monstrecord:t_monster;
    lvl,highlvl,sd,mleng:byte;
begin
{lvl:=1;
assign(monstfile,'enemy.dat');
reset(monstfile);
highlvl :=1;
for sd := 0 to filesize(monstfile)-1 do
 begin
  seek(monstfile,sd);
  read(monstfile,monstrecord);
  if monstrecord.level > highlvl then highlvl := monstrecord.level;
 end;
if lvl > highlvl then lvl :=1;
if lvl < 1 then lvl := highlvl;
if lvl < 1 then lvl := 1;
textcolor(2);
mleng := filesize(monstfile);
for zx := 0 to mleng-1 do
 begin
  seek(monstfile,zx);
  read(monstfile,monstrecord);
  if monstrecord.level = lvl then
   zxx := zxx + 1;}


end;

var b:char;
label maindisplay;

begin
maindisplay:
clrscr;textcolor(9);
writeln('-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-',
        '=-=-=-=-=-=-=-=-=-=-=-=-=-');
textcolor(10);
centertext('Galactic Warrior Tournament Editor');
centertext('By the programmers of GWT');
centertext('Brian Baskin, Jeff Biermann, and Geoff Rivell');
gotoxy(1,10);textcolor(9);
write(tab(20),'[');textcolor(10);write('P');textcolor(9);
write(']layer Editor');write(tab(45),'[');textcolor(10);
write('M');textcolor(9);writeln(']onster Editor');textcolor(9);
write(tab(20),'[');textcolor(10);write('!');textcolor(9);
write(']Pack User File');write(tab(45),'[');textcolor(10);
write('Q');textcolor(9);writeln(']uit');
gotoxy(26,14);write('Your choice, effendi:');
b := readkey;
case b of
 'P','p': player_proc('edit');
 'M','m': write;
 '!': player_proc('pack');
 'Q','q':exit;
end;
goto maindisplay;

end.