unit screen3;
{$F+,O+,V-}
interface
procedure SendEMail;
procedure chat;
procedure Tower;
procedure IGM;
procedure tradeweapon;
procedure tradeshield;
procedure UserBattle (Usernam:string; UserHit, UserAttacks, UserDefences:integer; UserWeapon:string; UserEXP, UserRecord,
                      UserCash:integer);
procedure Trip (ParagraphPick:integer);
procedure sgotoxy(YRol, XCol:integer; Text:string; CR, LocalPrint:integer);
procedure RealGuy(var a:integer; Lin:array of string; bok:array of char; blok:array of integer);
procedure ByeByeFans;
procedure printout(txt:string; cr:integer);
implementation

uses dos,ddplus,beb,routine,typedef,pipes,qb,register;
type txt=record
   g:char;
   end;

var leng:integer;

procedure chat;
var startin,Cool, Cool2, QwErTy, Kool,NoConvo, i, marker, a, m, R:integer;
    an:char;
    xyzf:file of byte;
    temp, xyz:text;
    GetIt:array[0..25] of string;
    by, msg:array[0..13] of string;
    thismsg:string;
    label Createchat;
begin
  NoConvo := 0; i := 0; marker := 0; a := 0; m := 0; R := 1;
  assign(xyz, 'convo.txt');
  assign(xyzf, 'convo.txt');
  reset(xyz);
  if filesize(xyzf) = 0 then begin
    NoConvo := 1;
    close(xyz);
    erase(xyz);
    GOTO createchat;
  end;
  close(xyz);
  reset(xyz);
  repeat
    a := a + 1;
    readln(xyz, getit[a]);
  UNTIL EOF(xyz);
  close(xyz);
  if round(a div 2) <> a div 2 then begin
    erase(xyz);
    a := 0;
    sclrscr;
    NoConvo := 1;
    GOTO createchat;
  end;
  FOR i := 1 TO a do begin
    if round(i / 2) <> i / 2 then by[R] := GetIt[i];
    if round(i / 2) = i / 2 then msg[R] := GetIt[i];
    R := R + 1;
  end;
  R := R - 1;
  sclrscr;
  set_color(15, 0);
  spipe('                            Ú|07');
  spipe('[|11Player Conversations|07');
  spipe(']|15¿|08');
  spipe('ÚÄÄÄÄÄÄÄ|07ÄÄÄÄÄÄÄÄÄÄÄÄÄ|15ÄÄÄÄÄÄÄÙ|08');
  spipe('ÄÄÄÄÄÄÄÄ|07ÄÄÄÄÄÄÄÄ|15ÄÄÄÄÄÄÙ|08');
  spipe('ÄÄÄÄÄÄÄÄ|07ÄÄÄÄÄÄÄÄÄ|15ÄÄÄÄÄÄÄÄ¿');
  FOR m := 1 TO R do begin
    set_color(8, 0);
    spipe('³|15  ÚÄ|07');
    spipe('ÄÄÄ|08');
    spipe('Ä[|11');
    swrite((by[m]));
    spipe('|08]');
    Kool := 78 - (length((by[m])) + 12);
    set_color(15, 0);
    swriteln(Space(Kool)+'³');
    set_color(7, 0);
    spipe('ÀÄ|15ÄÁ|07');
    spipe('Ä|08[|09');
    swrite(msg[m]);
    spipe('|08]');
    Cool := 78 - (length(msg[m]) + 7) - 1;
    Cool2 := Cool div 3;
    Cool := Cool - Cool2;
    set_color(8, 0);
    FOR QwErTy := 1 TO Cool2 do swrite('Ä');
    Cool2 := Cool div 2;
    Cool := Cool - Cool2;
    set_color(7, 0);
    FOR QwErTy := 1 TO Cool2 do swrite('Ä');
    set_color(15, 0);
    FOR QwErTy := 1 TO Cool do swrite('Ä');
    if m <> R then swrite('´');
    if m = R then swrite('Ù');
  end;
  Enter;
  set_color(7, 0);
  spipe('(|08A|07)|08dd to List or |15(|07ENTER|15)|07 to continue|15: ');
  an := input('a'+#13);
  if an = 'A' then GOTO createchat;
  if an = CHR(13) then exit;
  chat;

  createchat:
  set_color(9, 0);
  Enter; swrite('Enter the message:'); set_color(11, 0);
  LineInput (thismsg{,-1, 20});
  if length(thismsg) > 65 then GOTO createchat;
  if (round(a div 2) <> a div 2) OR (NoConvo = 1) then begin
    assign(xyz, 'convo.txt');
    rewrite(xyz);
    writeln(xyz, RecStuff.Nam);
    writeln(xyz, thismsg);
    close(xyz);
  end
  ELSE begin
    assign(temp, 'convo.tmp');
    rewrite(temp);
    if R > 9 then startin := 2 ELSE startin := 1;
    FOR m := startin TO R do begin
      writeln(temp, by[m]);
      writeln(temp, msg[m]);
    end;
    writeln(temp, RecStuff.Nam);
    writeln(temp, thismsg);
    close(temp);
    close(xyz);
    erase(xyz);
    rename(temp, 'convo.txt');
  end;
end; {Chat}

procedure sgotoxy(YRol, XCol:integer; Text:string; CR, LocalPrint:integer);
begin
  sgoto_xy(XCol,YRol);
  if cr = 1 then swriteln(text) else swrite(Text);
end;

procedure printout(txt:string; cr:integer);
begin
  if cr=1 then swriteln(txt);
  if cr<>1 then swrite(txt);
end;

procedure ByeByeFans;
var exitproc:boolean;
    fudge, darn,fannies:integer;
    gen:string;
    f:char;
begin
  IF RecStuff.SFans = true then begin
    swriteln('You have had your chance already!');
    pause;
    exitproc:=true;
  end;
  sclrscr;
  set_color(8, 0);
  Scentertext('Slaughtering Fans');
  RANDOMIZE;
  fannies := round(random(4) + 1);
  if fannies = 1 then begin
    printout('   You see an old woman hobble onto the Arena looking confused and', 1);
    printout('upset.  She continually whispers, "poo-poo.... poo-poooo". You can', 1);
    printout('only imagine she must be looking for her poodle. You believe that', 1);
    printout('she will make a good target.', 1);
    pause;
    gen := 'her';
  end;
  if fannies = 2 then begin
    printout('   You see one fan up in a tree watching the fights. He''s wearing', 1);
    printout('torn clothes and looks sickly. You hear a cracking sound as a branch', 1);
    printout('breaks and he falls to your feet.', 1);
    pause;
    gen := 'him';
  end;
  if fannies = 3 then begin
    printout('   A drunken man hobbling down the steps of the surrounding half', 1);
    printout('stadium and trips on an unseen beer can. He soars through the air', 1);
    printout('and lands face first onto the dirt floor of the Arena.', 1);
    pause;
    gen := 'him';
  end;
  if fannies = 4 then begin
    printout('   You wait in the Arena for a target to come into your sight, but you', 1);
    printout('cannot find anyone. Immpatiently you relieve the gate of its lock with', 1);
    printout('your ' + (RecStuff.WeaponN) + ' and proceed into a crowd of fans. Dragging a fan from ', 1);
    printout('the crowd was easier than you thought.', 1);
    pause;
    gen := 'him'
  end;
  repeat
    Enter;
    printout('You can either (K)ill ' + gen + ', or (C)hicken out!', 1);
    SRead_Char(f);
  until f in ['K','k','C','c'];
  if f = 'K' then begin
    fudge := Round(random(round((RecStuff.cashonhand + RecStuff.cashinbank) * 0.2)));
    printout('You easily kill ' + gen + ', and in ' + gen + ' pockets you find' + ISTR(fudge) + 'in creds.', 1);
    RecStuff.cashonhand := RecStuff.cashonhand + fudge;
    pause;
    if Round(random * 4) + 1 = 1 then begin
      darn := Round(random * ORD(RecStuff.FightLeft)) + 1;
      printout('   As you turn around you notice a crowd of angry fans charging toward you.', 1);
      printout('You realize there is no where to run so you rap your arms around your ', 1);
      printout('head and fall to the ground. You''re beaten unconscious and miss' + ISTR(darn), 1);
      printout('of your fights.', 1);
      RecStuff.FightLeft := (RecStuff.FightLeft) - darn;
      pause;
    end;
  end;
  if f = 'C' then begin
    printout('''bock bock bock bock ''CHICKEN!!!!!!!!!!!!!!!!''', 1);
    pause;
  end;
  RecStuff.SFans := true;
end;

procedure IGM;
var as:array[1..500] of string[80];
    descr:array[1..{250}10] of string;
    files:array[1..{250}10] of string;
    igmbat, outigm:text;
    xyzc:file of txt;
    b,des,nam:string;
    i,total,a,r,e:integer;
    xyz:text;
    label igmstart;
begin
  sclrscr;
  Putplayer(recordnum);
  assign(outigm, 'out.igm');
  reset(outigm);
  readln(outigm, des);
  readln(outigm, Nam);
  close(outigm);
  erase(outigm);
  assign(igmbat, 'igm.bat');
  if file_exists('igm.bat') then erase(igmbat);
  if (RecStuff.Lastdate = DateNow) AND (RecStuff.currenthit <= 0) then begin
    sclrscr;
    writeln('H:',recstuff.currenthit,' Date:',Recstuff.lastdate);
    set_color(9, 0); printout('You are dead for today.', 1);
    pause;
    Endnow(true);
  end;
  assign(xyzc, 'igm.dat');
  rewrite(xyzc);
  if filesize(xyzc) = 0 then begin
    CLOSE(xyzc);
    erase(xyzc);
    printout('No IGM''s!', 1);
    pause;
    exit;
  end
  else CLOSE(xyzc);
  assign(xyz, 'igm.dat');
  reset(xyz);
  repeat
    e := e + 1;
    readln(xyz, as[e]);
  UNTIL EOF(xyz);
  if Round(e / 2) <> e / 2 then begin
    sclrscr;
    swriteln('IGM.DAT is messed up!');
    CLOSE(xyz);
    pause;
    exit;
  end;
  repeat
    igmstart:
    sclrscr;
    total := 0;
    a := 0;
    FOR i := 1 TO e do begin
      if (as[i] = '') or (copy(as[i],1,1) = ';') then begin
        R := R + 1;
        if a = 0 then a := 1 ELSE a := 0;
        if a = 1 then begin
          descr[R] := as[i];
          total := total + 1;
          spipeln('|08(|10'+ISTR(total)+'|08)|02'+descr[R]);
        end;
        if a = 0 then files[R] := as[i];
      end;
    end;
    Enter;
    set_color(2, 0);
    printout('Enter; Command (Q)uit: ',0);
    LineInput(b);
  until b <> '';
  if UCASE(b) = 'Q' then begin
    CLOSE(xyz);
    exit;
  end;
  if value(b) < 1 then GOTO igmstart;
  if value(b) > total then GOTO igmstart;
  CLOSE(xyz);
  assign(igmbat, 'igm.bat');
  rewrite(igmbat);
  writeln(igmbat, files[value(b) * 2]);
  writeln(igmbat, 'GWT.BAT');
  CLOSE(igmbat);
  assign(outigm, 'out.igm');
  rewrite(outigm);
  writeln(outigm, descr[value(b)]);
  writeln(outigm, RecStuff.Nam);
  close(outigm);
  halt(1);  {Exit to the calling BATCH file to run iGM}
end;

procedure SendEMail;
var Lin:array[1..100] of STRING;
    bok:array[1..80] of char;
    Blok:array[1..80] of INTEGER;
    loco2,locol2,doo,locolold,locold,loco,locol,a:integer;
    er,name:string;
    FE,YN:char;
    xyz:file of emails;
    label Looking,Found;
begin
sclrscr;
set_color(7, 0);
swrite('Send; e-mail to who? ');
lineinput(Name);
set_color(9, 0);
printout('ÚÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄ¿', 1);
printout('³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³', 1);
printout('ÃÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ´', 1);
printout('³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³', 1);
printout('ÃÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ´', 1);
printout('³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³', 1);
printout('ÃÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ´', 1);
printout('³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³', 1);
printout('ÀÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÙ', 1);
Putplayer(recordnum);
leng := filesizeofdata;
FOR a := 1 TO leng do
begin
Looking:
  if a > leng then EXIT;
  locol := (a div leng * 40) div 1 - 1;
  loco := (locol div 10);
  if locol > 9 then locol := locol - loco * 10;
  set_color(12, 0);
  sgoto_xy(3 + (loco * 2), 2 + (locol * 2));
  write('Û');
  if a <> 1 then begin
    set_color(8, 0);
    sgoto_xy(3 + (locold * 2), 2 + (locolold * 2));
    write('Û');
  end;
  Getplayer(a);
  FOR doo := 1 TO length(UCASE((RecStuff.Nam))) - length(UCASE(Name)) + 1 do begin
    if UCASE(Name) = copy(UCASE((RecStuff.Nam)), doo, length(UCASE(Name))) then GOTO Found;
  end;
  locold := loco;
  locolold := locol;
  if a > leng then EXIT;
end;
  set_color(8, 0);
  sgoto_xy(3 + (locold * 2), 2 + (locolold * 2));
  swrite('Û');
  set_color(7, 0);
  sgoto_xy(11, 1);
  printout('Don''t see ''em here!', 1);
  CLOSE(xyz);
  pause;
  Getplayer(recordnum);
  exit;

Found:
set_color(12, 0);
sgoto_xy(2 + (loco * 2), 1 + (locol * 2));
swrite('ÚÁ¿');
sgoto_xy(3 + (loco * 2), 1 + (locol * 2));
swrite('´ÛÃ');
sgoto_xy(4 + (loco * 2), 1 + (locol * 2));
swrite('ÀÂÙ');
FOR locol2 := 1 TO locol * 2 do
begin
 sgoto_xy(3 + (loco * 2), locol2);
 swrite('Ä');
end;
FOR locol2 := locol * 2 + 4 TO 21 do
begin
  sgoto_xy(3 + (loco * 2), locol2);
  swrite('Ä');
end;
FOR loco2 := 2 TO loco * 2 + 1 do
begin
  sgoto_xy(loco2, locol * 2 + 2);
  swrite('³');
end;
FOR loco2 := (loco * 2) + 5 TO 10 do
begin
  sgoto_xy(loco2, locol * 2 + 2);
  swrite('³');
end;
set_color(7, 0);
sgoto_xy(11, 1);
swrite(' Found: ' + (RecStuff.Nam));
swriteln(' Sector: ' + ((ISTR(locol + 1))) + ', ' + ((ISTR(loco + 1))));
GETplayer(a);
printout('Is this who you''re looking for(Y/n)?', 0);
SRead_Char(YN);
if YN = 'N' then
begin
  a := a + 1;
  set_color(7, 0);
  sgoto_xy(2 + (loco * 2), 1 + (locol * 2));
  swrite('ÚÁ¿');
  sgoto_xy(3 + (loco * 2), 1 + (locol * 2));
  swrite('´');
  set_color(3, 0);
  printout('Û', 0); set_color(7, 0); printout('Ã', 0);
  sgoto_xy(4 + (loco * 2), 1 + (locol * 2));
  swrite('ÀÂÙ');
  FOR locol2 := 1 TO locol * 2 do begin
    sgoto_xy(3 + (loco * 2), locol2);
    swrite('Ä');
  end;
  FOR locol2 := locol * 2 + 4 TO 21 do begin
    sgoto_xy(3 + (loco * 2), locol2);
    swrite('Ä');
   end;
  FOR loco2 := 2 TO loco * 2 + 1 do begin
    sgoto_xy(loco2, locol * 2 + 2);
    swrite('³');
  end;
  FOR loco2 := (loco * 2) + 5 TO 10 do begin
    sgoto_xy(loco2, locol * 2 + 2);
    swrite('³');
  end;
  sgoto_xy(11, 1);
  swriteln(SPACE(70));
  swriteln(SPACE(70)); swriteln(SPACE(70)); swriteln(SPACE(70));
  swriteln(SPACE(70)); swriteln(SPACE(70)); swriteln(SPACE(70)); swriteln(SPACE(70));
  GOTO Looking;
end;
er := ucase((RecStuff.Nam));
getplayer(recordnum);
if er = ucase((RecStuff.Nam)) then begin
  printout(' Please don''t write to yourself, its just not normal!', 1);
  CLOSE(xyz);
  pause;
end;
RealGuy(a,Lin,bok,blok);
exit;
end;

procedure RealGuy(var a:integer; Lin:array of string; bok:array of char; blok:array of integer);
var filenam:string;
    man,xlin, wa, we, liner, eleng:integer;
    ef,c:char;
    ss:string;
    xyz:file of emails;
    label flip;

procedure redraw;
var a,b:integer;
begin
  FOR a := 1 TO 5 do begin
    FOR b := 1 TO 16 do begin
      set_color(Blok[(a - 1) * 16] + b, 0);
      sgoto_xy(a, b);
      swrite(bok[((a - 1) * 16)] + istr(b));
    end;
  end;
end;

begin
  getplayer(recordnum);
  filenam := 'mail' + ((ISTR(a))) + '.DAT';
  assign(emailfile,filenam);
  eleng := filesize(emailfile);
  set_color(15,0);
  sclrscr;
  Enter;
  printout('    Enter the e-mail. Hit Esc for commands.', 1);
  printout('    Up to 100 lines. (pipe colors can be used):', 1);
  email.Nam := RecStuff.Nam;
  Liner := 1;
  set_color(1,0);
  printout('    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿', 1);
  set_color(9, 0); sgoto_xy(0, 5); swrite('³'); set_color(15,0);
  swrite(Lin[Liner] + space(70 - length(Lin[Liner])));
  set_color(9, 0); swrite('³');
  while true do begin
    sread_char(c);
    ss := c;
    if c = CHR(8) then begin
      if length(Lin[Liner]) > 0 then Lin[Liner] := Left(Lin[Liner], length(Lin[Liner]) - 1);
      set_color(9, 0);
      sgoto_xy(0, 5);
      swrite('³');
      set_color(15, 0);
      swrite(Lin[Liner] + space(70 - length(Lin[Liner])));
      set_color(9, 0);
      swrite('³');
      GOTO Flip
    end;
    if c = CHR(9) then ss :='   ';
    if c = CHR(13) then begin
      set_color(1, 0);
      sgoto_xy(0, 5);
      swrite('³'); set_color(7, 0);
      swrite(Lin[Liner] + space(70 - length(Lin[Liner])));
      set_color(1, 0); swrite('³');
      if Liner <> 100 then begin
        Liner := Liner + 1;
        Enter;
      end;
      set_color(9, 0); sgoto_xy(0, 5); swrite('³'); set_color(15, 0); printout(Lin[Liner] + space(70 - length(Lin[Liner])), 0);
      set_color(9, 0); printout('³', 0);
      GOTO Flip
    end;
    if c = CHR(27) then begin
      xlin := CSRLIN;
      FOR wa := 1 TO 5 do begin
        FOR we := 1 TO 16 do begin
          (*********bok[((wa - 1) * 16) + we] := CHR(SCREEN(wa, we));
          Blok[((wa - 1) * 16) + we] := SCREEN(wa, we, 1);******)
        end;
      end;
      sgoto_xy(1, 1); swrite('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      sgoto_xy(2, 1); swrite('³(A)bort Mail  ³');
      sgoto_xy(3, 1); swrite('³(S)ave Mail   ³');
      sgoto_xy(4, 1); swrite('³(Enter)Nothing³');
      sgoto_xy(5, 1); swrite('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
      sread_char(ef);
      if ef = 'S' then begin
        redraw;
        set_color(1, 0);
        sgoto_xy(xlin, 5);
        swrite('³');
        set_color(7, 0);
        printout(Lin[Liner] + space(70 - length(Lin[Liner])), 0);
        set_color(1, 0);
        printout('³', 0);
        Liner := Liner + 1;
        EXIT;
      end;
      if ef = 'A' then begin
        redraw;
        CLOSE(xyz);
        exit;
      end;
      redraw;
      set_color(9, 0); sgotoxy(xlin, 5, '³', 0, 1); set_color(15, 0); printout(Lin[Liner] + space(70 - length(Lin[Liner])), 0);
      set_color(9, 0); printout('³', 0);
      GOTO Flip;
    end;
    if c <> '' then begin
      if ORD(c) < 32 then SS := '';
      if length(Lin[Liner]) <> 70 then Lin[Liner] := Lin[Liner] + SS;
      set_color(9, 0); sgotoxy(0, 5, '³', 0, 0); set_color(15, 0); printout(Lin[Liner] + space(70 - length(Lin[Liner])), 0);
      set_color(9, 0); printout('³', 0);
    end;
  end; {while loop}
  Flip:
  set_color(1, 0);
  sgoto_xy(xlin + 1, 5);
  swriteln('    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
  FOR man := 1 TO Liner - 1 do begin
    email.msg := Lin[man];
    if man = Liner - 1 then email.Flag := 0 ELSE email.Flag := 1;
    seek(xyz,eleng+man);
    write(xyz,email);
  end;
  CLOSE(xyz);
end;

procedure Tower;
var up:integer;
    i:char;
(********************************)
procedure jumpofftower;
var die:char;
begin
  set_color(4, 0);
  printout('  Are you sure you would like to commit suicide and start over??', 0);
  SRead_Char(die);
  die := upcase(die);
  if die = 'Y' then begin
    printout(' OK... you glance over the edge of the railing and watch the dark clouds swirl', 1);
    printout(' into a dark vortex.  Taking a deep breath, to step forward, and gravity yanks', 1);
    printout(' you down into the clouds. The wind blows through your hair, and for a single', 1);
    printout(' moment, you feel at peace with the world.', 0);
    makedot(10, 0);
    printout(' then you hit the ground!', 1);
    RecStuff.RNam := 'X';
    pause;
  end;
end;
(*********************************)
procedure throwrox;
var didithit:integer;
label endofnow;
begin
  if RecStuff.ThrewRox then begin
    swriteln('There are no more rocks left!');
    pause;
    goto endofnow;
  end;
  RecStuff.ThrewRox := true;
  didithit := Round(random * (1) + 1);
  printout(' You notice a pile of large rocks in the corner.  You firmly grasp one, and walk towards', 1);
  printout(' the edge of the tower.  Lifting the rock over your head, you throw it down towards into', 1);
  printout(' clouds.', 0); makedot(10, 0);
  if didithit = 1 then
    printout('  BOOM!  You hear the crash, and a loud scream!', 1)
  else
    printout('  BOOM!  You hear a crash.', 1);
  RecStuff.ThrewRox := true;
  pause;
endofnow:
end;
(*****************************************)
procedure hitsomeone;
var healdown,a:integer;
    sex:string;
label getauser;
begin
  Putplayer(recordnum);
  leng := filesizeofdata;
  getauser:
  a := Round(random * (leng - 1) + 1);
  if a = recordnum then GOTO getauser;
  getplayer(a);
  if RecStuff.Sex = '1' then Sex := 'him' ELSE Sex := 'her';
  printout(' As you walk away from the tower, you notice a small figure bleeding on the', 1);
  printout(' ground. Walking closer, you find ' + (RecStuff.Nam) + ' crouched over.', 1);
  printout(' Beside ' + Sex + ' You notice the large rock that you had thrown from the', 1);
  printout(' tower. Chuckling, you turn around and run away!', 1);
  RecStuff.currenthit := RecStuff.currenthit - healdown;
  putplayer(a);
  getplayer(recordnum);
  pause;
end;
(**********************************************)
procedure climbdowntower;
var hplost:integer;
begin
  set_color(6, 0);
  hplost := RecStuff.currenthit div 2;
  printout(' You hang over the edge of the tower, and grasp onto the ladder.  You start your', 1);
  printout(' way down the ladder.', 0); makedot(6, 0); printout('Whew, you think you can make it the whole way!', 1);
  printout(' About halfway down, your arms stiffen, and you fall off!', 0); makedot(10, 1);
  printout(' You groan and lift yourself off the ground. You are bleeding everywhere, though', 1);
  printout(' you''re still alive!  You notice that in the fall you lost ' + ISTR(hplost) + ' hitpoints! ', 1);
  RecStuff.currenthit := RecStuff.currenthit - hplost;
  if RecStuff.ThrewRox then hitsomeone;
  pause;
End;
(*****************************************)
procedure elevator;
begin
  hprintout(' HAHA, Cheater!  Now you will DIE HAHA... uhhh. nah, I''ll let you go -=]', 1);
  hprintout(' You climb into a small box in the corner, tap a blue button on the side', 1);
  hprintout(' then the box closes up, and drops downwards through the tower.', 0);
  makedot(7, 1);
  hprintout(' The box hits the ground with a painful thump, and you crawl out.  The box', 1);
  hprintout(' immediately returns to the roof.', 1);
  if RecStuff.ThrewRox then hitsomeone;
  pause;
end;
(*****************************************)
procedure citymap;
begin
  getscreen('{CITYMAP}');
  pause;
end;
(*****************************************)
begin
up := Round(random * (5) + 1);
if up > 3 then begin
  set_color(3, 0);
  printout('   You grasp onto the ladder, and start your way up the tower.', 0);
  makedot(5, 1);
  printout(' Whew, it''s a long way up there!', 0);
  makedot (4, 0);
  printout(' Your arms are starting to weaken!', 1);
  printout(' You finally see the top ahead!', 0);
  makedot (3, 0);
  printout('Ut oh!, Your arms are too tired!', 1);
  printout(' You cannot go any farther.  You glance down at the clouds below you as your', 1);
  printout(' arms fall from the ladder!', 0);
  makedot(8, 1);
  set_color(4, 0);
  Scentertext('You lose a lot of hitpoints!');
  RecStuff.currenthit := 1;
  pause;
  Exit;
end
ELSE begin
  set_color(13, 0);
  printout('   You grasp onto the ladder, and start your way up the tower.', 0); makedot (5, 1);
  printout(' Whew, it''s a long way up there!', 0); makedot(4, 0); printout(' Your arms are starting to weaken!', 1);
  printout(' You finally see the top ahead!', 0); makedot(3, 0); printout('Ut oh!  You don''t think you can make it!', 1);
  printout(' With your last bit of strength, you pull yourself onto the top of the tower,', 1);
  printout(' and crawl towards the small hut on top.', 1);
end;
pause;
repeat
  getscreen('{TOWER}');
  SRead_Char(i);
  i := upcase(i);
  if i = 'J' then jumpofftower;
  if i = 'C' then climbdowntower;
  if i = 'þ' then elevator; {-=<********CHEAT HEHEHE********>=-}
  if i = 'L' then citymap;
  if i = 'T' then throwrox;
until upcase(i) in ['ÿ'];
end;

procedure TradeShield;
var temp,over2,over,tradelen,newlen,wek:integer;
    FE,key:char;
label tradeend2,tradestart2;

procedure TradeList2;
var wewe,butt,loop:integer;
    endstr,fe:string;
    extracost:longint;
begin
  Butt := 0;
  Enter;
  FOR loop := 1 TO TradeLen do begin
    GETtrade(loop);
    if Trade.Flag = 'S' then begin
      Butt := Butt + 1;
      printout('<' + ISTR(Butt) + '> ' + Trade.Nam, 0);
      if Trade.Much > RecStuff.ArmorD then printout(
      ' +' + ISTR(Round(Trade.Cost * (((Trade.Much - RecStuff.ArmorD) / Trade.Much) * (Over2 / 4)))), 1);
    end
    ELSE
      Enter;
  end;
  Enter;
  if newlen > 0 then
    printout(' Hit 1 to' + ISTR(newlen) + ' for shield trading. Enter; for nothing', 1)
  ELSE begin
    printout('Sorry, our trading stand isn''t really doing that well!', 1);
    pause;
  end;
  if newlen > 0 then begin
    set_color(15, 0);
    Enter;
    LineInput(FE{, 1, Butt% + 4 + 16}); (*16 = menu length*)
    FE := ucase(FE);
    Butt := 0;
    if (value(FE) > 0) AND (value(FE) <= newlen) then begin
      FOR wewe := 1 TO TradeLen do begin
        GetTrade(wewe);
        if Trade.Flag = 'S' then Butt := Butt + 1;
        if Butt = value(FE) then EXIT;
      end;
    end;
    Enter;
    if Trade.Much > 0 then ExtraCost := Round(Trade.Cost * (((Trade.Much - RecStuff.ArmorD) / Trade.Much) * (Over2 / 4)));
    if RecStuff.cashonhand >= ExtraCost then begin
      if Trade.Much > RecStuff.ArmorD then begin
         RecStuff.cashonhand := RecStuff.cashonhand - ExtraCost;
         printout(' ' + ((ISTR(ExtraCost))) + ' credits were charged for the upgrade.', 1);
      end;
    end;
    if RecStuff.ArmorD > 0 then begin
      TradeLen := TradeLen + 1;
      GETTrade(TradeLen);
      Trade.Nam := RecStuff.ArmorN;
      Trade.Flag := 'S';
      Trade.Cost := RecStuff.ArmorC * 2;
      Trade.Much := RecStuff.ArmorD;
      PUTTrade(TradeLen);
      printout(' Weapon traded in.', 1);
    end
    else begin
      newlen := newlen - 1;
      RecStuff.Attacks := RecStuff.Attacks - RecStuff.ArmorD;
      GETTrade(wewe);
      RecStuff.ArmorN := Trade.Nam;
      printout(' You recieve a(n) ' + Trade.Nam, 1);
      RecStuff.ArmorC := Trade.Cost div 2;
    if RecStuff.ArmorD > Trade.Much then endstr := ' lost ' + ((ISTR(RecStuff.ArmorD - Trade.Much))) +
       ' points of attack strength.'
    ELSE endstr := ' gained ' + ((ISTR(Trade.Much - RecStuff.ArmorD))) +  ' points of attack strength.';
    if RecStuff.ArmorD = Trade.Much then begin
      endstr := ' neither gained nor lost any points of attack strength.';
      RecStuff.ArmorD := Trade.Much;
      RecStuff.Attacks := RecStuff.Attacks + RecStuff.ArmorD;
      printout(' You have' + endstr, 1);
      Trade.Nam := ' ';
      Trade.Flag := 'X';
      Trade.Cost := 0;
      Trade.Much := 0;
      PUTTrade(wewe);
      pause;
    end
    ELSE
      printout(' Stupid! Get some more money!', 1);
    end;
  end
  ELSE
    if (value(FE) < 0) OR (value(FE) > newlen) then printout(' Idiot! Pick one that''s there!', 1);
wek:=loop;
end;

begin
  assign(tradefre, 'Trade.Dat');
  TradeLen := filesize(TradeFre);
  newlen := 0;
  FOR wek := 1 TO TradeLen do begin
    getTrade(wek);
    if Trade.Flag = 'S' then newlen := newlen + 1;
  end;
  Over := newlen;
  if Over > 15 then Over := 15;
  Over := 15 - Over;
  Over2 := (Over div 15) * 4;
  if Over2 < 1 then Over2 := 1;

TradeStart2:
  if RecStuff.Expert = false then getscreen('{TRADEARMOR}');
  if temp = 1 then begin getscreen('{TRADEARMOR}'); temp := 0; end;
  plotplace('Trader''s Corner','Shield Trading','');
  SRead_Char(Key);
  Key := upcase(Key);
  if Key = 'L' then TradeList2;
  if Key = '?' then begin temp := 1; GOTO TradeStart2; end;
  if (Key = 'R') OR (ORD(Key)= 13) then GOto Tradeend2;
  if Key = 'E' then RecStuff.Expert := not(RecStuff.Expert);
GOTO TradeStart2;

Tradeend2:
  if RecStuff.ArmorD > 0 then begin
    Enter;
    printout('    As you are about to leave an old man walks up to you and says, "Tell ya', 1);
   printout(' what, I''ll take that shield o'' yours for ' +
            (ISTR(Round(RecStuff.ArmorC * ((Over div 15*1) + 0.5)))) + '!"', 1);
    printout('    "Well, yes or no???(y/N)" ', 1);
    SRead_Char(FE);
    FE := upcase(FE);
    if FE = 'Y' then begin
      GETTrade(TradeLen + 1);
      Trade.Nam := RecStuff.ArmorN;
      Trade.Much := RecStuff.ArmorD;
      Trade.Cost := RecStuff.ArmorC * 2;
      Trade.Flag := 'S';
      PUTTrade(TradeLen + 1);
      RecStuff.cashonhand := RecStuff.cashonhand + Round(RecStuff.ArmorC * ((Over / 15 * 1)+0.5));
      RecStuff.Attacks := RecStuff.Attacks - RecStuff.ArmorD;
      RecStuff.ArmorN := 'Skin';
      RecStuff.ArmorD := 0;
      RecStuff.ArmorC := 0;
    end;
    CLOSE(TradeFre);
  end;
end;

procedure TradeWeapon;
var temp,over2,over,tradelen, newlen, wek:integer;
    key:char;
label tradestart;

procedure TradeList;
var wewe,butt,wek:integer;
    endstr,fe:string;
    ExtraCost:longint;
begin
Butt := 0;
Enter;
FOR wek := 1 TO TradeLen do begin
  GETTrade(wek);
  if Trade.Flag = 'W' then begin
    Butt := Butt + 1;
    printout('<' + ISTR(Butt) + '> ' + Trade.Nam, 0);
    if Trade.Much > RecStuff.WeaponS then
      printout(' +' + ISTR(Round(Trade.Cost * (((Trade.Much - RecStuff.WeaponS) / Trade.Much) * (Over2 / 4)))), 1)
    ELSE
      Enter;
  end;
end;
Enter;
printout(' Hit 1 to' + ISTR(newlen) + 'for weapon trading. Enter; for nothing', 1);
if newlen > 0 then
  set_color(15, 0);
  Enter;
  plotplace('Trader''s Corner','Weapon Trading','List');
  LineInput(FE{, 15 + length(RecStuff.Nam), 22});
  FE := ucase(FE);
  Butt := 0;
  if (value(FE) > 0) AND (value(FE) <= newlen) then
    FOR wewe := 1 TO TradeLen do begin
      GetTrade(wewe);
      if Trade.Flag = 'W' then Butt := Butt + 1;
      if Butt = value(FE) then EXIT;
    end;
  Enter;
  ExtraCost := Round(Trade.Cost * (((Trade.Much - RecStuff.WeaponS) / Trade.Much) * (Over2 / 4)));
  if RecStuff.cashonhand >= ExtraCost then begin
    if Trade.Much > RecStuff.WeaponS then begin
       RecStuff.cashonhand := RecStuff.cashonhand - ExtraCost;
       printout(' ' + ((ISTR(ExtraCost))) + ' credits were charged for the upgrade.', 1);
    end;
    TradeLen := TradeLen + 1;
    GetTrade(TradeLen);
    Trade.Nam := RecStuff.WeaponN;
    Trade.Flag := 'W';
    Trade.Cost := RecStuff.WeaponC * 2;
    Trade.Much := RecStuff.WeaponS;
    PutTrade(TradeLen);
    printout(' Weapon traded in.', 1);
    RecStuff.Attacks := RecStuff.Attacks - RecStuff.WeaponS;
    GetTrade(wewe);
    RecStuff.WeaponN := Trade.Nam;
    printout(' You recieve a(n) ' + Trade.Nam, 1);
    RecStuff.WeaponC := Trade.Cost div 2;
    if RecStuff.WeaponS > Trade.Much then
      endstr := ' lost ' + ((ISTR(RecStuff.WeaponS - Trade.Much))) + ' points of attack strength.'
      ELSE endstr := ' gained ' + ((ISTR(Trade.Much - RecStuff.WeaponS))) +  ' points of attack strength.';
    if RecStuff.WeaponS = Trade.Much then endstr := ' neither gained nor lost any points of attack strength.';
    RecStuff.WeaponS := Trade.Much;
    RecStuff.Attacks := RecStuff.Attacks + RecStuff.WeaponS;
    printout(' You have' + endstr, 1);
     Trade.Nam := ' '; {***********}
     Trade.Flag := 'X';
     Trade.Cost := 0;
     Trade.Much := 0;
    PutTrade(wewe);
    end
  ELSE if RecStuff.cashonhand < ExtraCost then
    printout(' Stupid! Get some more money!', 1)
  ELSE
    if (value(FE) < 0) OR (value(FE) > newlen) then printout(' Idiot! Pick one that''s there!', 1);
end; {procedure Tradelist}

procedure Tradeend;
var FE:char;
begin
  if RecStuff.WeaponS > 0 then begin
    Enter;
    printout('    As you are about to leave an old man walks up to you and says, ' + CHR(34) + 'Tell ya', 1);
    printout(' what, I''ll take that weapon o'' yours for ' + ISTR(Round(RecStuff.WeaponC * (0.5 + (Over div 15 * 1)))) +
             '!' + CHR(34), 1);
    printout('    ' + CHR(34) + 'Well, yes or no???(y/N)' + CHR(34) + ' ', 0);
    repeat
      SRead_Char(FE);
    until upcase(FE) in ['Y', 'N'];
    if upcase(FE) = 'Y' then begin
      GetTrade(TradeLen+1);
      Trade.Nam := RecStuff.WeaponN;
      Trade.Much := RecStuff.WeaponS;
      Trade.Cost := RecStuff.WeaponC * 2;
      Trade.Flag := 'W';
      PutTrade(TradeLen+1);
      RecStuff.cashonhand := RecStuff.cashonhand + Round(RecStuff.WeaponC * (0.5 + (Over div 15 * 1)));
      RecStuff.Attacks := RecStuff.Attacks - RecStuff.WeaponS;
      RecStuff.WeaponN := 'Hands';
      RecStuff.WeaponS := 0;
      RecStuff.WeaponC := 0;
    end;
  CLOSE(TradeFre);
  end;
end;

begin
  assign(tradefre, 'Trade.Dat');
  TradeLen := filesize(TradeFre);
  newlen := 0;
  FOR wek := 1 TO TradeLen do begin
    GETTrade(wek);
    if Trade.Flag = 'W' then newlen := newlen + 1;
  end;
  Over := newlen;
  if Over > 15 then Over := 15;
  Over := 15 - Over;
  Over2 := (Over div 15) * 4;
  if Over2 < 1 then Over2 := 1;

TradeStart:
if RecStuff.Expert =false then getscreen('{TRADEWEAPON}');
if temp = 1 then getscreen('{TRADEWEAPON}');temp := 0;
plotplace('Trader''s Corner','Weapon Trading','');
SRead_Char(Key);
Key := upcase(Key);
if Key = 'L' then TradeList;
if (Key = 'R') OR (ORD(Key) = 13) then Tradeend;
if Key = 'E' then RecStuff.Expert := not(RecStuff.Expert);
GOTO TradeStart;
end;

procedure Trip (ParagraphPick:integer);
var randomgold, tripornottotrip,randomexp, a:integer;
    woman:string;
label inputtrip;
begin
  if RecStuff.Trip then printout('Leave the poor bellboy alone!', 1); pause;
  if RecStuff.Trip =false then begin
    RecStuff.Trip := true;
    sclrscr;
    Enter;
    inputtrip:
    set_color(8, 0);
    sgoto_xy(2, 0);
    Scentertext('That idiot bellboy!');
    set_color(9, 0);
    Scentertext('*--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--*');
    FOR a := 1 TO 3 do Enter;
      printout('   You sit behind a corner and wait for the bellboy to appear...', 0);
      makedot(5, 0);
      set_color(Round(random * 15) + 1, 0);
      printout(' Here he comes!  And carrying a huge stack of electro-cases in his arms.', 1);
      printout(' You nonchalantly stick your leg out behind you as the boy approaches. ', 1);
      printout(' Let''s see if he `falls` for it! ...', 0);
      makedot(5, 0);
      randomexp := Round(random * (RecStuff.exper + (RecStuff.exper * 0.2)) + RecStuff.exper * 0.2);
      tripornottotrip := Round(random * (3 - 1) + 1);
      if ParagraphPick = 1 then woman := 'the beautiful desk worker';
      if ParagraphPick <> 1 then woman := 'the old woman behind the bar';
      If tripornottotrip = 1 then begin
        set_color(Round(random * 15) + 1, 0);
        printout(' You hear a loud crash!  He fell for it!!!  Every electro-suitcase flys', 1);
        printout(' out of his arms and scatter across the floor.  The young bellboy', 1);
        printout(' falls face forward into the crotch of ' + woman + '!', 1);
        printout(' You cry out laughing as the boy tries to stand up off his knees.', 1);
        pause;
        if ParagraphPick = 1 then begin
          set_color(Round(random * 15) + 1, 0);
          printout(' The Beautiful woman backhands the boy, and pushes him away!', 1);
          printout(' She stands up, walks over to you, and slaps you across the face, too.', 1);
          printout(' Oh man!  You just lost' + ISTR(randomexp) + 'experience!', 1);
          RecStuff.exper := RecStuff.exper - randomexp;
          pause;
        end
        ELSE if ParagraphPick <> 1 then begin
          set_color(Round(random * 15) + 1, 0);
          printout(' The old woman rubs her hands through his hair in glee!', 1);
          printout(' You crack up laughing as the boys pulls away from her!', 1);
          printout(' What a laugh!  You receive' + ISTR(randomexp) + ' experience!', 1);
          RecStuff.exper := RecStuff.exper + randomexp;
          pause;
        end;
      end;
     if tripornottotrip <> 1 then begin
       set_color(Round(random * 15) + 1, 0);
       printout(' You hear a loud crash! Except it wasn''t the bellboy that fell for it!', 1);
       printout(' It was ' + woman + ' who had triped over your leg!  Uh oh!', 1);
       pause;
       if ParagraphPick = 1 then begin
         set_color(Round(random * 15) + 1, 0);
         printout(' A huge man from the back rushes to save the beautiful woman.  She', 1);
         printout(' thanks him.  He walks towards you and pulls out a vibrogun.  Two', 1);
         printout(' shots are enough to put you dead on the floor.  (i.e. you have died!)', 1);
         RecStuff.currenthit := 0;
         pause;
         endnow(true);
       end
       ELSE begin
         set_color(Round(random * 15) + 1, 0);
         printout(' A small man from the back rushes to save the old lady.  She thanks', 1);
         printout(' him and stands up.  He rushes towards you and pushes you down, while', 1);
         if RecStuff.cashonhand > 0 then begin
           randomgold := Round(random * RecStuff.cashonhand);
           printout(' snabbing ' + ISTR(randomgold) + ' gold out of your pockets', 1);
           RecStuff.cashonhand := RecStuff.cashonhand - randomgold;
           pause;
         end
         ELSE begin
           a := Round(random * RecStuff.currenthit);
           printout(' hurting you for ' + ISTR(a) + ' hitpoints!', 1);
           RecStuff.currenthit := RecStuff.currenthit - a;
           pause;
         end;
       end;
    end;
  end;
end;

procedure UserBattle (Usernam:string; UserHit, UserAttacks, UserDefences:integer; UserWeapon:string; UserEXP,
                      UserRecord, UserCash:integer);
var PlayAttack, MonstAttack:integer;
begin
  PlayAttack := Round(random * (RecStuff.Attacks * 2)) - Round(random * UserDefences);
  Monstattack := Round(random * (UserAttacks * 2)) - Round(random * RecStuff.Defences);
  sclrscr;
  sgoto_xy(10, 1);
  iF PlayAttack = Monstattack then begin
    set_color(10, 0);
    printout('No one wins this round.', 1);
    set_color(12, 0);
  end
  else if PlayAttack > Monstattack then begin
    set_color(10,0);
    printout('You deal ',0);
    set_color(9,0);
    printout(Usernam,0);
    set_color(10,0);
    printout(' a blow!', 1);
    PlayAttack := ABS(PlayAttack);
    if PlayAttack > UserHit then PlayAttack := UserHit;
    UserHit := UserHit - PlayAttack;
    set_color(9,0);
    printout('He''s down to ' + ISTR(UserHit) + ' hitpoints after you took ' + ISTR(PlayAttack) + ' hitpoints away.', 1);
  end
  else if PlayAttack < Monstattack then begin
    set_color(9,0);
    printout('You have been wounded!', 1);
    set_color(10,0); printout(Usernam,0); set_color(9,0);
    printout(' hits you with its ' + UserWeapon, 1);
    Monstattack := ABS(Monstattack);
    if Monstattack > RecStuff.currenthit then Monstattack := RecStuff.currenthit;
    RecStuff.currenthit := RecStuff.currenthit - Monstattack;
    printout('You lost' + ISTR(Monstattack) + ' hitpoints. You are down to' + ISTR(RecStuff.currenthit) +
             ' hitpoints.', 1);
  end;
  pause;
  sclrscr;
  sgoto_xy(10, 1);
  if (RecStuff.currenthit > 0) AND (UserHit <= 0) then begin
    printout('You won the fight! You found' + ISTR(UserCash) + 'pieces of gold!', 1);
    RecStuff.cashonhand := RecStuff.cashonhand + UserCash;
    RecStuff.exper := RecStuff.exper + Round(UserEXP div 4);
    Putplayer(recordnum);
    getplayer(UserRecord);
    RecStuff.cashonhand := 0;
    RecStuff.exper := RecStuff.exper - Round(RecStuff.exper div 4);
    RecStuff.currenthit := 0;
    Putplayer(UserRecord);
    getplayer(recordnum);
    pause;
    exit;
  end
  ELSE if (UserHit > 0) AND (RecStuff.currenthit < 1) then begin
    sclrscr;
    printout(Usernam + ' killed you!', 1);
    RecStuff.currenthit := 0;
    RecStuff.Lastdate := DateNow;
    printout('Game over!', 1);
    RecStuff.cashonhand := 0;
    pause;
    endnow(true);
  end;
end;

end.