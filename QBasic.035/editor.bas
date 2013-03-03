DECLARE SUB MonstGet (X!)
DECLARE SUB LvlCheck ()
DECLARE SUB CenterText (text$)
'$INCLUDE: 'typedef.bas'
COMMON SHARED RecStuff AS RecStuff
COMMON SHARED Monster AS Monster
DIM SHARED Monst(500) AS INTEGER
COMMON SHARED Monst() AS INTEGER, MonstFlag AS INTEGER, HighLvl AS INTEGER
IF COMMAND$ = "-P" THEN GOTO pack
maindisplay:
CLS
COLOR 9
CALL CenterText("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
COLOR 10
CALL CenterText("Galactic Warrior Tournament Editor")
CALL CenterText("By the programmers of GWT")
CALL CenterText("Brian Baskin, Jeff Biermann, and Geoff Rivell")
IF Reg = 1 THEN CALL CenterText("Thank you for registering!")
IF Reg = 0 THEN CALL CenterText("Cheap Bum!  Register this for your users!")
LOCATE 10, 1
COLOR 9: PRINT TAB(20); "["; : COLOR 10: PRINT "P"; : COLOR 9: PRINT "]layer Editor"; TAB(45); "["; : COLOR 10: PRINT "M"; : COLOR 9: PRINT "]onster Editor"
COLOR 9: PRINT TAB(20); "["; : COLOR 10: PRINT "!"; : COLOR 9: PRINT "]Pack User File"; TAB(45); "["; : COLOR 10: PRINT "Q"; : COLOR 9: PRINT "]uit"
LOCATE 14, 26
PRINT "You choice, effendi:"
DO
  B$ = INKEY$
  LOOP UNTIL B$ <> ""
B$ = UCASE$(B$)
IF B$ = "P" THEN GOSUB playedit
IF B$ = "M" THEN GOSUB monsteredit
IF B$ = "!" THEN GOSUB pack
IF B$ = "Q" THEN GOTO endnow
GOTO maindisplay

playedit:
OPEN "GWTPlay.dat" FOR RANDOM AS 1 LEN = LEN(RecStuff)
record% = 1
main:
leng = LOF(1) / LEN(RecStuff)
IF record% > leng THEN record% = 1
IF record% < 1 THEN record% = leng
GET 1, record%, RecStuff
CLS
PRINT "   User #"; LTRIM$(STR$(record%))
PRINT "0) Real Name: "; RTRIM$(RecStuff.RNam)
PRINT "1) Name: "; RTRIM$(RecStuff.Nam);
LOCATE , 40
PRINT "2) Password: "; RecStuff.Pword
PRINT "3) Attack:"; RecStuff.Attacks;
LOCATE , 40
PRINT "4) Defences:"; RecStuff.Defences
PRINT "5) Weapon Name: "; RTRIM$(RecStuff.WeaponN);
LOCATE , 40
PRINT "6) Armor Name: "; RTRIM$(RecStuff.ArmorN)
PRINT "7) Gold on Hand:"; RecStuff.cashonhand;
LOCATE , 40
PRINT "8) Gold in Bank:"; RecStuff.cashinbank
IF RecStuff.Race = "1" THEN Race$ = "Humanoid"
IF RecStuff.Race = "2" THEN Race$ = "Cyborg"
IF RecStuff.Race = "3" THEN Race$ = "Amphibian"
IF RecStuff.Race = "4" THEN Race$ = "Alien"
IF RecStuff.Race = "5" THEN Race$ = "Android"
IF RecStuff.Race = "6" THEN Race$ = "Quadruped"
IF RecStuff.Race = "7" THEN Race$ = "Arachnid"
IF RecStuff.Race = "8" THEN Race$ = "Mutant"
IF RecStuff.Race = "9" THEN Race$ = "Crossbreed"
IF RecStuff.Race = "0" THEN Race$ = "Telepath"
IF RecStuff.Race = "A" THEN Race$ = "Parasite"
PRINT "9) Race: "; Race$;
IF RecStuff.Job = "1" THEN Job$ = "Sniper"
IF RecStuff.Job = "2" THEN Job$ = "GWT Officer"
IF RecStuff.Job = "3" THEN Job$ = "Mercenary"
IF RecStuff.Job = "4" THEN Job$ = "Bounty Hunter"
IF RecStuff.Job = "5" THEN Job$ = "Navigator"
IF RecStuff.Job = "6" THEN Job$ = "IP Diplomatic"
IF RecStuff.Job = "7" THEN Job$ = "Student"
IF RecStuff.Job = "8" THEN Job$ = "Arena Fighter"
IF RecStuff.Job = "9" THEN Job$ = "Self Employed"
LOCATE , 40
PRINT "A) Job: "; Job$
PRINT "B) Hitpoints:"; RTRIM$(STR$(RecStuff.currenthit)); "/"; LTRIM$(STR$(RecStuff.totalhit));
LOCATE , 40
PRINT "C) Exp:"; RecStuff.exper
IF RecStuff.Sex = "1" THEN Sex$ = "Male" ELSE Sex$ = "Female"
PRINT "D) Sex: "; Sex$;
dateon$ = LEFT$(RecStuff.lastdate, 2) + "/" + MID$(RecStuff.lastdate, 3, 2) + "/" + RIGHT$(RecStuff.lastdate, 2)
LOCATE , 40
PRINT "E) Last Played: "; dateon$
PRINT "F) Gems:"; ASC(RecStuff.Gems);
LOCATE , 40
PRINT "G) Fights In Locker:"; ASC(RecStuff.LockFights)
PRINT "H) Level: "; ASC(RecStuff.Level);
IF RecStuff.SFans = "1" THEN sf$ = "Yes" ELSE sf$ = "No"
IF RecStuff.Trip = "1" THEN tr$ = "Yes" ELSE tr$ = "No"
IF RecStuff.Flirt = "1" THEN fl$ = "Yes" ELSE fl$ = "No"
LOCATE , 40
PRINT "I) Slaughtered Fan: "; sf$
PRINT "J) Tripped Bell-Boy: "; tr$;
LOCATE , 40
PRINT "K) Flirted: "; fl$
PRINT

PRINT "X to Delete, Q to Quit,  Backward,  forwards, + to Add player"
PRINT "Enter Command: ";
A$ = UCASE$(INPUT$(1)): PRINT A$
IF A$ = CHR$(0) + CHR$(75) OR A$ = "[" THEN record% = record% - 1: GOTO main
IF A$ = CHR$(0) + CHR$(77) OR A$ = "]" THEN record% = record% + 1: GOTO main
IF A$ = "0" THEN INPUT "Enter Real Name: "; RecStuff.RNam: PUT 1, record%, RecStuff: GOTO main
IF A$ = "1" THEN INPUT "Enter Name: "; RecStuff.Nam: PUT 1, record%, RecStuff: GOTO main
IF A$ = "2" THEN INPUT "Enter Password: "; RecStuff.Pword: PUT 1, record%, RecStuff: GOTO main
IF A$ = "3" THEN INPUT "Enter Attack: "; RecStuff.Attacks: PUT 1, record%, RecStuff: GOTO main
IF A$ = "4" THEN INPUT "Enter Defences: "; RecStuff.Defences: PUT 1, record%, RecStuff
IF A$ = "5" THEN INPUT "Enter Weapon Name: "; RecStuff.WeaponN: PUT 1, record%, RecStuff: GOTO main
IF A$ = "6" THEN INPUT "Enter Armor Name: "; RecStuff.ArmorN: PUT 1, record%, RecStuff: GOTO main
IF A$ = "7" THEN INPUT "Enter Gold on Hand: "; RecStuff.cashonhand: PUT 1, record%, RecStuff: GOTO main
IF A$ = "8" THEN INPUT "Enter Gold in Bank: "; RecStuff.cashinbank: PUT 1, record%, RecStuff: GOTO main
IF A$ = "9" THEN GOSUB Race: PUT 1, record%, RecStuff: GOTO main
IF A$ = "A" THEN GOSUB Job: PUT 1, record%, RecStuff: GOTO main
IF A$ = "B" THEN INPUT "Enter Current Hitpoints: "; RecStuff.currenthit: INPUT "Enter Total Hitpoints: "; RecStuff.totalhit: PUT 1, record%, RecStuff: GOTO main
IF A$ = "C" THEN INPUT "Enter Exp: "; RecStuff.exper: PUT 1, record%, RecStuff: GOTO main
IF A$ = "D" THEN GOSUB Dead: PUT 1, record%, RecStuff: GOTO main
IF A$ = "E" THEN
INPUT "Enter last played date: "; dateon$
RecStuff.lastdate = LEFT$(dateon$, 2) + MID$(dateon$, 4, 2) + RIGHT$(dateon$, 2)
PUT 1, record%, RecStuff
GOTO main
END IF
IF A$ = "F" THEN INPUT "Enter Gems: "; gem: RecStuff.Gems = CHR$(gem): PUT 1, record%, RecStuff: GOTO main
IF A$ = "G" THEN INPUT "Enter Fights In LOCker: "; lck: RecStuff.LockFights = CHR$(lck): PUT 1, record%, RecStuff: GOTO main
IF A$ = "H" THEN INPUT "Enter Level: "; lev: RecStuff.Level = CHR$(lev): PUT 1, record%, RecStuff: GOTO main
IF A$ = "I" THEN IF RecStuff.SFans = "1" THEN RecStuff.SFans = "0": PUT 1, record%, RecStuff: GOTO main ELSE RecStuff.SFans = "1": PUT 1, record%, RecStuff: GOTO main
IF A$ = "J" THEN IF RecStuff.Trip = "1" THEN RecStuff.Trip = "0": PUT 1, record%, RecStuff: GOTO main ELSE RecStuff.Trip = "1": PUT 1, record%, RecStuff: GOTO main
IF A$ = "K" THEN IF RecStuff.Flirt = "1" THEN RecStuff.Flirt = "0": PUT 1, record%, RecStuff: GOTO main ELSE RecStuff.Flirt = "1": PUT 1, record%, RecStuff: GOTO main

IF UCASE$(A$) = "X" THEN RecStuff.Nam = "X": PUT 1, record%, RecStuff: GOTO main
IF UCASE$(A$) = "+" THEN record% = leng + 1: GOTO add
IF UCASE$(A$) = "Q" THEN RESET: RETURN
GOTO main
add:
INPUT "Enter Name: "; RecStuff.Nam
INPUT "Enter Attack: "; RecStuff.Attacks
INPUT "Enter Password: "; RecStuff.Pword
INPUT "Enter Gold on Hand: "; RecStuff.cashonhand
INPUT "Enter Gold in Bank: "; RecStuff.cashinbank
GOSUB Race
GOSUB Job
INPUT "Enter Current Hitpoints: "; RecStuff.currenthit
INPUT "Enter Total Hitpoints: "; RecStuff.totalhit
INPUT "Enter Defences: "; RecStuff.Defences
INPUT "Enter Exp: "; RecStuff.exper
INPUT "Enter last played date: "; dateon$
RecStuff.lastdate = LEFT$(dateon$, 2) + MID$(dateon$, 4, 2) + RIGHT$(dateon$, 2)
INPUT "Enter Gems: "; gem: RecStuff.Gems = CHR$(gem)
INPUT "Enter Sex(M/f): "; Sex$: IF LEFT$(UCASE$(Sex$), 1) = "F" THEN RecStuff.Sex = "0" ELSE RecStuff.Sex = "1"
PUT 1, record%, RecStuff
GOTO main
Race:
CLS
PRINT "1) Humanoid"
PRINT "2) Cyborg"
PRINT "3) Amphibian"
PRINT "4) Alien"
PRINT "5) Android"
PRINT "6) Quadruped"
PRINT "7) Arachnid"
PRINT "8) Mutant"
PRINT "9) Crossbreed"
PRINT "0) Telepath"
PRINT "A) Parasite"
PRINT
PRINT "Enter Race: "; : RecStuff.Race = INPUT$(1): PRINT RecStuff.Race
IF RecStuff.Race = "1" THEN Race$ = "Humanoid": RETURN
IF RecStuff.Race = "2" THEN Race$ = "Cyborg": RETURN
IF RecStuff.Race = "3" THEN Race$ = "Amphibian": RETURN
IF RecStuff.Race = "4" THEN Race$ = "Alien": RETURN
IF RecStuff.Race = "5" THEN Race$ = "Android": RETURN
IF RecStuff.Race = "6" THEN Race$ = "Quadruped": RETURN
IF RecStuff.Race = "7" THEN Race$ = "Arachnid": RETURN
IF RecStuff.Race = "8" THEN Race$ = "Mutant": RETURN
IF RecStuff.Race = "9" THEN Race$ = "Crossbreed": RETURN
IF RecStuff.Race = "0" THEN Race$ = "Telepath": RETURN
RecStuff.Race = UCASE$(RecStuff.Race)
IF RecStuff.Race = "A" THEN Race$ = "Parasite": RETURN
GOTO Race
Job:
CLS
PRINT "1) Sniper"
PRINT "2) GWT Officer"
PRINT "3) Mercenary"
PRINT "4) Bounty Hunter"
PRINT "5) Navigator"
PRINT "6) IP Diplomatic"
PRINT "7) Student"
PRINT "8) Arena Fighter"
PRINT "9) Self Employed"
PRINT
PRINT "Enter Job: "; : RecStuff.Job = INPUT$(1): PRINT RecStuff.Job
IF RecStuff.Job = "1" THEN Job$ = "Sniper": RETURN
IF RecStuff.Job = "2" THEN Job$ = "GWT Officer": RETURN
IF RecStuff.Job = "3" THEN Job$ = "Mercenary": RETURN
IF RecStuff.Job = "4" THEN Job$ = "Bounty Hunter": RETURN
IF RecStuff.Job = "5" THEN Job$ = "Navigator": RETURN
IF RecStuff.Job = "6" THEN Job$ = "IP Diplomatic": RETURN
IF RecStuff.Job = "7" THEN Job$ = "Student": RETURN
IF RecStuff.Job = "8" THEN Job$ = "Arena Fighter": RETURN
IF RecStuff.Job = "9" THEN Job$ = "Self Employed": RETURN
GOTO Job
Dead:
IF RecStuff.Sex = "1" THEN RecStuff.Sex = "0" ELSE RecStuff.Sex = "1": RETURN
RETURN

monsteredit:
  lvl = 1
  OPEN "enemy.dat" FOR RANDOM AS 1 LEN = LEN(Monster)
  LvlCheck
openmonster:
  IF lvl > HighLvl THEN lvl = 1
  IF lvl < 1 THEN lvl = HighLvl
  IF lvl < 1 THEN lvl = 1
  COLOR 2
  MonstGet lvl
monstermain:
  mleng = LOF(1) / LEN(Monster)
  IF record% > MonstFlag THEN record% = 1
  IF record% < 1 THEN record% = MonstFlag
  IF record% < 1 THEN record% = 1
  GET 1, Monst(record%), Monster
CLS
PRINT "   Monster #"; LTRIM$(STR$(record%));
LOCATE , 40: PRINT "Level #"; LTRIM$(STR$(lvl))
COLOR 2: PRINT "1) Name: "; : COLOR 3: PRINT RTRIM$(Monster.Nam)
COLOR 2: PRINT "2) Attack: "; : COLOR 3: PRINT Monster.Attack
COLOR 2: PRINT "3) Health: "; : COLOR 3: PRINT Monster.Health
COLOR 2: PRINT "4) Gold: "; : COLOR 3: PRINT Monster.Gold
COLOR 2: PRINT "5) Saying 1: ": COLOR 3: PRINT "   "; RTRIM$(Monster.say1)
COLOR 2: PRINT "6) Saying 2: ": COLOR 3: PRINT "   "; RTRIM$(Monster.say2)
COLOR 2: PRINT "7) Saying 3: ": COLOR 3: PRINT "   "; RTRIM$(Monster.say3)
COLOR 2: PRINT "8) Saying 4: ": COLOR 3: PRINT "   "; RTRIM$(Monster.say4)
IF Monster.Sex = "1" THEN
Sex$ = "Male"
ELSE
Sex$ = "Female"
END IF
COLOR 2: PRINT "9) Sex: "; : COLOR 3: PRINT Sex$
COLOR 2: PRINT "A) Weapon: "; : COLOR 3: PRINT RTRIM$(Monster.Weapon)
COLOR 2: PRINT
PRINT "Q quit,  Backward,  Forwards,  back a level,  forward a level, + add";
PRINT "Enter Command: "; : DO: A$ = UCASE$(INKEY$): LOOP WHILE A$ = "": PRINT A$
IF A$ = CHR$(0) + CHR$(75) OR A$ = "[" THEN record% = record% - 1: GOTO monstermain
IF A$ = CHR$(0) + CHR$(77) OR A$ = "]" THEN record% = record% + 1: GOTO monstermain
IF A$ = CHR$(0) + CHR$(80) OR A$ = "<" THEN lvl = lvl - 1: GOTO openmonster
IF A$ = CHR$(0) + CHR$(72) OR A$ = ">" THEN lvl = lvl + 1: GOTO openmonster
IF A$ = "1" THEN INPUT "Enter Name: ", Monster.Nam: PUT 1, record%, Monster: GOTO monstermain
IF A$ = "2" THEN INPUT "Enter Attack: ", Monster.Attack: PUT 1, record%, Monster: GOTO monstermain
IF A$ = "3" THEN INPUT "Enter Health: ", Monster.Health: PUT 1, record%, Monster: GOTO monstermain
IF A$ = "4" THEN INPUT "Enter Gold: ", Monster.Gold: PUT 1, record%, Monster: GOTO monstermain
IF A$ = "5" THEN PRINT "Enter Saying 1: ": LINE INPUT "", Monster.say1: PUT 1, record%, Monster: GOTO monstermain
IF A$ = "6" THEN PRINT "Enter Saying 2: ": LINE INPUT "", Monster.say2: PUT 1, record%, Monster: GOTO monstermain
IF A$ = "7" THEN PRINT "Enter Saying 3: ": LINE INPUT "", Monster.say3: PUT 1, record%, Monster: GOTO monstermain
IF A$ = "8" THEN PRINT "Enter Saying 4: ": LINE INPUT "", Monster.say4: PUT 1, record%, Monster: GOTO monstermain
IF A$ = "9" THEN
IF Monster.Sex = "1" THEN
Monster.Sex = "0"
PUT 1, record%, Monster
GOTO monstermain
ELSE
Monster.Sex = "1"
PUT 1, record%, Monster
GOTO monstermain
END IF
END IF
IF UCASE$(A$) = "A" THEN INPUT "Enter Weapon Name: ", Monster.Weapon: PUT 1, record%, Monster: GOTO monstermain
IF UCASE$(A$) = "+" THEN record% = mleng + 1: GOTO addmonster
IF UCASE$(A$) = "Q" THEN RESET: RETURN
GOTO monstermain
addmonster:
INPUT "Enter Name: ", Monster.Nam
INPUT "Enter Attack: ", Monster.Attack
INPUT "Enter Health: ", Monster.Health
INPUT "Enter Gold: ", Monster.Gold
PRINT "Enter Saying 1:": LINE INPUT "", Monster.say1
PRINT "Enter Saying 2:": LINE INPUT "", Monster.say2
PRINT "Enter Saying 3:": LINE INPUT "", Monster.say3
PRINT "Enter Saying 4:": LINE INPUT "", Monster.say4
INPUT "Enter Weapon Name: ", Monster.Weapon
INPUT "M)ale of F)emale: "; Sex$
IF UCASE$(LEFT$(Sex$, 1)) = "M" THEN Monster.Sex = "1" ELSE Monster.Sex = "0"
PUT 1, record%, Monster
GOTO monstermain

pack:
l = 0
RESET
CLS : PRINT : PRINT : PRINT : PRINT "Packing player file...."
OPEN "GWTPlay.dat" FOR RANDOM AS 1 LEN = LEN(RecStuff)
OPEN "X1.X1X" FOR RANDOM AS 2 LEN = LEN(RecStuff)
record% = 1
packmain:
leng = LOF(1) / LEN(RecStuff)
IF leng = 0 THEN
COLOR 4: PRINT "Sorry, there is no player file.": RESET: KILL "GWTPlay.dat"
DO
LOOP UNTIL INKEY$ <> ""
RETURN
END IF
start:
IF record% > leng THEN GOTO endofthis
GET 1, record%, RecStuff
record% = record% + 1
IF RTRIM$(RecStuff.Nam) = "X" THEN GOTO start
l = l + 1
PUT 2, l, RecStuff
GOTO start
endofthis:
RESET
KILL "GWTPlay.Dat"
NAME "X1.X1X" AS "GWTPlay.dat"
IF COMMAND$ = "-P" THEN GOTO endnow
RETURN

endnow:
CLS
RESET
END

SUB CenterText (text$)
SHARED g
g = ((80 - LEN(text$)) / 2)
PRINT TAB(g); text$
END SUB

SUB LvlCheck
HighLvl = 0
FOR sd = 1 TO LOF(1) / LEN(Monster)
GET #1, sd, Monster
IF ASC(Monster.Level) > HighLvl THEN HighLvl = ASC(Monster.Level)
NEXT
END SUB

SUB MonstGet (X)
ERASE Monst
mleng = LOF(1) / LEN(Monster)
zx = 0
zxx = 0
DO
  IF zx = mleng THEN EXIT DO
  zx = zx + 1
  GET #1, zx, Monster
  IF ASC(Monster.Level) = X THEN
    zxx = zxx + 1
    Monst(zxx) = zx
  END IF
LOOP
MonstFlag = zxx
END SUB

