unit screen2;
{$F+,O+,V-}
interface
  procedure EMailReply(Num, Point1, Point2:integer;s:string);
  procedure cram;
  procedure CheckEMail;
  procedure Healers;
  procedure listarmor;
  procedure buyweapon;
  procedure listweapon;
  procedure buyarmor;
  procedure Flirt (ParagraphPick:integer);
  procedure NotInstalled;
  procedure listplayer;
  procedure CheckTemp;
  procedure GetAway;
  procedure PlayerDat;
  procedure Battlemonster;
implementation
uses crt,dos,ddplus,typedef,routine,beb,screen3,pipes,qb,register;

procedure Cram;
var redeemval,saveval,decompval, compval,code,temp,doodoo:integer;
    lockerin:char;
    redeem, save,decomp,comp:string;
begin
  doodoo := 0;
  if RecStuff.cashonhand <> 0 then doodoo := doodoo + 1;
  if ord(RecStuff.LockFights) <> 0 then doodoo := doodoo + 1;
  if RecStuff.FightLeft <> 0 then doodoo := doodoo + 1;
  if RecStuff.Expert = false then getscreen('{LOCKER}');
  if temp = 1 then begin
    getscreen('{LOCKER}');
    temp := 0;
  end;
  set_color(15, 0);
  Enter;
  plotplace('Arena','Locker','');
  Lockerin := input('ecdsrq');
  if Lockerin = 'E' then RecStuff.Expert := Not(RecStuff.Expert);
  if Lockerin = 'C' then begin
    Enter;
    swrite(' Enter the amount to compile - '); LineInput(Comp{, 31, 2});
{    comp := value(comp);}
    if (Comp = #0) OR (Comp = '') then begin
      Enter;
      swrite(' Nothing Done!');
      pause;
      Cram;
    end;
    if (Comp < #1) then begin
      Enter;
      swrite(' Negative and non-numeric amounts are illegal!');
      pause;
      Cram;
    end;
    if (Comp > chr(RecStuff.cashonhand)) then begin
      Enter;
      swrite(' Credit batch too large!');
      pause;
      Cram;
    end;
    val(Comp, Compval, code);
    RecStuff.cashonhand := RecStuff.cashonhand - Compval;
    RecStuff.CashInBank := RecStuff.CashInBank + Compval;
    Enter;
    swrite(' Compilation Complete!');
    pause;
  end;
  if Lockerin = 'D' then begin
    Enter;
    swrite(' Enter the amount to decompile - '); LineInput(DeComp{, 33, 24});
    val(decomp, decompval, code);
    if (DeCompval = 0) OR (DeComp ='' ) then begin
      Enter;
      swrite(' Nothing Done!');
      pause;
      Cram;
    end;
    if (DeCompval < 1) then begin
      Enter;
      swrite(' Negative and non-numeric amounts are illegal!');
      pause;
      Cram;
    end;
    if (DeCompval > RecStuff.CashInBank) then begin
      Enter;
      swrite(' Credit batch too large!');
      pause;
      Cram;
    end;
    RecStuff.cashonhand := RecStuff.cashonhand + DeCompval;
    RecStuff.CashInBank := RecStuff.CashInBank - DeCompval;
    Enter;
    swrite(' Decompilation Complete!');
    pause;
  end;
  if Lockerin = 'S' then begin
    Enter;
    swrite(' EnTer the amount to save - ');
    LineInput(Save{, 29, 24});
    if (Save = CHR(0)) OR (Save = '') then begin
      Enter;
      swrite(' Nothing Done!');
      pause;
      Cram;
    end;
    if (Save < CHR(1)) then begin
      Enter;
      swrite(' Negative and non-numeric amounts are illegal!');
      pause;
      Cram;
    end;
    val(save, saveval, code);
    if saveVAL > RecStuff.FightLeft then begin
      Enter;
      swrite(' You don''t have that many on you!');
      pause;
      Cram;
    end;
    if saveVAL + ord(RecStuff.LockFights) > 255 then begin
      Enter;
      swrite(' You can only save 255 fights!');
      pause;
      Cram;
    end;
    RecStuff.FightLeft := ((RecStuff.FightLeft) - saveVAL);
    RecStuff.LockFights := ((RecStuff.LockFights) + saveVAL);
    Enter;
    swrite(' Storage Complete!');
    pause
  end;
  if Lockerin = 'R' then begin
    Enter;
    swrite(' Enter the amount to redeem - ');
    LineInput(Redeem{, 31, 24});
    val(redeem, redeemval, code);
    if (Redeemval = 0) OR (Redeem = '') then begin
      Enter;
      swrite(' Nothing Done!');
      pause;
      Cram;
    end;
    if Redeemval < 1 then begin
      Enter;
      swrite(' Negative and non-numeric amounts are illegal!');
      pause;
      Cram;
    end;
    if Redeemval > (RecStuff.LockFights) then begin
      Enter;
      swrite(' Your receipts show you don''t have that many saved!');
      pause;
      Cram;
    end;
    if Redeemval + (RecStuff.FightLeft) > 255 then begin
      Enter;
      swrite(' You may only plan ahead for 255 fights!');
      pause;
      Cram;
    end;
    RecStuff.FightLeft := ((RecStuff.FightLeft) + Redeemval);
    RecStuff.LockFights := ((RecStuff.LockFights) - Redeemval);
    Enter;
    swrite(' Redemption Complete!');
    pause;
  end;
  if Lockerin = '?' then begin
    temp := 1;
    Cram;
  end;
  PUTplayer(recordnum);
  if not (Lockerin in ['Q','q']) then Cram;
end; {Cram}

procedure Battlemonster;
Var MonsterGold,MonsterSay, PlayAttack, Monstattack:integer;
    say:string;
begin
  RecStuff.currenthit := 500;
  PlayAttack := round(random * (RecStuff.Attacks + 1) - 1);
  Monstattack := round(random * (Monster.Attack * 2)) - round(random * RecStuff.Defences);
  sclrscr;
  sgoto_xy(10, 1);
  if PlayAttack = Monstattack then begin
    set_color(10,0);
    printout('No one wins this round.', 1);
    set_color(12,0);
  end;
  if PlayAttack > Monstattack then begin
    set_color(10,0);
    printout('You deal the ', 0);
    set_color(9,0);
    printout((Monster.Nam), 0);
    set_color(10,0);
    printout(' a blow!', 1);
    Monster.Health := Monster.Health - PlayAttack;
    set_color(9,0); printout('He''s down to ' + ISTR(Monster.Health) + ' hitpoints after you took' + ISTR(PlayAttack) +
                             ' hitpoints away.', 1);
  end;
  if PlayAttack < Monstattack then begin
    set_color(9,0);
    printout('You have been wounded!', 1);
    set_color(10,0);
    printout((Monster.Nam), 0); set_color(9,0);
    printout(' hits you with its ' + (Monster.Weapon),1);
    RecStuff.currenthit := RecStuff.currenthit - Monstattack;
    printout('You lost'+ISTR(Monstattack)+' hitpoints. You are down to'+ISTR(RecStuff.currenthit)+' hitpoints.',1);
  end;
  pause;
  sclrscr;
  sgoto_xy(10, 1);
  if (RecStuff.currenthit > 0) AND (Monster.Health <= 0) then begin
    printout('You won the fight! You found' + ISTR(Monster.Gold) + ' pieces of gold!', 1);
    monstersay := round(random * 4) + 1;
    case monstersay of
    1:say:=monster.say1;
    2:say:=monster.say2;
    3:say:=monster.say3;
    4:say:=monster.say4;
    end;
    spipeln('|09 - |12'+say+'|09');
    spipe('|10   Speaks |09'+monster.nam+'|10');
    printout(' after the battle.', 1); set_color(9,0);
    RecStuff.cashonhand := RecStuff.cashonhand + Monster.Gold;
    monstergold := round(random * Monster.Gold) * 4;
    if monstergold < (Monster.Gold / 2) then monstergold := Monster.Gold div 2;
    RecStuff.exper := RecStuff.exper + monstergold;
    pause;
    exit;
    if (Monster.Health > 0) AND ( RecStuff.currenthit < 1) then begin
      sclrscr;
      printout('The ' + (Monster.Nam) + ' killed you!', 1); RecStuff.currenthit := 0;
      RecStuff.Lastdate := DateNow;
      printout('Game over!', 1);
      RecStuff.cashonhand := 0;
      pause;
      endnow(true);
    end;
  end;
end;

procedure BuyArmor;
var arm1:file of WepArmtype;
    aw,wleng:integer;
    buya:char;
    label buyarmorchoice;
begin
  assign(arm1, 'Armor.Gwt');
  reset(arm1);
  wleng := filesize(arm1);
  buyarmorchoice:
  set_color(9,0);
  sclrscr;
  SCenterText('Available Shields');
  set_color(12,0);

  printout(' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-', 1);
  Enter;
  set_color(9,0);
  Enter;
  FOR aw := 1 TO wleng do begin
    read(arm1,WepArm);
    PrintOutTAB(16, '[' + (ISTR(aw)) + '] ' + (WepArm.Nam) + '...' +
    STRINGString((35 - LEN((WepArm.Nam)) - LEN(((ISTR(WepArm.Cost))))), '.') + ((ISTR(WepArm.Cost))) + ' gold', 1);
  end; {for .. aw}
  PrintOutTAB(16, '[Q]uit back to the front...', 1);
  PrintOutTAB(5, 'What would you like, Monsieur?', 1);
  sread_char(buya);
  if (VALue(buya) > 0) AND (value(buya) <= wleng) then begin
    seek(arm1, value(buya));
    read(arm1, WepArm);
    if WepArm.Cost > RecStuff.cashonhand then begin
      printout('You do not have enough money for this!', 1);
      pause;
      GOTO buyarmorchoice;
    end;
    if (RecStuff.ArmorN) <> 'Skin' then begin
      printout('You cannot have two armor at once!', 1);
      pause;
      GOTO buyarmorchoice;
    end;
    RecStuff.cashonhand := RecStuff.cashonhand - WepArm.Cost;
    RecStuff.ArmorN := (WepArm.Nam);
    RecStuff.Defences := RecStuff.Defences + WepArm.Much;
    RecStuff.ArmorC := WepArm.Cost div 2;
    RecStuff.ArmorD := WepArm.Much;
    printout('You now have a ' + (WepArm.Nam) + '!', 1);
    pause;
    CLOSE(arm1);
    exit
  end;
  if ucase(buya) = 'Q' then begin
    CLOSE(arm1);
    exit;
  end;
  GOTO buyarmorchoice;
end;

procedure BuyWeapon;
var wep1:file of weparmtype;
    aw,wleng:integer;
    buya:char;
label buyweaponchoice;
begin
  assign(wep1, 'Weapons.Gwt');
  reset(wep1);
  wleng := filesize(wep1);
  buyweaponchoice:
  sclrscr;
  set_color(9,0);
  SCenterText('Available Weapons');
  set_color(12,0);

  printout(' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-', 1);
  Enter;
  set_color(9,0);
  Enter;
  FOR aw := 1 TO wleng do begin
    read(wep1, WepArm);
    PrintOutTAB(16, '[' + (ISTR(aw)) + '] ' + (WepArm.Nam) + '...' + StringString((35 - LEN((WepArm.Nam)) -
                    LEN(((ISTR(WepArm.Cost))))), '.') + ((ISTR(WepArm.Cost))) + ' gold', 1);
  end; {for .. aw}
  PrintOutTAB(16, '[Q]uit back to the front...', 1);
  PrintOutTAB(5, 'What would you like, Monsieur?', 1);
  sread_char(buya);
  if (value(buya) > 0) AND (value(buya) <= wleng) then begin
    seek(wep1,value(buya));
    read(wep1, WepArm);
    if WepArm.Cost > RecStuff.cashonhand then begin
      printout('You do not have enough money for this!', 1);
      pause;
      GOTO buyweaponchoice;
    end;
    if (RecStuff.WeaponN) <> 'Hands' then begin
      printout('You cannot have two weapons at once!', 1);
      pause;
      GOTO buyweaponchoice;
    end;
    RecStuff.cashonhand := RecStuff.cashonhand - WepArm.Cost;
    RecStuff.WeaponN := (WepArm.Nam);
    RecStuff.Attacks := RecStuff.Attacks + WepArm.Much;
    RecStuff.WeaponC := WepArm.Cost div 2;
    RecStuff.WeaponS := WepArm.Much;
    printout('You now have a ' + (WepArm.Nam) + '!', 1);
    pause;
    CLOSE(wep1);
    exit;
  end;
  if ucase(buya) = 'Q' then begin
    CLOSE(wep1);
    exit
  end;
  GOTO buyweaponchoice;
end;

procedure CheckEMail;
var text,filenam, filenam2:string;
    xyz,xyz2:file of emails;
    em:char;
    dg,arf,ff,point1,point2,eleng,putat,i:integer;
    label endofdo,again,endofdo2,exitfor;
begin
  filenam := 'mail' + ISTR(recordnum) + '.DAT';
  filenam2 := 'mail.DAT';
  assign(xyz,filenam);
  assign(xyz2,filenam2);
  if not (file_exists('mail' + ISTR(recordnum) + '.DAT')) then exit;
  reset(xyz);
  rewrite(xyz2);
  if Filesize(xyz) = 0 then begin
    CLOSE(xyz);
    erase(xyz);
    CLOSE(xyz2);
    erase(xyz2);
    exit;
  end;
  eleng := Filesize(xyz);
  putat := 1;
  i := 0;
  while false=true do begin
    inc(i);
    if i > eleng then goto endofdo;
    sclrscr;
    seek(xyz,i);
    read(xyz,email);
    Point1 := i;
    Enter; Enter;
    spipeln('|10From: '+email.Nam);
    Enter;
    ff := 0;
    spipeln('|09    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
    again:
    Text := email.msg;
    spipe('|09    ³');
    spipe('|15'+Text);
    printout(SPACE(70 - LEN((email.msg))), 0);
    set_color(9,0);
    sgoto_xy(wherex, 76);
    printout('³', 1);
    inc(ff);
    if (ff = 20) AND (email.Flag = 1) then begin
      pause;
      ff := 0;
    end;
    if email.Flag = 1 then begin
      inc(i);
      seek(xyz,i);
      read(xyz,email);
      GOTO again
    end;
    set_color(9,0);
    printout('    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ', 1);
    Point2 := i;
    while false=true do begin
      Enter;
      printout('    (I)gnore, (D)elete, or (R)eply?', 0);
      sread_char(em);
      if em = 'I' then begin
        FOR arf := putat + (Point1 - Point1) TO putat + (Point2 - Point1) do begin
          seek(xyz,(arf - putat) + Point1);
          read(xyz,email);
          seek(xyz2,arf);
          write(xyz2,email);
        end; {for .. arf}
        putat := (putat + (Point2 - Point1)) + 1;
        goto endofdo2;
      end;
      if em = 'D' then goto endofdo2;
      if em = 'R' then begin
        putplayer(recordnum);
        FOR dg := 1 TO Filesizeofdata do begin
          getplayer(dg);
          if ucase(email.Nam) = ucase(RecStuff.Nam) then begin
            EMailReply(dg, Point1, Point2,filenam);
            goto exitfor;
          end;
        end; {for .. dg}
        exitfor:
        getplayer(recordnum);
        if dg > filesizeofdata then printout(' That player is not active at the moment!', 1);
        goto endofdo2;
      end;
    end;
    endofdo2:
  end;
  endofdo:
  CLOSE(xyz);
  close(xyz2);
  kill(filenam);
  if putat = 1 then KILL(filenam2) ELSE RENAME(xyz2,filenam);
end;

procedure CheckTemp;
var test:file of char;
    xyz:text;
    a:longint;
    texts:string;
begin
  a:=-1;
  assign(test, 'igmmsg.1');
  if file_exists('Igmmsg.1') then begin
    reset(test);
    a := filesize(test);
  end;
  if a = 0 then begin
    CLOSE(test);
    erase(test);
    exit;
  end;
  if not(file_exists('Igmmsg.1')) then exit;
  CLOSE(test);
  sclrscr;
  assign(xyz, 'igmmsg.1');
  reset(xyz);
  repeat
    readln(xyz, Texts);
    spipeln(Texts);
  UNTIL EOF(xyz);
  pause;
  CLOSE(xyz);
  erase(xyz);
end;

procedure EMailReply (Num, Point1, Point2:integer;s:string);
var lin:array[1..100] of string;
    bok:array[1..80] of string[1];
    blok:array[1..80] of integer;
    filenam:string;
    xyz,xyzz:file of emails;
    man,wa,we,xlin,dg,eleng,Liner,Poop:integer;
    ss:string;
    ef,c:char;

  procedure redraws;
  var a,b:integer;
  begin
    FOR a := 1 TO 5 do begin
      FOR b := 1 TO 16 do begin
        set_color(Blok[((a - 1) * 16) + b],0);
        sgoto_xy(a, b);
        swrite(bok[((a - 1) * 16) + b]);
      end; {for .. b}
    end; {for .. a}
  end;

    label Flips,exitdo,enders;
begin
  assign(xyz, s);
  reset(xyz);
  filenam := 'mail' + ISTR(Num) + '.DAT';
  assign(xyzz,filenam);
  reset(xyzz);
  eleng := FileSize(xyzz);
  set_color(15,0);
  Enter;
  printout('    Enter; the e-mail. Hit Esc for commands.', 1);
  printout('    Up to 100 lines. (spipe(colors can be used):', 1);
  Liner := 1;
  poop := 5;
  if (Point2 - Point1) + 1 > 0 then begin
    seek(xyz,Point2);
    read(xyz,email);
    Lin[poop] := '|10> ' + LEFT(email.msg, 65);
  end;
  poop := poop - 1;
  if (Point2 - Point1) + 1 > 1 then begin
    seek(xyz,point2-1);
    read(xyz,email);
    Lin[poop] := '|10> ' + LEFT(email.msg, 65);
  end;
  poop := poop - 1;
  if (Point2 - Point1) + 1 > 2 then begin
    seek(xyz,point2-2);
    read(xyz,email);
    Lin[poop] := '|10> ' + LEFT(email.msg, 65);
  end;
  poop := poop - 1;
  if (Point2 - Point1) + 1 > 3 then begin
    seek(xyz,point2-3);
    read(xyz,email);
    Lin[poop] := '|10> ' + LEFT(email.msg, 65);
  end;
  poop := poop - 1;
  if (Point2 - Point1) + 1 > 4 then begin
    seek(xyz,point2-4);
    read(xyz,email);
    Lin[poop] := '|10> ' + LEFT(email.msg, 65);
  end;
  set_color(1,0);
  printout('    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿', 1);
  FOR dg := 1 TO 5 do begin
    set_color(1,0);
    sgoto_xy(wherex, 5);
    swrite('³');
    set_color(7,0);
    swrite(Lin[dg] + SPACE(70 - Length(Lin[dg])));
    set_color(1,0);
    sgoto_xy(wherex, 76);
    swrite('³');
    Enter;
  end; {for .. dg}
  Liner := 6;
  set_color(9,0); sgoto_xy(wherex, 5); swrite('³');
  set_color(15,0);
  printout(Lin[Liner] + SPACE(70 - Length(Lin[Liner])), 0);
  set_color(9,0); printout('³', 0);
  while false=true do begin {' Lin(6)} {DOOOOO}
    sread_char(c);
    ss := c;
    if c = chr(8) then begin
      if Length(Lin[Liner]) > 0 then Lin[Liner] := left(Lin[Liner], Length(Lin[Liner]) - 1);
      set_color(9,0); sgoto_xy(wherex, 5);
      swrite('³'); set_color(15,0);
      printout(Lin[Liner] + space(70 - Length(Lin[Liner])), 0);
      set_color(9,0); printout('³', 0);
      GOTO Flips;
    end;
    if c = chr(9) then ss := '   ';
    if c = chr(13) then begin
      set_color(1,0); sgoto_xy(wherex, 5);swrite('³'); set_color(7,0);
      printout(Lin[Liner] + space(70 - Length(Lin[Liner])), 0);
      set_color(1,0); printout('³', 0);
      if Liner <> 100 then begin
        Liner := Liner + 1;
        Enter;
      end;
      set_color(9,0); sgoto_xy(wherex, 5);
      swrite('³'); set_color(15,0);
      printout(Lin[Liner] + space(70 - Length(Lin[Liner])), 0);
      set_color(9,0); printout('³', 0);
      GOTO Flips;
    end;
    if c = chr(27) then begin
      xlin := CSRLIN;
      FOR wa := 1 TO 5 do begin
        FOR we := 1 TO 16 do begin
          (******bok[((wa - 1) * 16) + we] := chr(SCREEN(wa, we));
          Blok[((wa - 1) * 16) + we] := SCREEN(wa, we, 1);**********)
        end; {for .. we}
      end; {for .. wa}
      sgoto_xy(1, 1);swriteln('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      sgoto_xy(2, 1);swriteln('³(A)bort Mail  ³');
      sgoto_xy(3, 1);swriteln('³(S)ave Mail   ³');
      sgoto_xy(4, 1);swriteln('³(Enter)Nothing³');
      sgoto_xy(5, 1);swriteln('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
      sread_char(ef);
      if ef = 'S' then begin
        Redraws;
        set_color(1,0);
        sgoto_xy(xlin, 5);
        swrite('³');
        set_color(7,0); printout(Lin[Liner] + space(70 - Length(Lin[Liner])), 0);
        set_color(1,0); printout('³', 0);
        Liner := Liner + 1;
        goto exitdo;
      end;
      if ef = 'A' then begin
        redraws; CLOSE(xyz);goto enders;
      end;
      Redraws;
      set_color(9,0); sgoto_xy(xlin, 5);swrite('³');
      set_color(15,0); printout(Lin[Liner] + space(70 - Length(Lin[Liner])), 0);
      set_color(9,0); printout('³', 0);
      GOTO Flips;
    end;
    if c <> '' then begin
      if Ord(c) < 32 then ss := '';
      if Length(Lin[Liner]) <> 70 then Lin[Liner] := Lin[Liner] + ss;
      set_color(9,0); sgoto_xy(wherex, 5);swrite('³');
      set_color(15,0); printout(Lin[Liner] + space(70 - Length(Lin[Liner])), 0);
      set_color(9,0); printout('³', 0);
    end;
    Flips:
  end; {do loop}
  exitdo:
  set_color(1,0);
  sgoto_xy(xlin + 1, 5);
  swriteln('    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
  getplayer(recordnum);
  FOR man := 1 TO Liner - 1 do begin
    email.Nam := RecStuff.Nam;
    email.msg := Lin[man];
    if man = Liner - 1 then email.Flag := 0 ELSE email.Flag := 1;
    seek(xyzz, eleng+man);
    write(xyzz, email);
  end; {for .. man}
  CLOSE(xyzz);
  GOTO enders;
  enders:
end;

procedure Flirt (ParagraphPick:integer);
var a:char;
    moneyamount:longint;
label inputflirt;
begin
  if RecStuff.Sex = '0' then begin
    spipeln('|15"|08Y|07ou lesbian fool|15! |08G|07o away|15!" |07the clerk screams in anger|15.');
    pause;
    exit;
  end;
  if RecStuff.Flirt  then begin
    spipeln('|15"|08G|07o away you pervert|15!" |07the clerk screams in anger|15.');
    pause;
    exit
  end;
  RecStuff.Flirt := true;
  sclrscr;
  Enter;
  inputflirt:
  set_color(8,0);
  sgoto_xy(2, 31);
  swriteln('The hottest babe!');
  set_color(9,0); SCenterText('*--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--*');
  Enter; Enter; Enter;
  printout('    You swallow your pride and bravely walk up towards the woman behind the', 1);
  printout(' counter.  You look around to make sure someone watches you hit it off here.', 1);
  printout(' There is a rowdy bunch in the back of the room playing poker, their eyes', 1);
  printout(' carefully trained on you.  You spin around and...', 1);
  Enter;
  sgoto_xy(15,wherey);
  spipeln('|07[|11S|07]|10mile at here');
  sgoto_xy(15,wherey);
  spipeln('|07[|11O|07]|10rder her a drink');
  sgoto_xy(15,wherey);
  spipeln('|07[|11B|07]|10low her a kiss');
  sgoto_xy(15,wherey);
  spipeln('|07[|11A|07]|10ttempt to kiss her');
  sgoto_xy(15,wherey);
  spipeln('|07[|11M|07]|10assage her thigh');
  sgoto_xy(15,wherey);
  spipeln('|07[|11W|07]|10hisper dirty things in her ear');
  repeat
    sread_char(a);
    a := upcase(a);
  until a in ['S','A','O','B','M','W'];
  Enter;
  set_color(2,0);
  CASE a of
     'S': begin
            printout(' You look towards the woman behind the bar and flash a huge smile...', 1);
            if RecStuff.exper < 150 then begin GetAway; exit; end;
            if ParagraphPick = 1 then begin
              printout(' She smiles and blushes bright red...', 1);
              spipeln('|15 Yes! The guys in the back raise their cups to you.  You get 100 experience.');
              RecStuff.exper := RecStuff.exper + 100;
            end
            ELSE begin
              printout(' The OLD woman blushes bright red...', 1);
              set_color(15,0); printout(' Oh no! The guys in the back start chuckling.  You lose 100 experience!', 1);
              RecStuff.exper := RecStuff.exper - 100;
            end;
          end;
     'O':begin
           if RecStuff.exper < 1500 then begin GetAway; exit; end;
           if ParagraphPick = 1 then begin
             printout(' She smiles, and accepts the drink...', 1);
             set_color(15,0); printout(' Yes! The guys in the back raise their cups to you.  You get 1,000 experience.', 1);
             RecStuff.exper := RecStuff.exper + 1000;
           end
           ELSE begin
             printout(' The old woman smiles, and gulps the drink down in one gulp!', 1);
             set_color(15,0); printout(' Oh no! The guys in the back starting chuckling.  You lose 1,000 experience.', 1);
             RecStuff.exper := RecStuff.exper - 1000;
           end;
         end;
     'B':begin
           if RecStuff.exper < 15000 then begin GetAway; exit; end;
           if ParagraphPick = 1 then begin
             printout(' She blushes and reaches up to grab the kiss.  She blows you back a kiss...', 1);
             set_color(15,0); printout(' Alright!  The guys in the back cheer at you.  You receive 10,000 experience!', 1);
             RecStuff.exper := RecStuff.exper + 10000;
           end
           ELSE begin
             printout(' The old woman grabs it and places it where the sun don''t shine. ', 1);
             printout(' You feel nauseous!  The guys in the back cry out in laughter.', 1);
             set_color(15,0); printout(' You lose 10,000 experience!', 1);
             RecStuff.exper := RecStuff.exper - 10000
           end;
         end;
     'A': begin
           if RecStuff.exper < 80000 then begin GetAway; exit; end;
           if ParagraphPick = 1 then begin
             printout(' She pulls you closer and lays a wet one on your wanting lips!', 1);
             set_color(15,0); printout(' The guys cheer at you.  You receive 80,000 experience!', 1);
             RecStuff.exper := RecStuff.exper + 80000
           end
           ELSE begin
             printout(' The old woman pulls you close and kisses you soundly.', 1);
             printout(' You pull away and cough out the strange tasting saliva in your mounth!', 1);
             set_color(15,0); printout(' The guys in the back are cracking up!  You lose 80,000 experience!', 1);
             RecStuff.exper := RecStuff.exper - 80000
           end;
         end;
     'M':begin
           if RecStuff.exper < 175000 then begin GetAway; exit; end;
           if ParagraphPick = 1 then begin
             printout(' She purrs softly and massages you back, but in a more sensitive spot!', 1);
             set_color(15,0);
             printout(' The guys in the back are wide-eyed with amazement! You receive 175,000 experience!!', 1);
             RecStuff.exper := RecStuff.exper + 175000
           end
           ELSE begin
             printout(' The soft flesh feels chunky under your hands.  You quickly draw your hand back.', 1);
             printout(' But not quick enough.  The old woman grabs and rubs you all over!  The guys in', 1);
             printout(' the back are nearly crying with laughter!', 0); set_color(15,0);
             printout(' You lose 175,000 experience!!', 1);
             RecStuff.exper := RecStuff.exper - 175000
           end;
         end;
     'W':begin
           if RecStuff.exper < 500000 then begin GetAway; exit; end;
           moneyamount := round(random * (50000 - 1) + 1);
           if ParagraphPick = 1 then begin
             printout(' She purrs softly, grab you by the hand, and leads you upstairs to a vacant room.', 1);
             printout(' An hour later, you return soaked in sweat.  The guys in the back cheer', 1);
             printout(' and throw their chips to you.', 0); set_color(15,0);
             printout('  You recieve 500,000 experience and ' + ISTR(moneyamount) + ' gold!', 1);
             RecStuff.exper := RecStuff.exper + 500000;
             RecStuff.cashonhand := RecStuff.cashonhand + moneyamount
           end
           ELSE begin
             printout(' The old woman tries to purr, but it comes out as a gargle.  She yanks you upstairs!', 1);
             printout(' 10 minutes later you return, your face frozen in fear!  The guys in the back', 1);
             printout(' promptly throw their meat scraps at you.', 0); set_color(15,0);
             printout('  You lose 500,000 experience, and you notice', 1);
             printout(' the old woman had taken' + ISTR(moneyamount) + 'gold from your pocket!!', 1);
             RecStuff.exper := RecStuff.exper - 500000;
             RecStuff.cashonhand := RecStuff.cashonhand - moneyamount
           end;
         end;
  END;
  pause;
end;

procedure GetAway;
var a:char;
begin
  sgoto_xy(wherex, 13);
  swrite('"');
  set_color(4,0); printout('Get away from me, jerk!', 0); set_color(10,0); printout('"', 0);
  set_color(12,0); printout(' the woman yells.', 1);
  sread_char(a);
end;

procedure Healers;
var healnumb,healcost:integer;
    heala:char;
    healnum:string;
    goon:boolean;
label healerchoice;
begin
  healcost := 25;
  healerchoice:
  getscreen('{HEALER}');
  sread_char(heala);
  if (heala = 'R') OR (Ord(heala) = 13) then exit
  else if heala = 'H' then begin
    goon:=true;
    if RecStuff.currenthit >= RecStuff.totalhit then begin
      printout('You do not need healing.. what are you? Stupid??', 1);
      pause;
      exit;
    end;
    if (RecStuff.totalhit - RecStuff.currenthit) * healcost > RecStuff.cashonhand then begin
      printout('You do not have enough money for that!  Why don''t you just GET OUT?!', 1);
      pause;
    end
    ELSE begin
      printout('Healing.......', 1);
      RecStuff.cashonhand := RecStuff.cashonhand - ((RecStuff.totalhit - RecStuff.currenthit) * healcost);
      RecStuff.currenthit := RecStuff.totalhit;
      pause;
      exit;
    end;
  end
  else if heala = 'C' then begin
    goon:=true;
    if RecStuff.currenthit >= RecStuff.totalhit then begin
      printout('You do not need healing.. what are you? Stupid??', 1);
      pause;
      exit;
    end;
    swrite('How much do you want healed?? -=> ');
    sread(healnum);
    healnumb := value(healnum);
    if healnumb * healcost > RecStuff.cashonhand then begin
      printout('You do not have enough money for that!  Why don''t you just GET OUT?!', 1);
      pause;
    end
    else if healnumb <= 0 then GOTO healerchoice
    ELSE if not goon then begin
      printout('Healing.......', 1);
      RecStuff.cashonhand := RecStuff.cashonhand - (healnumb * healcost);
      RecStuff.currenthit := RecStuff.currenthit + healnumb;
      pause;
      exit;
    end;
  end;
end;

procedure ListArmor;
var aw, wleng:integer;
    arm1:file of weparmtype;
begin
  assign(arm1, 'Armor.gwt');
  reset(arm1);
  wleng := filesize(arm1);
  set_color(9,0);
  sclrscr;
  SCenterText('Available Shields');
  set_color(12,0);

  printout(' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-', 1);
  Enter;
  set_color(9,0);
  Enter;
  FOR aw := 1 TO wleng do begin
    seek(arm1,aw);
    read(arm1, Weparm);
    sgoto_xy(wherex, 16);
    PrintOut('[' + (ISTR(aw)) + '] ' + (WepArm.Nam) + '...' + StringString((35 - Length((WepArm.Nam)) -
             Length(((ISTR(WepArm.Cost))))), '.') + ((ISTR(WepArm.Cost))) + ' gold', 1);
  end; {for .. aw}
  pause;
  CLOSE(arm1);
end;

procedure ListPlayer;
var expernum,DeadLen,NamLen,Ls,float,i:integer;
    dead:string;
    PEx,People:array[1..99] of integer;
label endlist;
begin
  if recordnum>0 then PUTplayer(recordnum);
  Enter;
  set_color(9,0);
  printout('                                   '+istr(filesizeofdata)+' Players', 1);
  set_color(12,0);
  printout(' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-', 1);
  set_color(9,0);
  printout('          Name                          Experience          Status', 1);
  set_color(12,0);
  printout(' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-', 1);
  set_color(9,0);
  if filesizeofdata=0 then begin
    Enter;
    printout('                              No players found!', 1);
    Enter;
    GOTO EndList
  end;
  FOR i := 1 TO filesizeofdata do begin
    GETplayer(i);
    PEx[i] := RecStuff.exper;
    People[i] := i;
  end; {for .. i}
  repeat
    float := float + 1;
    FOR i := 1 TO filesizeofdata do begin
      if PEx[i] < PEx[i + 1] then begin
         SWAPInt(People[i], People[i + 1]);
         SWAPInt(PEx[i], PEx[i + 1]);
      end;
    end; {for .. i}
  UNTIL float >= filesizeofdata;
  Ls := 5;
  namlen := 21;
  FOR i := 1 TO filesizeofdata do begin
    getplayer(People[i]);
    if ((RecStuff.Nam) <> 'X') AND ((RecStuff.Nam) <> '') then begin
      if RecStuff.currenthit <= 0 then dead := ' Dead' ELSE dead := 'Alive';
      set_color(10,0);
      printout('          ', 0);
      if People[i] = recordnum then set_color(12, 7);
      printout(rtrim(Left(RecStuff.Nam + StringString(namlen,#32), namlen)),0);
      set_color(15,0);
      printout(right(RecStuff.Nam + StringString(namlen,#32), namlen-length(RecStuff.Nam)),0);
      printout('           ', 0);
      expernum := RecStuff.exper;
      swrite(comma+'     ');
      if RecStuff.currenthit <= 0 then begin
        set_color(1,0);
      end;
      deadlen := 5;
      dead := dead + StringString(deadlen - Length(dead), #32);
      sgoto_xy(wherex, 67 - Length(dead)); printout(dead, 0);
      if People[i] = recordnum then set_color(12, 0);
      Enter;
      Ls := Ls + 1;
      enter;
      if Ls = 24 then begin
        pause;
        Ls := 0;
      end;
    end;
  end; {for .. i}
  EndList:
  Enter;
  pause;
  if recordnum>0 then GETplayer(recordnum);
end;

procedure ListWeapon;
var wep1:file of weparmtype;
    aw, wleng:integer;
begin
  assign(wep1, 'Weapons.Gwt');
  wleng := FileSize(wep1);
  sclrscr;
  set_color(9,0);
  SCenterText('Available Weapons');
  set_color(12,0);

  printout(' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-', 1);
  Enter;
  set_color(9,0);
  Enter;
  FOR aw := 1 TO wleng do begin
    seek(wep1,aw);
    read(wep1, WepArm);
    sgoto_xy(wherex, 16);
    printout('[' + (ISTR(aw)) + '] ' + (WepArm.Nam) + '...' + StringString((35 - Length((WepArm.Nam)) -
             Length(((ISTR(WepArm.Cost))))), '.') + ((ISTR(WepArm.Cost))) + ' gold', 1);
  end; {for .. aw}
  pause;
  CLOSE(wep1);
end;

procedure NotInstalled;
begin
  Enter;
  printout('That option is currently not available at this time...', 1);
  pause;
end;

procedure PlayerDat;
var Race, Job:string;
    Zap:file of emails;
    eleng:integer;
    killme:Text;
begin
  sclrscr;
  if RecStuff.Race = '1' then Race := 'Humaniod';
  if RecStuff.Race = '2' then Race := 'Cyborg';
  if RecStuff.Race = '3' then Race := 'Amphibian';
  if RecStuff.Race = '4' then Race := 'Alien';
  if RecStuff.Race = '5' then Race := 'Android';
  if RecStuff.Race = '6' then Race := 'Quadruped';
  if RecStuff.Race = '7' then Race := 'Arachnid';
  if RecStuff.Race = '8' then Race := 'Mutant';
  if RecStuff.Race = '9' then Race := 'Crossbreed';
  if RecStuff.Race = '0' then Race := 'Telepath';
  if RecStuff.Race = 'A' then Race := 'Parasite';
  if RecStuff.Job = '1' then Job := 'Sniper';
  if RecStuff.Job = '2' then Job := 'GWT Officer';
  if RecStuff.Job = '3' then Job := 'Mercenary';
  if RecStuff.Job = '4' then Job := 'Bounty Hunter';
  if RecStuff.Job = '5' then Job := 'Navigator';
  if RecStuff.Job = '6' then Job := 'IP Diplomatic';
  if RecStuff.Job = '7' then Job := 'Student';
  if RecStuff.Job = '8' then Job := 'Arena Fighter';
  if RecStuff.Job = '9' then Job := 'Self Employed';
  set_color(11,0);
  printout('              Galactic Warriors Tournament Personal Statistics', 1);
  set_color(9,0);

  printout(' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-', 1);
  Enter;
  set_color(11,0);
  with RecStuff do begin
    printout(' Name: ' + Nam, 1);
    printout(' Race: ' + Race, 1);
    printout(' Occupation: ' + Job, 1);
    printout(' Hit Points: ' + ISTR(currenthit) + '/' + ISTR(totalhit), 1);
    printout(' Experience: ' + ISTR(exper), 1);
    printout(' Level: ' + ISTR(Ord(Level)), 1);
    printout(' Credits In Hand: ' + ISTR(cashonhand), 1);
    printout(' Credits Compiled In Bank: ' + ISTR(cashinbank), 1);
    printout(' Attack Strength: ' + ISTR(Attacks), 1);
    printout(' Defense Strength: ' + ISTR(Defences), 1);
    printout(' Weapon: ' + WeaponN, 1);
    printout(' Shielding: ' + RecStuff.ArmorN, 1);
    printout(' Arena Fights: ' + ISTR(Ord(FightLeft)) + '/' + ISTR(Ord(TotalFight)), 1);
  end;
  assign(Zap,  'mail' + ((ISTR(recordnum))) + '.dat');
  if file_exists('mail' + ((ISTR(recordnum))) + '.dat') then reset(Zap) else rewrite(Zap);
  eleng := filesize(Zap);
  printout(' Mail Waiting: ', 0);
  if eleng > 0 then set_color(28,0);
  printout(ISTR(eleng), 0); set_color(9,0); printout(' lines', 1);
  CLOSE(Zap);
  Enter;
  printout(' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-', 1);
  set_color(11,0);
  printout('                      Statistics For: ' + (RecStuff.RNam), 1);
  set_color(9,0);
  printout(' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-', 1);
  set_color(9,0);
  if eleng = 0 then begin
   assign(killme, 'mail' + ((ISTR(recordnum))) + '.dat');
   erase(killme);
  end;
  pause;
end;
end.