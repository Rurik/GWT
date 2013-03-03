{One other thing, ENEMY.DAT CAN'T BE READ!!!}
program GWT;
{$B+,R-,S+,I+,N-,M 65520,0,655360}
uses overlay,initover,dos,crt,ddplus,routine,typedef,beb,screen2,screen3,pipes,register;
{$O DDOvr}
{$O DDOvr2}
{$O screen2}
{$O screen3}
{$O routine}
procedure fight;forward;
procedure sellarmor;forward;
procedure SellWeapon;forward;
procedure Battle;forward;
procedure UserFight;forward;
procedure TheHotel;forward;
procedure WeaponComp;forward;
procedure ShieldCtr;forward;
procedure MagicShop;forward;
procedure TradersCorn;forward;
procedure TheArena;forward;
procedure StartGalactron;forward;
const days : array[0..6]of String[9] = ('Sunday','Monday','Tuesday',
                             'Wednesday','Thursday','Friday','Saturday');
var igm1:text;
    count,leng:integer;

procedure NameSelection;
var nam:string;
    sex,JobNum,RaceNum:char;
begin
  recordnum := leng + 1;
  leng := leng + 1;
  sclrscr;
  SCenterText('Name Selection');
  set_color(9,0);
  swriteln(' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
  Enter;
  set_color(12,0);
  swrite(' What do you want for an alias -¯> ');
  sread(Nam);
  RecStuff.Nam := Nam;
  with RecStuff do begin
    RNam := writecorrect(user_first_name + ' ' + user_last_name);
    PWord := '';
    Level := #1;
    Gems := #0;
    exper := 0;
    wongame := 0;
    LockFights := 0;
    cashonhand := 500;
    CashInBank := 0;
    TotalHit := 30;
    CurrentHit := TotalHit;
    Defences := 5;
    Attacks := 5;
    exper := 0;
    PlayerKills := 0;
    TotalFight := 20;
    FightLeft := TotalFight;
    WeaponN := 'Dagger';
    WeaponC := 500;
    WeaponS := 2;
    ArmorN := 'Wooden Shield';
    ArmorC := 500;
    ArmorD := 2;
    Planet := '1';
    Expert := false;
    SeenMaster := false;
    Trip := false;
    Flirt := false;
    SFans := false;
    SeenM := false;
    ThrewRox := false;
  end;
  sclrscr;
  Enter;
  set_color(9,0);
  SCenterText('GWT Race Selection');
  set_color(12,0);
  swriteln(' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
  Enter;
  Enter;
  set_color(9,0);
  spipeln(' (|101|09) Humaniod');
  spipeln(' (|102|09) Cyborg');
  spipeln(' (|103|09) Amphibian');
  spipeln(' (|104|09) Alien');
  spipeln(' (|105|09) Android');
  spipeln(' (|106|09) Quadruped');
  spipeln(' (|107|09) Arachnid');
  spipeln(' (|108|09) Mutant');
  spipeln(' (|109|09) Crossbreed');
  spipeln(' (|100|09) Telepath');
  spipeln(' (|10A|09) Parasite');
  Enter;
  swrite(' Choose your race, ' + RecStuff.Nam);
  RaceNum := input('1234567890A');
  RecStuff.Race := RaceNum;
  sclrscr;
  set_color(9,0);
  SCenterText('GWT Job Selection');
  set_color(12,0);
  swriteln(' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
  Enter;
  set_color(9,0);
  Enter;
  Enter;
  spipeln(' (|101|09) Sniper');
  spipeln(' (|102|09) GWT Officer');
  spipeln(' (|103|09) Mercenary');
  spipeln(' (|104|09) Bounty Hunter');
  spipeln(' (|105|09) Navigator');
  spipeln(' (|106|09) IP Diplomatic');
  spipeln(' (|107|09) Student');
  spipeln(' (|108|09) Arena Fighter');
  spipeln(' (|109|09) Self Employed');
  Enter;
  Enter;
  swrite(' What is your galactic job, ' + RecStuff.Nam);
  JobNum := input('123456789');
  if JobNum = '1' then RecStuff.Job := '1';
  if JobNum = '2' then RecStuff.Job := '2';
  if JobNum = '3' then RecStuff.Job := '3';
  if JobNum = '4' then RecStuff.Job := '4';
  if JobNum = '5' then RecStuff.Job := '5';
  if JobNum = '6' then RecStuff.Job := '6';
  if JobNum = '7' then RecStuff.Job := '7';
  if JobNum = '8' then RecStuff.Job := '8';
  if JobNum = '9' then RecStuff.Job := '9';
  sclrscr;
  SCenterText('Sex Selection');
  swrite(' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
  Enter;
  spipe(' So, are you (|10M|09)ale or (|10F|09)emale?');
  Sex := input('MF');
  if Sex = 'M' then RecStuff.Sex := '1';
  if Sex = 'F' then RecStuff.Sex := '0';
  Putplayer(recordnum);
end; {NameSelection}

procedure IcePlanet;
begin
end; {IcePlanet}

procedure WaterWorld;
begin
end; {WaterWorld}

procedure PreCivilization;
begin
end; {PreCivilization}

procedure AlienShip;
begin
end; {alienship}

procedure FindPlanet;
var planet,code:integer;
begin
  val(RecStuff.Planet, planet, code);
  if (Planet > 5) OR (Planet < 1) then RecStuff.Planet := '1';
  if RecStuff.Planet = '1' then StartGalactron;
  if RecStuff.Planet = '2' then WaterWorld;
  if RecStuff.Planet = '3' then IcePlanet;
  if RecStuff.Planet = '4' then PreCivilization;
  if RecStuff.Planet = '5' then AlienShip;
end;

Procedure NameNow;
var leng:integer;
label endofprocedure;
begin
  sclrscr;
  door := user_first_name+' '+user_last_name;
  leng := filesizeofdata;
  if leng > 0 then begin
    For recordnum := 1 TO leng do begin
      Getplayer(recordnum);
      if ucase(RecStuff.RNam) = ucase(door) then goto endofprocedure;
    end;
  end;
  swriteln('Sorry ' + writecorrect(door) + ' you do not have a game saved here!');
  pause;
  NameSelection;
  endofprocedure:
  if (RecStuff.Lastdate = DateNow) AND (RecStuff.Currenthit <= 0) then begin
    sclrscr;
    set_color(9,0);
    swriteln( 'Sorry, ' + RecStuff.RNam + '!  You are dead for today.');
    pause;
    endnow(true);
  end;
  if (RecStuff.Currenthit <= 0) then RecStuff.Currenthit := RecStuff.TotalHit;
  if (RecStuff.Lastdate <> DateNow) then begin
    RecStuff.Currenthit := RecStuff.TotalHit;
    RecStuff.FightLeft := RecStuff.TotalFight;
    RecStuff.Flirt := false;
    RecStuff.Trip := false;
    RecStuff.SFans := false;
  end;
  MonstGet;
  PlayerDat;
  CheckEMail;
  FindPlanet;
end;

procedure memoryprint;
var pooper:text;
begin
  assign(pooper, 'memory.log');
  append(pooper);
  writeln;
  writeln('Heap Memory Available: ',memavail);
  writeln('Maximum Heap Allowed : ',maxavail);
  writeln(pooper, DATEnow + ' ' + TIME);
  writeln(pooper,'Heap Memory Available: ',memavail);
  writeln(pooper,'Maximum Heap Allowed : ',maxavail);
  writeln(pooper, '-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
  close(pooper);
end; {memoryprint}

procedure ShellToDoS;
begin
  swriteln('Please wait, your sysop has dropped to dos!');
  swapvectors;
  exec('command.com','');
  swapvectors;
  swriteln('Your sysop has returned!');
end; {shelltodos}

procedure StartGalactron;
var GalactInput:char;
begin
  repeat
    CheckTemp;
    if RecStuff.Expert = false then getscreen('{MAIN}');
    Putplayer(recordnum);
    set_color(15,0);
    Enter;
    plotplace('','','');
    GalactInput := input('esqlvhwamtxgcr');
    if GalactInput = 'E' then RecStuff.Expert := not(RecStuff.Expert);
    if GalactInput = 'S' then PlayerDat;
    if GalactInput = 'Q' then endnow(true);
    if GalactInput = 'L' then ListPlayer;
    if GalactInput = 'V' then TheArena;
    if GalactInput = 'H' then TheHotel;
    if GalactInput = 'W' then WeaponComp;
    if GalactInput = 'A' then ShieldCtr;
    if GalactInput = 'M' then MagicShop;
    if GalactInput = 'T' then TradersCorn;
    if GalactInput = 'X' then IGM;
    if GalactInput = 'G' then SendEMail;
    if GalactInput = 'C' then Tower;
    if GalactInput = 'R' then CheckEMail;
  until false=true;
end; {StartGalactron}

procedure TheArena;
var ArenaI:char;
begin
  repeat
    if not(RecStuff.Expert) then getscreen('{ARENA}');
    set_color(15,0);
    Enter;
    plotplace('Arena','','');
    ArenaI := input('shaoeq'+#13);
    if ArenaI = 'S' then ByeByeFans;
    if ArenaI = 'H' then Healers;
    if ArenaI = 'A' then UserFight;
    if ArenaI = 'O' then Cram;
    if ArenaI = 'E' then Battle;
  until ArenaI in ['Q',#13];
end; {TheArena}

procedure TheHotel;
var st:string;
    temp, ParagraphPick,a:integer;
    choice:char;
    label start;
begin
  start:
  st := (ISTR(round(TIMER div 60)));
  writeln(st);
  a := VALue(copy(st, 3,1));
  if a div 2 = round(a div 2) then ParagraphPick := 1 ELSE ParagraphPick := 2;
  if not(RecStuff.Expert) then begin
    if ParagraphPick = 1 then getscreen('{HOTEL1}');
    if ParagraphPick = 2 then getscreen('{HOTEL2}');
  end;
  set_color(15, 0);
  Enter;
  plotplace('Hotel','','');
  repeat
    Choice := input('etfcq'+#13);
    if Choice = 'E' then RecStuff.Expert := not(RecStuff.Expert);
    if Choice = 'T' then Trip(ParagraphPick);
    if Choice = 'F' then Flirt(ParagraphPick);
    if Choice = 'C' then chat;
    if Choice = '?' then goto start;
  until Choice in ['Q',#13];
end; {TheHotel}

procedure MagicShop;
var temp:integer;
    choice:char;
begin
  if RecStuff.Expert = false then getscreen('{MAGIC}');
  if temp = 1 then begin getscreen('{MAGIC}'); temp := 0; end;
  set_color(15, 0);
  Enter;
  plotplace('Magic Shop','','');
  repeat
    Choice := input('eq'+#13);
    if Choice = 'E' then RecStuff.Expert := not(RecStuff.Expert);
    if Choice = '?' then begin temp := 1; MagicShop; end;
  until Choice in ['Q',#13];
end; {MagicShop}

procedure TradersCorn;
var choice:char;
    temp:integer;
begin
  if RecStuff.Expert = false then getscreen('{TRADER}');
  if temp = 1 then begin getscreen('{TRADER}'); temp := 0; end;
  set_color(15, 0);
  Enter;
  plotplace('Trader''s Corner','','');
  repeat
    Choice := input('eswhtq'+#13);
    if Choice = 'E' then RecStuff.Expert := not(RecStuff.Expert);
    if Choice = '?' then begin temp := 1; TradersCorn;end;
    if Choice = 'S' then TradeShield;
    if Choice = 'W' then TradeWeapon;
    if Choice = 'H' then NotInstalled;
    if Choice = 'T' then NotInstalled;
  until Choice in ['Q', chr(13)];
end; {TradersCorn}

procedure Battle;
var BattleDesc:integer;
begin
  sclrscr;
  if RecStuff.FightLeft < 1 then begin
    set_color(10, 0);
    swriteln('Sorry, you are out of fights today.');
    pause;
    exit;
  end;
  if RecStuff.FightLeft > 0 then RecStuff.FightLeft := (RecStuff.FightLeft) - 1;
  Count := round(Random * MonstFlag) + 1;
  getmonster(Monst[Count]);
  BattleDesc := round(Random(2)) + 1;
  if BattleDesc = 1 then begin
    swriteln('You scroll around the large maze, feeling anxious around every');
    swriteln('corner you pass.  Awaiting a large monster to jump out at any moment.');
    swriteln('Suddenly, a ' + Monster.Nam + ' approaches from around the corner.');
    swriteln('You arm yourself for combat!');
  end;
  if BattleDesc = 2 then begin
    swriteln('You sit down by a large Oak tree and stare at the sun.  ''No use');
    swriteln('looking for an enemy... I''ll let them come to me.''  Eventually,');
    swriteln('you see a ' + Monster.Nam + ' approach.');
  end;
  fight;
end; {Battle}

Procedure Fight;
var fightin:char;
    lose:longint;
begin
  if (Monster.Health <= 0) AND (RecStuff.Currenthit > 0) then exit;
    if RecStuff.Currenthit > 0 then begin
      set_color(9, 0);
      Enter;
      spipeln(' HitPoints: (|10'+ISTR(RecStuff.Currenthit)+
              '|09 of|10 '+ISTR(RecStuff.TotalHit)+'|09)');
      spipeln(' |09Fights:|10'+ISTR(ord(RecStuff.FightLeft)));
      spipeln(' |09Gold:|10'+ISTR(RecStuff.cashonhand + RecStuff.CashInBank));
      spipeln(' |09Gems:|10 '+ISTR(ord(RecStuff.Gems)));
      spipeln(' |09(|10A|09)ttack the ' + (Monster.Nam));
      spipeln(' |09(|10F|09)ight to the Death!');
      spipeln(' |09(|12R|09)|04un away!!!');
      Enter;
      spipeln(' |09The Arena   (A,R,F)  (? for menu)');
      spipeln(' |12Yo|04ur c|08om|07mand|15, ' + (RecStuff.Nam) + '?  |10:');
    end;
    WHILE (Count <> 0) AND ((Monster.Health > 0) AND (RecStuff.Currenthit > 0)) do begin
      Fightin := input('far');
      CASE Fightin of
      'F':begin
            sclrscr;
            WHILE ((Monster.Health > 0) AND (RecStuff.Currenthit > 0)) do Battlemonster;
          end;
      'A':begin
            Battlemonster;
            pause;
            if RecStuff.FightLeft > 0 then Fight;
          end;
      'R':begin
            enter;
            swriteln('|04You run away!');
            lose := round(Random * (RecStuff.cashonhand - 0) + 1);
            spipeln('|10Unfortunately, you dropped |14' + ISTR(lose) + ' |10gold!');
            RecStuff.Cashonhand := RecStuff.CashOnHand - lose;
            RecStuff.FightLeft := ((RecStuff.FightLeft) + 1);
            swriteln('This leaves you with just '+istr(RecStuff.cashonhand)+' gold!');
            pause;
            exit;
          end;
      end;
    end;
end; {Fight}

procedure UserFight;
var loco2,locol2,doo,locold,locolold,loco,locol,a,leng:integer;
    loop,at,de:integer;
    ats,des,name:string;
    fightin, YN:char;
    UserRecord,UserHit, UserAttacks, UserDefences, UserEXP, UserCash:integer;
    Usernam,UserWeapon:string; {for competing user}
    go_on:boolean;
label Looking, found,founduser,userbat;
begin
  putplayer(recordnum);
  leng := filesizeofdata;
  sclrscr;
  set_color(8, 0);
  swrite('Find who>> ');
  LineInput(Name{,12,1});
  swriteln('ÚÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄ¿');
  swriteln('³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³');
  swriteln('ÃÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ´');
  swriteln('³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³');
  swriteln('ÃÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ´');
  swriteln('³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³');
  swriteln('ÃÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ´');
  swriteln('³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³');
  swriteln('ÀÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÙ');
  FOR a := 1 TO leng do begin
    Looking:
    if a > leng then EXIT;
    locol := (a div leng * 40) div 1 - 1;
    loco := (locol div 10);
    if locol > 9 then locol := locol - loco * 10;
    set_color(12, 0);
    sgoto_xy(3 + (loco * 2), 2 + (locol * 2)); swrite('Û');
    if a <> 1 then begin
      set_color(8, 0);
      sgoto_xy(3 + (locold * 2), 2 + (locolold * 2)); swrite('Û');
    end;
    readln;
    GETplayer(a);
    sgoto_xy(5,9+a);
    writeln(RecStuff.Nam);
    with recstuff do begin
      FOR doo := 1 TO length(ucase(Nam)) - length(ucase(Name)) + 1 do begin
        if ucase(Name) = copy(ucase(Nam), doo, length(ucase(Name))) then GOTO Found;
      end;
    end;
    locold := loco;
    locolold := locol;
    if a > leng then exit;
  end;
  set_color(8, 0);
  sgoto_xy(3 + (locold * 2), 2 + (locolold * 2));
  swrite('Û');
  set_color(7, 0);
  sgoto_xy(11,wherey);
  swrite('Don''t see ''em here!');
  pause;
  GETplayer(recordnum);
  exit;
  Found:
  set_color(12, 0);
  sgoto_xy(2 + (loco * 2), (locol * 2));swrite('ÚÁ¿');
  sgoto_xy(3 + (loco * 2), (locol * 2));swrite('´ÛÃ');
  sgoto_xy(4 + (loco * 2), (locol * 2));swrite('ÀÂÙ');
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
  set_color(7, 0);
  sgoto_xy(11,wherey);
  swriteln(' Found: ' + (RecStuff.Nam));
  swriteln(' Sector: ' + (ISTR(locol + 1)) + ', ' + ((ISTR(loco + 1))));
  swriteln(' Initial Information:');
  swriteln('  þ Weapon: ' + (RecStuff.WeaponN));
  swriteln('  þ Shielding: ' + (RecStuff.ArmorN));
  At := RecStuff.Attacks;
  De := RecStuff.Defences;
  Getplayer(recordnum);
  if At > RecStuff.Attacks then Ats := 'stronger than' ELSE Ats := 'weaker than';
  if At = RecStuff.Attacks then Ats := 'just:good as';
  if De > RecStuff.Attacks then Des := 'stronger than' ELSE Des := 'weaker than';
  if De = RecStuff.Attacks then Des := 'just:good as';
  Getplayer(a);
  swriteln('  þ His attacking strength is ' + Ats + ' yours!');
  swriteln('  þ His defensive strength is ' + Des + ' yours!');
  swrite('Is this who you''re looking for(Y/n)? ');
  YN := input('YN');
  if YN = 'N' then begin
    a := a + 1;
    set_color(7, 0);
    sgoto_xy(2 + (loco * 2), -1 + (locol * 2));
    swrite('ÚÁ¿');
    sgoto_xy(3 + (loco * 2),-1 + (locol * 2));
    swrite('´'); set_color(3, 0); swrite('Û'); set_color(7, 0); swrite('Ã');
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
    sgoto_xy(11,wherey);
    swrite(SPACE(70));
    for loop := 1 to 7 do swrite(SPACE(70));
    GOTO Looking
  end;
  GOTO founduser;
  founduser:
  UserRecord := a;
  Usernam := (RecStuff.Nam);
  UserHit := RecStuff.Currenthit;
  UserWeapon := (RecStuff.WeaponN);
  UserAttacks := RecStuff.Attacks;
  UserDefences := RecStuff.Defences;
  UserEXP := RecStuff.exper;
  UserCash := RecStuff.cashonhand;
  Getplayer(recordnum);
  if UserRecord = recordnum then begin
    swriteln('You can''t attack yourself!');
    pause;
    exit;
  end;
  if UserHit <= 0 then begin
    swriteln('Sorry, that user is dead!');
    pause;
    exit;
  end;
  repeat
    sclrscr;
    if (RecStuff.FightLeft) > 0 then RecStuff.FightLeft := ((RecStuff.FightLeft) - 1);
    if (RecStuff.FightLeft) <= 0 then begin
      set_color(10, 0);
      swrite('Sorry, you are out of fights today.');
      pause;
      exit;
    end;
    swrite('You scroll around the maze-like city streets, searching for ' + Usernam);
    UserBat:
    if RecStuff.Currenthit < 0 then exit;
    if RecStuff.Currenthit > 0 then begin
      set_color(9, 0);
      Enter;
      spipe(' HitPoints: (|10');swrite(ISTR(RecStuff.Currenthit));
      spipe('|09of|10');swrite(ISTR(RecStuff.TotalHit));spipe('|09)');
      spipe('Fights:|10');swriteln(ISTR(RecStuff.FightLeft));
      spipe('|09  Gold:|10');
      swriteln(ISTR(RecStuff.cashonhand + RecStuff.CashInBank));
      spipe('|09Gems:|10');swriteln(ISTR(ord(RecStuff.Gems)));
      spipeln('|09 The Arena   (A,R,F)  (? for menu)');
      swriteln(' Your command, ' + (RecStuff.Nam) + '?  :');
      Enter;
      spipeln(' (|10A|09)ttack ' + Usernam);
      spipeln(' (|10F|09)ight to the Death!');
      spipeln(' (|10R|09)un away!!!');
      set_color(10, 0);
    end;
    Enter;
    Enter;
    set_color(9, 0);
    spipe(' |12You|04r cho|08ice|07, warr|15ior ');
    WHILE (UserHit > 0) AND (RecStuff.Currenthit > 0) do begin
      Fightin := input('far');
      CASE Fightin of
        'F':begin
              sclrscr;
              WHILE ((UserHit > 0) AND (RecStuff.Currenthit > 0)) do
              UserBattle(Usernam, UserHit, UserAttacks, UserDefences, UserWeapon, UserEXP, UserRecord, UserCash);
            end;
        'A':begin
              UserBattle(Usernam, UserHit, UserAttacks, UserDefences, UserWeapon, UserEXP, UserRecord, UserCash);
              GOTO UserBat;
            end;
        'R':begin
              swrite('You run away!');
              RecStuff.FightLeft := ((RecStuff.FightLeft) + 1);
              go_on := false;
            end;
      end;
    end;
  until not go_on;
end; {UserFight}

procedure WeaponComp;
var temp:integer;
    choice:char;
begin
  repeat
    if not(RecStuff.Expert) then getscreen('{WEAPON}');
    set_color(15, 0);
    Enter;
    plotplace('Weapon Store','','');
    Choice := input('sblq'+#13);
    if Choice = 'S' then sellweapon;
    if Choice = 'B' then BuyWeapon;
    if Choice = 'L' then ListWeapon;
  until choice in ['Q', chr(13)];
end; {WeaponComp}

procedure ShieldCtr;
var choice:char;
begin
  repeat
    if RecStuff.Expert = false then getscreen('{ARMOR}');
    set_color(15, 0);
    Enter;
    plotplace('Advanced Shielding','','');
    Choice:=input('bslq'+#13);
    if Choice = 'B' then BuyArmor;
    if Choice = 'S' then sellarmor;
    if Choice = 'L' then ListArmor;
  until choice in ['Q',#13];
end; {ShieldCtr}

procedure sellarmor;
var fudge:integer;
    a:char;
begin
  if (RecStuff.ArmorN) = 'Hands' then begin
    swrite('    "Ahahahaha... you are a fool!"  He grabs your hands and throws');
    swrite('  then down into two large bracelets and locks them shut.  He picks up an');
    swrite('  axe and........"');
    set_color(4, 0); swrite('AHHHHHHHHHHHHHHHH!!!!!!!!"');
    RecStuff.Currenthit := 0;
    pause;
    endnow(true);
  end;
  Enter;
  swrite(SPACE(5)+ 'So... you want to sell that ' + (RecStuff.ArmorN) + '??  I''ll take it off your hands');
  randomize;
  fudge := round(Random * (RecStuff.ArmorC div 10)) - (RecStuff.ArmorC div 20);
  enter;
  swrite(SPACE(3)+ 'for no more than...' + ((ISTR(RecStuff.ArmorC + fudge))) + '!  So, what do you think? [Y/N]');
  a:=input('yn');
  enter;
  if ucase(a) = 'Y' then begin
    swrite(space(5)+ 'DEAL!');
    RecStuff.cashonhand := RecStuff.cashonhand + RecStuff.ArmorC;
    RecStuff.Defences := RecStuff.Defences - RecStuff.ArmorD;
    RecStuff.ArmorN := 'Skin';
  end;
  if ucase(a) = 'N' then swrite(space(5)+ 'Okay, fine! Get out!');
  pause;
end; {SellArmor}

procedure sellweapon;
var fudge:integer;
    a:char;
begin
  if (RecStuff.WeaponN) = 'Hands' then begin
    swrite('    "Ahahahaha... you are a fool!"  He grabs your hands and throws');
    swrite('  then down into two large bracelets and locks them shut.  He picks up an');
    swrite('  axe and........"');
    set_color(4, 0); swrite('AHHHHHHHHHHHHHHHH!!!!!!!!'); set_color(9, 0); swrite('"');
    RecStuff.Currenthit := 0;
    pause;
    endnow(true);
  end;
  enter;
  swrite(space(5)+ 'So... you want to sell that ' + (RecStuff.WeaponN) + '??  I''ll take it off your hands');
  randomize;
  fudge := round(Random * (RecStuff.WeaponC div 10)) - (RecStuff.WeaponC div 20);
  enter;
  swrite(spacE(3)+ 'for no more than...' + ((ISTR(RecStuff.WeaponC + fudge))) + '!  So, what do you think? [Y/N]');
  a:=input('yn');
  enter;
  if ucase(a) = 'Y' then begin
    swrite(space(5)+ 'DEAL!');
    RecStuff.cashonhand := RecStuff.cashonhand + RecStuff.WeaponC + fudge;
    RecStuff.Attacks := RecStuff.Attacks - RecStuff.WeaponS;
    RecStuff.WeaponN := 'Hands';
  end;
  if ucase(a) = 'N' then swrite(space(5)+ 'Okay, fine! Get out!');
  pause;
end; {SellWeapon}

procedure oldmainmenu;
begin
    set_color(9,0);
    SCenterText('Galactic Warriors Tournament v0.055a');
    if reg then SCenterText('This is a Registered Version')
      else SCenterText('This is an UnRegistered Version');
    SCenterText('Created by: GWT Coders');
    SCenterText('Programmed by:');
    set_color(2, 0);
    SCenterText('Jeff Biermann');
    SCenterText('Brian Baskin');
    set_color(9, 0);
    SCenterText('and');
    set_color(2, 0);
    SCenterText('Geoff Rivell');
    set_color(9, 0);
    if not(reg) then begin
      SCenterText('Encourage your sysop to register this');
      SCenterText('door, or maybe you can... it''s only $15!');
    end;
    SCenterText('Bätà Täst BBS at (609)769-1619 (14.4k)');
    enter;
    set_color(12,0);
    SCenterText(' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
end;

procedure mainmenu;
var plus:integer;
begin
  set_color(current_foreground,0);
  sclrscr;
  Enter;
  sgoto_xy(10,1); set_color(15,0);
  swriteln('ú');
  sgoto_xy(39,wherey);
  set_color(7,0);
  swriteln('ú');
  sgoto_xy(22,2);
  spipe('|15G|07a|08la|12ctic Wa|04rriors Tourna|12ment v|081.|0700|15b');
  sgoto_xy(64,wherey);
  set_color(8,0);
  swrite('ú');
  sgoto_xy(71,wherey); set_color(15,0); swriteln('ú');
  IF reg THEN begin
    spipe('    |08ú');
    sgoto_xy(26,3);
    spipeln('|07T|08hi|12s is |04a Registere|12d Ver|08si|70o|15n')
  end
  ELSE begin
    sgoto_xy(24,3);
    spipeln('This|07i|08s |12an |04Unregiste|12red |08Ve|07rs|15ion    ú');
  END;
  sgoto_xy(18,4); swrite('ú'); sgoto_xy(29,wherey);
  spipe('C|07r|08ea|12ted |04by|06: |04GW|12T C|08od|07e|15rs');
  sgoto_xy(63,wherey);
  set_color(8,0); swriteln('ú');
  sgoto_xy(14,5); swrite('ú'); sgoto_xy(33,wherey);
  spipe('|15P|08r|12og|06ramme|12d |08b|07y|15:');
  sgoto_xy(69,wherey);
  set_color(7,0); swrite('ú');
  sgoto_xy(75,wherey); set_color(8,0); swrite('ú');
  sgoto_xy(9,6); set_color(7,0); swrite('ú'); sgoto_xy(33,wherey);
  spipeln('|15J|07e|08f|06f |14Bie|06rm|08a|07n|15n');
  sgoto_xy(21,7); set_color(8,0); swrite('ú'); sgoto_xy(34,wherey);
  set_color(15,0);
  spipe('B|06ri|14an Ba|06sk|15in');
  sgoto_xy(60,wherey);
  set_color(7,0); swrite('ú   ');
  set_color(8,0); swrite('ú'); sgoto_xy(70,wherey); swriteln('ú');
  sgoto_xy(9,8); set_color(15,0); swrite('ú'); sgoto_xy(26,wherey);
  swrite('ú'); sgoto_xy(38,wherey); set_color(14,0); swrite('and');
  sgoto_xy(54,wherey);
  set_color(8,0); swrite('ú'); sgoto_xy(68,wherey); set_color(15,0);
  swrite('ú'); sgoto_xy(75,wherey); swriteln('ú');
  sgoto_xy(34,9); set_color(8,0);
  spipeln('G|06eo|14ff Ri|06ve|08l|15l');
  IF NOT reg THEN begin
    sgoto_xy(21,10);
    spipeln('Please reg|07is|08t|09er |06b|14y s|06en|09di|08n|07g 1|155 bucks to    |08ú');
    sgoto_xy(11, 11);set_color(7, 0);
    swrite('ú');sgoto_xy(20,wherey);set_color(15,0);
    spipe('The addre|07ss |08i|09nclu|01d|06ed |01in |09the |08d|07oc|15s, or call');
    sgoto_xy(70,wherey);set_color(7,0);swriteln('ú');
    plus := 2;
  end
  ELSE plus := 0;
  sgoto_xy(21,10 + plus);
  set_color(15,0);
  spipe('áäçà |07Tä|08sç |09BBS |01at (xxx)x|09xx-xx|08xx |07(1|154.4k)');
  sgoto_xy(65,wherey);
  swrite('ú');sgoto_xy(73,wherey);swriteln('ú');
  sgoto_xy(20,11 + plus);
  spipeln('Ir|07on |08Tow|09ers BB|01S at (609)4|0968-137|084 (|0714.|154k)');
  sgoto_xy(12 + plus, 71);set_color(8,0);swriteln('ú');
  set_color(8,7);writeline;set_color(7,0);
END;

var gcfg:file of GWTCfg;
    main:char;
begin
  ovrfilemode:=64;
  initdoordriver('gwt.ctl');
  progname := 'GWT!!!!!!!!!!!!';
  ansi:=true;
  RANDOMIZE;
{reg := true;{{}{{}{{}{{}{{}
  assign(gcfg,'gwt.cfg');
  reset(gcfg);
  read(gcfg,cfg);
  CLOSE(gcfg);
  assign(igm1, 'OUT.IGM');
  rewrite(igm1);
  CLOSE(igm1);
  {IGM;}
  if not(file_exists('Gwtplay.dat')) then makeGwtPlay;
  leng := filesizeofdata;
  iF leng <> round(leng) then begin
    swriteln('Error in GWTPLAY.DAT! Inform your sysop!');
    pause;
    halt(1);
  end;
  sclrscr;
  if ANSi then begin
    displayfile('open.ans');
    PressKey;
  end;
  repeat
    Enter;
    MainMenu;
    Enter;
    Enter;
    spipeln(' |12(|15P|12)|04la|08y t|07he ga|15me');
    spipeln(' |12(|15L|12)|04is|08t o|07f pl|15ayers');
    spipeln(' |12(|15Q|12)|04ui|08t t|07o B|15BS');
    Enter;
    set_color(9,0);
    spipe(' |12You|04r cho|08ice|07, warr|15ior ');
    recordnum := -1;
    Main := input('PLQ');
    if Main = 'P' then NameNow;
    if Main = 'L' then ListPlayer;
    if Main = 'Q' then endNow(false);
  until false=true;
end.