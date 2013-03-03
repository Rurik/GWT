DECLARE SUB Tower ()
DECLARE SUB TradeShield ()
DECLARE SUB TradeWeapon ()
DECLARE SUB Galactron ()
DECLARE SUB WaterWorld ()
DECLARE SUB PreCivilization ()
DECLARE SUB IcePlanet ()
DECLARE SUB AlienShip ()
DECLARE SUB MonstGet ()
DECLARE SUB QB.COLOR (Fg%, Bg%)
DECLARE SUB QB.CLS (a%)
DECLARE SUB pipe (text$, x!)
DECLARE SUB getscreen (firsttag$)
DECLARE SUB ByeByeFans ()
DECLARE SUB IGM ()
DECLARE SUB Trip (ParagraphPick!)
DECLARE SUB Flirt (ParagraphPick!)
DECLARE SUB Healers ()
DECLARE SUB pause ()
DECLARE SUB ListWeapon ()
DECLARE SUB BuyWeapon ()
DECLARE SUB ListArmor ()
DECLARE SUB BuyArmor ()
DECLARE SUB SendEMail ()
DECLARE SUB CheckTemp ()
DECLARE SUB CheckEMail ()
DECLARE SUB UserBattle (Usernam$, UserHit!, UserAttacks!, UserDefences!, UserWeapon$, UserEXP!, UserRecord!, UserCash!)
DECLARE SUB PressKey ()
DECLARE SUB EndNow ()
DECLARE SUB CenterText (text$)
DECLARE SUB Battle ()
DECLARE SUB NotInstalled ()
DECLARE SUB PlayerDat ()
DECLARE SUB ListPlayer ()
'$INCLUDE: 'typedef.bas'
COMMON SHARED RecStuff AS RecStuff, record%, reg, Monster AS Monster, DateNow$, rgbull%, ansibull%, path$, asciibull%, doodoo, boing$
DIM SHARED Monst(500) AS INTEGER
COMMON SHARED ANSi%, Monst() AS INTEGER, MonstFlag AS INTEGER
COMMON SHARED NoConvo
ON KEY(2) GOSUB pooper
KEY(2) ON
reg = 1
VIEW PRINT 1 TO 24
LOCATE , , 1, 16, 16
cfg1 = FREEFILE
OPEN "GWT.CFG" FOR INPUT SHARED AS cfg1
INPUT #1, path$
INPUT #1, rgbull%
INPUT #1, ansibull%
INPUT #1, asciibull%
INPUT #1, droppath$
INPUT #1, Fights%
INPUT #1, levels%
CLOSE cfg1
a$ = DATE$
DateNow$ = LEFT$(a$, 2) + MID$(a$, 4, 2) + RIGHT$(a$, 2)
ON ERROR GOTO Errorhandle1
igm1 = FREEFILE
OPEN "OUT.IGM" FOR INPUT SHARED AS #igm1
CLOSE igm1
IGM
door1 = FREEFILE
OPEN droppath$ + "DOOR.SYS" FOR INPUT AS #door1
FOR readdoor = 1 TO 10
  INPUT #door1, door$
NEXT readdoor
FOR readdoor = 11 TO 20
  INPUT #door1, door$
  PRINT grafix$
NEXT readdoor
CLOSE door1
door$ = RTRIM$(door$)
'CALL MonstGet: GOTO FindPlanet
IGMOUT:
ON ERROR GOTO 0
OPEN "GWTPlay.Dat" FOR RANDOM AS #1 LEN = LEN(RecStuff)
leng = LOF(1) / LEN(RecStuff)
IF leng <> INT(leng) THEN
PRINT "Error in GWTPLAY.DAT! Inform your sysop!"
pause
RESET
SYSTEM
END IF
Main:
QB.CLS -1
door1 = FREEFILE
OPEN droppath$ + "DOOR.SYS" FOR INPUT SHARED AS #door1
FOR readdoor = 1 TO 10
  INPUT #door1, door$
NEXT readdoor
FOR readdoor = 1 TO 11
  INPUT #door1, grafix$
NEXT readdoor
CLOSE door1
IF grafix$ = "GR" OR grafix$ = "RIP" THEN ANSi% = 1 ELSE ANSi% = 0
IF ANSi% THEN
ansi1 = FREEFILE
OPEN "CONS:" FOR OUTPUT SHARED AS ansi1
ansi2 = FREEFILE
OPEN "open.ans" FOR INPUT SHARED AS ansi2
DO WHILE NOT EOF(ansi2)
LINE INPUT #ansi2, a$
PRINT #ansi1, a$
LOOP
PressKey
CLOSE ansi2, ansi1
END IF
Main2:
QB.CLS -1
PRINT
QB.COLOR 9, -1
IF reg = 0 THEN reg$ = "an Unregistered"
IF reg = 1 THEN reg$ = "a Registered"
CALL CenterText("Galactic Warriors Tournament v0.035a")
CALL CenterText("This is " + reg$ + " Version")
CALL CenterText("Created by: GWT Coders")
CALL CenterText("Programmed by:")
QB.COLOR 2, -1
CALL CenterText("Jeff Biermann")
CALL CenterText("Geoff Rivell")
QB.COLOR 9, -1
CALL CenterText("and")
QB.COLOR 2, -1
CALL CenterText("Brian Baskin")
QB.COLOR 9, -1
IF reg = 0 THEN CALL CenterText("Please register by sending 15 bucks to")
IF reg = 0 THEN CALL CenterText("The address included in the docs, or call")
CALL CenterText("Iron Towers BBS at (609)468-1374 (14.4k)")
QB.COLOR 13, -1
CALL CenterText("Bätà Täst BBS @ (609)769-1619 (14.4k)")
PRINT
QB.COLOR 12, -1
CALL CenterText(" -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
PRINT
PRINT
ListIt:
QB.COLOR 9, -1
PRINT " ("; : QB.COLOR 10, -1: PRINT "P"; : QB.COLOR 9, -1: PRINT ")lay the game"
PRINT " ("; : QB.COLOR 10, -1: PRINT "L"; : QB.COLOR 9, -1: PRINT ")ist of players"
PRINT " ("; : QB.COLOR 10, -1: PRINT "Q"; : QB.COLOR 9, -1: PRINT ")uit to BBS"
QB.COLOR 12, -1
PRINT
PRINT
QB.COLOR 9, -1
PRINT " Your choice, warrior";
DO
 Main$ = INKEY$
 LOOP UNTIL Main$ <> ""
Main$ = UCASE$(Main$)
IF Main$ = "P" THEN GOTO NameNow
IF Main$ = "L" THEN CALL ListPlayer: GOTO ListIt
IF Main$ = "Q" THEN CALL EndNow
GOTO Main2

NameNow:
QB.CLS -1
leng = LOF(1) / LEN(RecStuff)
FOR record% = 1 TO leng
GET 1, record%, RecStuff
IF UCASE$(RTRIM$(RecStuff.RNam)) = UCASE$(door$) THEN GOTO foundit
NEXT record%
PRINT "Sorry "; door$; ", you do not have a game saved here!"
pause
GOTO NameSelection
foundit:
IF RecStuff.lastdate = DateNow$ AND RecStuff.currenthit <= 0 THEN QB.CLS -1: QB.COLOR 9, -1: PRINT "Sorry, "; RTRIM$(RecStuff.RNam); "!  You are dead for today.": pause: EndNow
IF RecStuff.currenthit <= 0 THEN RecStuff.currenthit = RecStuff.totalhit
IF RecStuff.lastdate <> DateNow$ THEN
RecStuff.currenthit = RecStuff.totalhit
RecStuff.FightLeft = RecStuff.TotalFight
RecStuff.Flirt = "0"
RecStuff.Trip = "0"
RecStuff.SFans = "0"
END IF
CALL MonstGet: PlayerDat: CheckEMail: GOTO FindPlanet
NameSelection:
record% = leng + 1
leng = leng + 1
GET 1, record%, RecStuff
QB.CLS -1
CenterText "Name Selection"
PRINT " -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
PRINT
INPUT " What do you want for an alias -¯>", Nam$
RecStuff.Nam = Nam$
RecStuff.RNam = door$
RecStuff.Level = CHR$(1)
RecStuff.cashonhand = 500
RecStuff.cashinbank = 0
RecStuff.currenthit = 30
RecStuff.totalhit = 30
RecStuff.Defences = 5
RecStuff.exper = 0
RecStuff.Attacks = 5
RecStuff.FightLeft = CHR$(20)
RecStuff.TotalFight = CHR$(20)
RecStuff.WeaponN = "Dagger"
RecStuff.WeaponC = 500
RecStuff.WeaponS = 2
RecStuff.ArmorN = "Wooden Shield"
RecStuff.ArmorC = 500
RecStuff.ArmorD = 2
RecStuff.Expert = "0"
RecStuff.Planet = "1"
RaceInput:
QB.CLS -1
PRINT
QB.COLOR 9, -1
CenterText "GWT Race Selection"
QB.COLOR 12, -1
PRINT " -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
PRINT
PRINT
QB.COLOR 9, -1
PRINT " ("; : QB.COLOR 10, -1: PRINT "1"; : QB.COLOR 9, -1: PRINT ") Humaniod"
PRINT " ("; : QB.COLOR 10, -1: PRINT "2"; : QB.COLOR 9, -1: PRINT ") Cyborg"
PRINT " ("; : QB.COLOR 10, -1: PRINT "3"; : QB.COLOR 9, -1: PRINT ") Amphibian"
PRINT " ("; : QB.COLOR 10, -1: PRINT "4"; : QB.COLOR 9, -1: PRINT ") Alien"
PRINT " ("; : QB.COLOR 10, -1: PRINT "5"; : QB.COLOR 9, -1: PRINT ") Android"
PRINT " ("; : QB.COLOR 10, -1: PRINT "6"; : QB.COLOR 9, -1: PRINT ") Quadruped"
PRINT " ("; : QB.COLOR 10, -1: PRINT "7"; : QB.COLOR 9, -1: PRINT ") Arachnid"
PRINT " ("; : QB.COLOR 10, -1: PRINT "8"; : QB.COLOR 9, -1: PRINT ") Mutant"
PRINT " ("; : QB.COLOR 10, -1: PRINT "9"; : QB.COLOR 9, -1: PRINT ") Crossbreed"
PRINT " ("; : QB.COLOR 10, -1: PRINT "0"; : QB.COLOR 9, -1: PRINT ") Telepath"
PRINT " ("; : QB.COLOR 10, -1: PRINT "A"; : QB.COLOR 9, -1: PRINT ") Parasite"
PRINT
PRINT " Choose your race, "; RTRIM$(RecStuff.Nam);
DO
 RaceNum$ = INKEY$
 LOOP UNTIL RaceNum$ <> ""
IF RaceNum$ = "1" THEN RecStuff.Race = "1": GOTO JobWant
IF RaceNum$ = "2" THEN RecStuff.Race = "2": GOTO JobWant
IF RaceNum$ = "3" THEN RecStuff.Race = "3": GOTO JobWant
IF RaceNum$ = "4" THEN RecStuff.Race = "4": GOTO JobWant
IF RaceNum$ = "5" THEN RecStuff.Race = "5": GOTO JobWant
IF RaceNum$ = "6" THEN RecStuff.Race = "6": GOTO JobWant
IF RaceNum$ = "7" THEN RecStuff.Race = "7": GOTO JobWant
IF RaceNum$ = "8" THEN RecStuff.Race = "8": GOTO JobWant
IF RaceNum$ = "9" THEN RecStuff.Race = "9": GOTO JobWant
IF RaceNum$ = "0" THEN RecStuff.Race = "0": GOTO JobWant
IF UCASE$(RaceNum$) = "A" THEN RecStuff.Race = "A": GOTO JobWant
GOTO RaceInput
JobWant:
QB.CLS -1
QB.COLOR 9, -1
CenterText "GWT Job Selection"
QB.COLOR 12, -1
PRINT " -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
PRINT
QB.COLOR 9, -1
PRINT
PRINT
PRINT " ("; : QB.COLOR 10, -1: PRINT "1"; : QB.COLOR 9, -1: PRINT ") Sniper"
PRINT " ("; : QB.COLOR 10, -1: PRINT "2"; : QB.COLOR 9, -1: PRINT ") GWT Officer"
PRINT " ("; : QB.COLOR 10, -1: PRINT "3"; : QB.COLOR 9, -1: PRINT ") Mercenary"
PRINT " ("; : QB.COLOR 10, -1: PRINT "4"; : QB.COLOR 9, -1: PRINT ") Bounty Hunter"
PRINT " ("; : QB.COLOR 10, -1: PRINT "5"; : QB.COLOR 9, -1: PRINT ") Navigator"
PRINT " ("; : QB.COLOR 10, -1: PRINT "6"; : QB.COLOR 9, -1: PRINT ") IP Diplomatic"
PRINT " ("; : QB.COLOR 10, -1: PRINT "7"; : QB.COLOR 9, -1: PRINT ") Student"
PRINT " ("; : QB.COLOR 10, -1: PRINT "8"; : QB.COLOR 9, -1: PRINT ") Arena Fighter"
PRINT " ("; : QB.COLOR 10, -1: PRINT "9"; : QB.COLOR 9, -1: PRINT ") Self Employed"
PRINT
PRINT
PRINT " What is your galactic job, "; RTRIM$(RecStuff.Nam);
DO
 JobNum$ = INKEY$
 LOOP UNTIL JobNum$ <> ""
 JobNum = VAL(JobNum$)
IF JobNum = 1 THEN RecStuff.Job = "1": IHaveAJob = 1
IF JobNum = 2 THEN RecStuff.Job = "2": IHaveAJob = 1
IF JobNum = 3 THEN RecStuff.Job = "3": IHaveAJob = 1
IF JobNum = 4 THEN RecStuff.Job = "4": IHaveAJob = 1
IF JobNum = 5 THEN RecStuff.Job = "5": IHaveAJob = 1
IF JobNum = 6 THEN RecStuff.Job = "6": IHaveAJob = 1
IF JobNum = 7 THEN RecStuff.Job = "7": IHaveAJob = 1
IF JobNum = 8 THEN RecStuff.Job = "8": IHaveAJob = 1
IF JobNum = 9 THEN RecStuff.Job = "9": IHaveAJob = 1
IF IHaveAJob = 0 THEN GOTO JobWant
HereSex:
QB.CLS -1
CenterText "Sex Selection"
PRINT " -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
PRINT
PRINT " So, are you ("; : QB.COLOR 10, -1: PRINT "M"; : QB.COLOR 9, -1: PRINT ")ale or ("; : QB.COLOR 10, -1: PRINT "F"; : QB.COLOR 9, -1: PRINT ")emale?";
sex$ = INPUT$(1)
sex$ = UCASE$(sex$)
IF sex$ = "M" THEN RecStuff.sex = "1": SEXSEX = 1
IF sex$ = "F" THEN RecStuff.sex = "0": SEXSEX = 1
IF SEXSEX <> 1 THEN GOTO HereSex:

PUT 1, record%, RecStuff
'CALL MonstGet: PlayerDat: GOTO FindPlanet


FindPlanet:
IF VAL(RecStuff.Planet) > 5 OR VAL(RecStuff.Planet) < 1 THEN RecStuff.Planet = "1"
IF RecStuff.Planet = "1" THEN Galactron
IF RecStuff.Planet = "2" THEN WaterWorld
IF RecStuff.Planet = "3" THEN IcePlanet
IF RecStuff.Planet = "4" THEN PreCivilization
IF RecStuff.Planet = "5" THEN AlienShip
' should never get here... everything should go to the SUB EndNow

Errorhandle1:
RESUME IGMOUT

pooper:
PRINT " Stack Space Free :"; FRE(-2)
PRINT " NonString Array Free :"; FRE(-1)
PRINT " String space free :"; FRE("")
PRINT " Next String space :"; FRE(1)
RETURN

SUB AlienShip
END SUB

SUB ByeByeFans
IF RecStuff.SFans = "1" THEN PRINT "You have had your chance already!": pause: EXIT SUB

QB.CLS -1
QB.COLOR 8, -1
CenterText "Slaughtering Fans"
RANDOMIZE TIMER
fannies = INT(RND * 4) + 1
IF fannies = 1 THEN
  PRINT "   You see an old woman hobble onto the Arena looking confused and"
  PRINT "upset.  She continually whispers, 'poo-poo.... poo-poooo'. You can"
  PRINT "only imagine she must be looking for her poodle. You believe that"
  PRINT "she will make a good target."
  pause
  gen$ = "her"
END IF
IF fannies = 2 THEN
  PRINT "   You see one fan up in a tree watching the fights. He's wearing"
  PRINT "torn clothes and looks sickly. You hear a cracking sound as a branch"
  PRINT "breaks and he falls to your feet."
  pause
  gen$ = "him"
END IF
IF fannies = 3 THEN
  PRINT "   A drunken man hobbling down the steps of the surrounding half"
  PRINT "stadium and trips on an unseen beer can. He soars through the air"
  PRINT "and lands face first onto the dirt floor of the Arena."
  pause
  gen$ = "him"
END IF
IF fannies = 4 THEN
  PRINT "   You wait in the Arena for a target to come into your sight, but you"
  PRINT "cannot find anyone. Immpatiently you relieve the gate of its lock with"
  PRINT "your " + RTRIM$(RecStuff.WeaponN) + " and proceed into a crowd of fans. Dragging a fan from "
  PRINT "the crowd was easier than you thought."
  pause
  gen$ = "him"
END IF
DO
PRINT
PRINT "You can either (K)ill " + gen$ + ", or (C)hicken out!"
DO: F$ = UCASE$(INKEY$): LOOP WHILE F$ = ""
IF F$ = "K" OR F$ = "C" THEN EXIT DO
LOOP
IF F$ = "K" THEN
   fudge = INT(RND * ((RecStuff.cashonhand + RecStuff.cashinbank) * .2))
   PRINT "You easily kill " + gen$ + ", and in " + gen$ + " pockets you find" + STR$(fudge) + "in creds."
   RecStuff.cashonhand = RecStuff.cashonhand + fudge
   pause
   IF INT(RND * 4) + 1 = 1 THEN
      darn = INT(RND * ASC(RecStuff.FightLeft)) + 1
      PRINT "   As you turn around you notice a crowd of angry fans charging toward you."
      PRINT "You realize there is no where to run so you rap your arms around your "
      PRINT "head and fall to the ground. You're beaten unconscious and miss" + STR$(darn)
      PRINT "of your fights."
      RecStuff.FightLeft = CHR$(ASC(RecStuff.FightLeft) - darn)
      pause
   END IF
END IF
IF F$ = "C" THEN
   PRINT "bock bock bock bock 'CHICKEN!!!!!!!!!!!!!!!!'": pause
END IF
RecStuff.SFans = "1"
END SUB

SUB Galactron
StartGalactron:
CheckTemp
IF VAL(RecStuff.Expert) = 0 THEN getscreen "{MAIN}"
IF temp = 1 THEN getscreen "{MAIN}": temp = 0
'Screen.Galactron
PUT 1, record%, RecStuff
GalInput:
QB.COLOR 15, 0
PRINT
PRINT " Locale "; : QB.COLOR 7, 0: PRINT ">"; : QB.COLOR 8, 0: PRINT "> "; : QB.COLOR 11, 0: PRINT "Galactron"
QB.COLOR 12, 0: PRINT " <"; : QB.COLOR 4, 0: PRINT "<"; : QB.COLOR 12, 0: PRINT "? "; : QB.COLOR 4, 0: PRINT "- "; : QB.COLOR 12, 0: PRINT "Menu"; : QB.COLOR 4, 0: PRINT ">"; : QB.COLOR 12, 0: PRINT "> "; : QB.COLOR 6, 0: PRINT "Your choice"; :  _
QB.COLOR 14, 0: PRINT ", "; : QB.COLOR 15, 0: PRINT RTRIM$(RecStuff.Nam); " ";
DO
 GalactInput$ = INKEY$
 LOOP UNTIL GalactInput$ <> ""
GalactInput$ = UCASE$(GalactInput$)
PRINT GalactInput$
IF GalactInput$ = "E" THEN IF RecStuff.Expert = "0" THEN RecStuff.Expert = "1" ELSE RecStuff.Expert = "0"
IF GalactInput$ = "S" THEN PlayerDat
IF GalactInput$ = "Q" THEN EndNow
IF GalactInput$ = "L" THEN ListPlayer
IF GalactInput$ = "V" THEN GOTO TheArena
IF GalactInput$ = "H" THEN GOTO TheHotel
IF GalactInput$ = "W" THEN GOTO WeaponComp
IF GalactInput$ = "A" THEN GOTO ShieldCtr
IF GalactInput$ = "M" THEN GOTO MagicShop
IF GalactInput$ = "T" THEN GOTO TradersCorn
IF GalactInput$ = "X" THEN IGM
IF GalactInput$ = "G" THEN SendEMail
IF GalactInput$ = "C" THEN Tower
IF GalactInput$ = "R" THEN CheckEMail
IF GalactInput$ = "?" THEN temp = 1: GOTO StartGalactron
GOTO StartGalactron

TheArena:
IF VAL(RecStuff.Expert) = 0 THEN getscreen "{ARENA}"
IF temp = 1 THEN getscreen "{ARENA}": temp = 0
'Screen.Arena
QB.COLOR 15, -1
PRINT
PRINT " Locale "; : QB.COLOR 7, 0: PRINT ">"; : QB.COLOR 8, 0: PRINT "> "; : QB.COLOR 11, 0: PRINT "Galactron "; : QB.COLOR 3, 0: PRINT ">"; : QB.COLOR 9, 0: PRINT " Arena"
QB.COLOR 12, 0: PRINT " <"; : QB.COLOR 4, 0: PRINT "<"; : QB.COLOR 12, 0: PRINT "? "; : QB.COLOR 4, 0: PRINT "- "; : QB.COLOR 12, 0: PRINT "Menu"; : QB.COLOR 4, 0: PRINT ">"; : QB.COLOR 12, 0: PRINT "> "; : QB.COLOR 6, 0: PRINT "Your choice"; :  _
QB.COLOR 14, 0: PRINT ", "; : QB.COLOR 15, 0: PRINT RTRIM$(RecStuff.Nam); " ";
DO
 TheArena$ = INKEY$
 LOOP UNTIL TheArena$ <> ""
TheArena$ = UCASE$(TheArena$)
PRINT TheArena$
IF TheArena$ = "S" THEN CALL ByeByeFans
IF TheArena$ = "H" THEN CALL Healers
IF TheArena$ = "A" THEN GOSUB UserFight
IF TheArena$ = "O" THEN GOSUB Cram
IF TheArena$ = "E" THEN GOSUB Battle
IF TheArena$ = "Q" OR ASC(TheArena$) = 13 THEN GOTO StartGalactron
IF TheArena$ = "?" THEN temp = 1: GOTO TheArena
GOTO TheArena

TheHotel:
st$ = RTRIM$(LTRIM$(STR$(INT(TIMER / 60))))
a = VAL(MID$(st$, 3, 1))
IF a / 2 = INT(a / 2) THEN ParagraphPick = 1 ELSE ParagraphPick = 2
IF VAL(RecStuff.Expert) = 0 THEN
  IF ParagraphPick = 1 THEN getscreen "{HOTEL1}": 'Screen.Hotel.1
  IF ParagraphPick = 2 THEN getscreen "{HOTEL2}": 'Screen.Hotel.2
END IF
IF temp = 1 THEN
  IF ParagraphPick = 1 THEN getscreen "{HOTEL1}": 'Screen.Hotel.1
  IF ParagraphPick = 2 THEN getscreen "{HOTEL2}": 'Screen.Hotel.2
  temp = 0
END IF
QB.COLOR 15, -1
PRINT
PRINT " Locale "; : QB.COLOR 7, 0: PRINT ">"; : QB.COLOR 8, 0: PRINT "> "; : QB.COLOR 11, 0: PRINT "Galactron "; : QB.COLOR 3, 0: PRINT ">"; : QB.COLOR 13, 0: PRINT " Hotel"
QB.COLOR 12, 0: PRINT " <"; : QB.COLOR 4, 0: PRINT "<"; : QB.COLOR 12, 0: PRINT "? "; : QB.COLOR 4, 0: PRINT "- "; : QB.COLOR 12, 0: PRINT "Menu"; : QB.COLOR 4, 0: PRINT ">"; : QB.COLOR 12, 0: PRINT "> "; : QB.COLOR 6, 0: PRINT "Your choice"; :  _
QB.COLOR 14, 0: PRINT ", "; : QB.COLOR 15, 0: PRINT RTRIM$(RecStuff.Nam); " ";
DO
 Choice$ = INKEY$
 LOOP UNTIL Choice$ <> ""
Choice$ = UCASE$(Choice$)
PRINT Choice$
IF Choice$ = "E" THEN IF RecStuff.Expert = "0" THEN RecStuff.Expert = "1" ELSE RecStuff.Expert = "0"
IF Choice$ = "T" THEN CALL Trip(ParagraphPick)
IF Choice$ = "F" THEN CALL Flirt(ParagraphPick)
IF Choice$ = "Q" OR ASC(Choice$) = 13 THEN GOTO StartGalactron
IF Choice$ = "C" THEN GOSUB Chat
IF Choice$ = "?" THEN temp = 1: GOTO TheHotel
GOTO TheHotel

MagicShop:    
IF VAL(RecStuff.Expert) = 0 THEN getscreen "{MAGIC}"
IF temp = 1 THEN getscreen "{MAGIC}": temp = 0
'Screen.Magic
QB.COLOR 15, -1
PRINT
PRINT " Locale "; : QB.COLOR 7, 0: PRINT ">"; : QB.COLOR 8, 0: PRINT "> "; : QB.COLOR 11, 0: PRINT "Galactron "; : QB.COLOR 3, 0: PRINT ">"; : QB.COLOR 13, 0: PRINT " Magic Shop"
QB.COLOR 12, 0: PRINT " <"; : QB.COLOR 4, 0: PRINT "<"; : QB.COLOR 12, 0: PRINT "? "; : QB.COLOR 4, 0: PRINT "- "; : QB.COLOR 12, 0: PRINT "Menu"; : QB.COLOR 4, 0: PRINT ">"; : QB.COLOR 12, 0: PRINT "> "; : QB.COLOR 6, 0: PRINT "Your choice"; :  _
QB.COLOR 14, 0: PRINT ", "; : QB.COLOR 15, 0: PRINT RTRIM$(RecStuff.Nam); " ";
DO
 Choice$ = INKEY$
 LOOP UNTIL Choice$ <> ""
Choice$ = UCASE$(Choice$)
PRINT Choice$
IF Choice$ = "E" THEN IF RecStuff.Expert = "0" THEN RecStuff.Expert = "1" ELSE RecStuff.Expert = "0"
IF Choice$ = "Q" OR ASC(Choice$) = 13 THEN GOTO StartGalactron
IF Choice$ = "?" THEN temp = 1: GOTO MagicShop
GOTO MagicShop

TradersCorn:
IF VAL(RecStuff.Expert) = 0 THEN getscreen "{TRADER}"
IF temp = 1 THEN getscreen "{TRADER}": temp = 0
'Screen.Traders
QB.COLOR 15, -1
PRINT
PRINT " Locale "; : QB.COLOR 7, 0: PRINT ">"; : QB.COLOR 8, 0: PRINT "> "; : QB.COLOR 11, 0: PRINT "Galactron "; : QB.COLOR 3, 0: PRINT ">"; : QB.COLOR 9, 0: PRINT " Trader's Corner"
QB.COLOR 12, 0: PRINT " <"; : QB.COLOR 4, 0: PRINT "<"; : QB.COLOR 12, 0: PRINT "? "; : QB.COLOR 4, 0: PRINT "- "; : QB.COLOR 12, 0: PRINT "Menu"; : QB.COLOR 4, 0: PRINT ">"; : QB.COLOR 12, 0: PRINT "> "; : QB.COLOR 6, 0: PRINT "Your choice"; :  _
QB.COLOR 14, 0: PRINT ", "; : QB.COLOR 15, 0: PRINT RTRIM$(RecStuff.Nam); " ";
DO
 Choice$ = INKEY$
 LOOP UNTIL Choice$ <> ""
Choice$ = UCASE$(Choice$)
PRINT Choice$
IF Choice$ = "E" THEN IF RecStuff.Expert = "0" THEN RecStuff.Expert = "1" ELSE RecStuff.Expert = "0"
IF Choice$ = "Q" OR ASC(Choice$) = 13 THEN GOTO StartGalactron
IF Choice$ = "?" THEN temp = 1: GOTO TradersCorn
IF Choice$ = "S" THEN CALL TradeShield
IF Choice$ = "W" THEN CALL TradeWeapon
IF Choice$ = "H" THEN CALL NotInstalled
IF Choice$ = "T" THEN CALL NotInstalled
GOTO TradersCorn


Battle:
QB.CLS -1
IF ASC(RecStuff.FightLeft) < 1 THEN QB.COLOR 10, -1: PRINT "Sorry, you are out of fights today.": pause: RETURN
IF ASC(RecStuff.FightLeft) > 0 THEN RecStuff.FightLeft = CHR$(ASC(RecStuff.FightLeft) - 1)
RANDOMIZE TIMER
MonsterFile$ = "Enemy.Dat"
OPEN MonsterFile$ FOR RANDOM AS #2 LEN = LEN(Monster)
count = INT(RND * MonstFlag) + 1
GET 2, Monst(count), Monster
BattleDesc = INT(RND * 2) + 1
IF BattleDesc = 1 THEN
  PRINT "You scroll around the large maze, feeling anxious around every"
  PRINT "corner you pass.  Awaiting a large monster to jump out at any moment."
  PRINT "Suddenly, a "; RTRIM$(Monster.Nam); " approaches from around the corner."
  PRINT "You arm yourself for combat!"
ELSEIF BattleDesc = 2 THEN
  PRINT "You sit down by a large Oak tree and stare at the sun.  `No use"
  PRINT "looking for an enemy... I'll let them come to me.'  Eventually,"
  PRINT "you see a "; RTRIM$(Monster.Nam); " approach."
END IF
Fight:
IF Monster.Health <= 0 AND RecStuff.currenthit > 0 THEN
  CLOSE 2
  RETURN
END IF
IF RecStuff.currenthit > 0 THEN
QB.COLOR 9, -1
PRINT
PRINT " HitPoints: ("; : QB.COLOR 10, -1: PRINT RecStuff.currenthit; : QB.COLOR 9, -1: PRINT "of"; : QB.COLOR 10, -1: PRINT RecStuff.totalhit;
                            QB.COLOR 9, -1: PRINT ")  Fights:"; : QB.COLOR 10, -1: PRINT ASC(RecStuff.FightLeft);
                            QB.COLOR 9, -1: PRINT "  Gold:"; : QB.COLOR 10, -1: PRINT RecStuff.cashonhand + RecStuff.cashinbank; : QB.COLOR 9, -1
                            PRINT "Gems:"; : QB.COLOR 10, -1: PRINT ASC(RecStuff.Gems): QB.COLOR 9, -1
PRINT " The Arena   (A,R,F)  (? for menu)"
PRINT " Your command, "; RTRIM$(RecStuff.Nam); "?  :"
PRINT
PRINT " ("; : QB.COLOR 10, -1: PRINT "A"; : QB.COLOR 9, -1: PRINT ")ttack the "; RTRIM$(Monster.Nam)
PRINT " ("; : QB.COLOR 10, -1: PRINT "F"; : QB.COLOR 9, -1: PRINT ")ight to the Death!"
PRINT " ("; : QB.COLOR 10, -1: PRINT "R"; : QB.COLOR 9, -1: PRINT ")un away!!!"
QB.COLOR 10, -1
END IF
PRINT
PRINT
QB.COLOR 9, -1
PRINT " Your choice, warrior";
WHILE count <> 0 AND ((Monster.Health > 0) AND (RecStuff.currenthit > 0))
 DO
  Fight$ = INKEY$
  LOOP UNTIL Fight$ <> ""
 Fight$ = UCASE$(Fight$)
 SELECT CASE Fight$
        CASE "F"
         QB.CLS -1
          DO WHILE ((Monster.Health > 0) AND (RecStuff.currenthit > 0))
           CALL Battle
          LOOP
         CASE "A"
           CALL Battle
          GOTO Fight
         CASE "R"
          PRINT "You run away!": RecStuff.FightLeft = CHR$(ASC(RecStuff.FightLeft) + 1)
          PRINT "Unfortunately, you dropped"; INT(RND * (RecStuff.cashonhand - 0) + 1); "gold!"
          CLOSE 2
          RETURN
 END SELECT
WEND
CLOSE 2
RETURN

Cram:
doodoo = 0
IF RecStuff.cashonhand <> 0 THEN doodoo = doodoo + 1
IF ASC(RecStuff.LockFights) <> 0 THEN doodoo = doodoo + 1
IF ASC(RecStuff.FightLeft) <> 0 THEN doodoo = doodoo + 1
IF VAL(RecStuff.Expert) = 0 THEN getscreen "{LOCKER}"
IF temp = 1 THEN getscreen "{LOCKER}": temp = 0
'Screen.Locker (doodoo)

'boing2$ = "": effer = LEN(LTRIM$(RTRIM$(STR$(RecStuff.cashonhand))))
'IF INT(effer / 3) = effer / 3 THEN effer = (effer + INT(effer / 3) - 1) ELSE effer = (effer + INT(effer / 3))
'boing2$ = STRING$(effer, "#") + ","

'LOCATE 10 + doodoo, 29
'QB.COLOR 8: PRINT "c"; : QB.COLOR 7: PRINT USING boing$; RecStuff.CashInBank

'doodoodoo = 0
'IF ASC(RecStuff.LockFights) <> 0 THEN
'QB.COLOR 1, -1
'doodoodoo = doodoodoo + 1
'LOCATE 7 + doodoodoo, 4
'PRINT
'LOCATE , 4: PRINT "þ Y"; : QB.COLOR 9,-1: PRINT "ou also find a receipt for "; : QB.COLOR 1: PRINT LTRIM$(RTRIM$(STR$(ASC(RecStuff.LockFights)))); : QB.COLOR 9: PRINT " fights on one of the shelves"; : QB.COLOR 1: PRINT "."
'END IF
'QB.COLOR 9, -1
'IF RecStuff.CashOnHand <> 0 THEN doodoodoo = doodoodoo + 1: LOCATE 8 + doodoodoo, 4: QB.COLOR 1: PRINT "þ I"; : QB.COLOR 9: PRINT "n your pocket you find"; : QB.COLOR 1: PRINT USING boing2$; RecStuff.CashOnHand; : QB.COLOR 9: PRINT " credits"; : QB.COLOR 1: PRINT "."
'IF ASC(RecStuff.FightLeft) <> 0 THEN doodoodoo = doodoodoo + 1: LOCATE 8 + doodoodoo, 4: QB.COLOR 1: PRINT "þ Y"; : QB.COLOR 9: PRINT "ou have"; : QB.COLOR 1: PRINT ASC(RecStuff.FightLeft); : QB.COLOR 9: PRINT "fights planned for today"; : QB.COLOR 1: PRINT "."
QB.COLOR 15, -1
PRINT
PRINT " Locale "; : QB.COLOR 7, 0: PRINT ">"; : QB.COLOR 8, 0: PRINT "> "; : QB.COLOR 11, 0: PRINT "Galactron "; : QB.COLOR 3, 0: PRINT ">"; : QB.COLOR 9, 0: PRINT " Arena "; : QB.COLOR 1, 0: PRINT ">"; : QB.COLOR 13, 0: PRINT " Locker"
QB.COLOR 12, 0: PRINT " <"; : QB.COLOR 4, 0: PRINT "<"; : QB.COLOR 12, 0: PRINT "? "; : QB.COLOR 4, 0: PRINT "- "; : QB.COLOR 12, 0: PRINT "Menu"; : QB.COLOR 4, 0: PRINT ">"; : QB.COLOR 12, 0: PRINT "> "; : QB.COLOR 6, 0: PRINT "Your choice"; :  _
QB.COLOR 14, 0: PRINT ", "; : QB.COLOR 15, 0: PRINT RTRIM$(RecStuff.Nam); " ";
Locker$ = UCASE$(INPUT$(1))
PRINT Locker$
IF Locker$ = "E" THEN IF VAL(RecStuff.Expert) = 1 THEN RecStuff.Expert = "0" ELSE RecStuff.Expert = "1"
IF Locker$ = "C" THEN
   PRINT
   INPUT " Enter the amount to compile - ", Comp$
   IF VAL(Comp$) = 0 OR Comp$ = "" THEN PRINT : PRINT " Nothing Done!": WHILE INKEY$ = "": WEND: GOTO Cram
   IF VAL(Comp$) < 1 THEN PRINT : PRINT " Negative and non-numeric amounts are illegal!": WHILE INKEY$ = "": WEND: GOTO Cram
   IF VAL(Comp$) > RecStuff.cashonhand THEN PRINT : PRINT " Credit batch too large!": WHILE INKEY$ = "": WEND: GOTO Cram
   RecStuff.cashonhand = RecStuff.cashonhand - VAL(Comp$)
   RecStuff.cashinbank = RecStuff.cashinbank + VAL(Comp$)
   PRINT
   PRINT " Compilation Complete!": WHILE INKEY$ = "": WEND
END IF
IF Locker$ = "D" THEN
   PRINT
   INPUT " Enter the amount to decompile - ", DeComp$
   IF VAL(DeComp$) = 0 OR DeComp$ = "" THEN PRINT : PRINT " Nothing Done!": WHILE INKEY$ = "": WEND: GOTO Cram
   IF VAL(DeComp$) < 1 THEN PRINT : PRINT " Negative and non-numeric amounts are illegal!": WHILE INKEY$ = "": WEND: GOTO Cram
   IF VAL(DeComp$) > RecStuff.cashinbank THEN PRINT : PRINT " Credit batch too large!": WHILE INKEY$ = "": WEND: GOTO Cram
   RecStuff.cashonhand = RecStuff.cashonhand + VAL(DeComp$)
   RecStuff.cashinbank = RecStuff.cashinbank - VAL(DeComp$)
   PRINT
   PRINT " Decompilation Complete!": WHILE INKEY$ = "": WEND
END IF
IF Locker$ = "S" THEN
   PRINT
   INPUT " Enter the amount to save - ", Save$
   IF VAL(Save$) = 0 OR Save$ = "" THEN PRINT : PRINT " Nothing Done!": WHILE INKEY$ = "": WEND: GOTO Cram
   IF VAL(Save$) < 1 THEN PRINT : PRINT " Negative and non-numeric amounts are illegal!": WHILE INKEY$ = "": WEND: GOTO Cram
   IF VAL(Save$) > ASC(RecStuff.FightLeft) THEN PRINT : PRINT " You don't have that many on you!": WHILE INKEY$ = "": WEND: GOTO Cram
   IF VAL(Save$) + ASC(RecStuff.LockFights) > 255 THEN PRINT : PRINT " You can only save 255 fights!": WHILE INKEY$ = "": WEND: GOTO Cram
   RecStuff.FightLeft = CHR$(ASC(RecStuff.FightLeft) - VAL(Save$))
   RecStuff.LockFights = CHR$(ASC(RecStuff.LockFights) + VAL(Save$))
   PRINT
   PRINT " Storage Complete!": WHILE INKEY$ = "": WEND
END IF
IF Locker$ = "R" THEN
   PRINT
   INPUT " Enter the amount to redeem - ", Redeem$
   IF VAL(Redeem$) = 0 OR Redeem$ = "" THEN PRINT : PRINT " Nothing Done!": WHILE INKEY$ = "": WEND: GOTO Cram
   IF VAL(Redeem$) < 1 THEN PRINT : PRINT " Negative and non-numeric amounts are illegal!": WHILE INKEY$ = "": WEND: GOTO Cram
   IF VAL(Redeem$) > ASC(RecStuff.LockFights) THEN PRINT : PRINT " Your receipts show you don't have that many saved!": WHILE INKEY$ = "": WEND: GOTO Cram
   IF VAL(Redeem$) + ASC(RecStuff.FightLeft) > 255 THEN PRINT : PRINT " You may only plan ahead for 255 fights!": WHILE INKEY$ = "": WEND: GOTO Cram
   RecStuff.FightLeft = CHR$(ASC(RecStuff.FightLeft) + VAL(Redeem$))
   RecStuff.LockFights = CHR$(ASC(RecStuff.LockFights) - VAL(Redeem$))
   PRINT
   PRINT " Redemption Complete!": WHILE INKEY$ = "": WEND
END IF
IF Locker$ = "?" THEN temp = 1: GOTO Cram
IF Locker$ = "Q" OR ASC(Locker$) = 13 THEN RETURN
PUT 1, record%, RecStuff
GOTO Cram


UserFight:
PUT 1, record%, RecStuff
CLOSE 1
OPEN "GWTPLAY.DAT" FOR RANDOM AS 1 LEN = LEN(RecStuff)
leng = LOF(1) / LEN(RecStuff)
QB.CLS -1
QB.COLOR 8, -1
INPUT "Find who>> ", Name$
PRINT "ÚÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄÂÄ¿"
PRINT "³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³"
PRINT "ÃÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ´"
PRINT "³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³"
PRINT "ÃÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ´"
PRINT "³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³"
PRINT "ÃÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ´"
PRINT "³ ³ ³ ³ ³ ³ ³ ³ ³ ³ ³"
PRINT "ÀÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÁÄÙ"
FOR a = 1 TO leng
Looking:
  IF a > leng THEN EXIT FOR
  locol = (a / leng * 40) \ 1 - 1
  loco = (locol \ 10)
  IF locol > 9 THEN locol = locol - loco * 10
  QB.COLOR 12, -1
  LOCATE 3 + (loco * 2), 2 + (locol * 2): PRINT "Û";
  IF a <> 1 THEN
    QB.COLOR 8, -1
    LOCATE 3 + (locold * 2), 2 + (locolold * 2): PRINT "Û";
  END IF
  GET 1, a, RecStuff
  FOR doo = 1 TO LEN(LCASE$(RTRIM$(RecStuff.Nam))) - LEN(LCASE$(Name$)) + 1
    IF LCASE$(Name$) = MID$(LCASE$(RTRIM$(RecStuff.Nam)), doo, LEN(LCASE$(Name$))) THEN GOTO Found
  NEXT
  locold = loco
  locolold = locol
  IF a > leng THEN EXIT FOR
NEXT
QB.COLOR 8, -1
LOCATE 3 + (locold * 2), 2 + (locolold * 2): PRINT "Û";
QB.COLOR 7, -1
LOCATE 11, 1: PRINT "Don't see 'em here!"
pause
GET 1, record%, RecStuff
RETURN

Found:
QB.COLOR 12, -1
LOCATE 2 + (loco * 2), 1 + (locol * 2): PRINT "ÚÁ¿";
LOCATE 3 + (loco * 2), 1 + (locol * 2): PRINT "´ÛÃ";
LOCATE 4 + (loco * 2), 1 + (locol * 2): PRINT "ÀÂÙ";
FOR locol2 = 1 TO locol * 2
  LOCATE 3 + (loco * 2), locol2: PRINT "Ä";
NEXT
FOR locol2 = locol * 2 + 4 TO 21
  LOCATE 3 + (loco * 2), locol2: PRINT "Ä";
NEXT
FOR loco2 = 2 TO loco * 2 + 1
  LOCATE loco2, locol * 2 + 2: PRINT "³";
NEXT
FOR loco2 = (loco * 2) + 5 TO 10
  LOCATE loco2, locol * 2 + 2: PRINT "³";
NEXT
LOCATE 11, 1
QB.COLOR 7, -1
PRINT " Found: "; RTRIM$(RecStuff.Nam)
PRINT " Sector: "; LTRIM$(RTRIM$(STR$(locol + 1))); ", "; LTRIM$(RTRIM$(STR$(loco + 1)))
PRINT " Initial Information:"
PRINT "  þ Weapon: "; RTRIM$(RecStuff.WeaponN)
PRINT "  þ Shielding: "; RTRIM$(RecStuff.ArmorN)
At = RecStuff.Attacks
De = RecStuff.Defences
GET 1, record%, RecStuff
IF At > RecStuff.Attacks THEN At$ = "stronger than" ELSE At$ = "weaker than"
IF At = RecStuff.Attacks THEN At$ = "just as good as"
IF De > RecStuff.Attacks THEN De$ = "stronger than" ELSE De$ = "weaker than"
IF De = RecStuff.Attacks THEN De$ = "just as good as"
GET 1, a, RecStuff
PRINT "  þ His attacking strength is " + At$ + " yours!"
PRINT "  þ His defensive strength is " + De$ + " yours!"
INPUT "Is this who you're looking for(Y/n)?", YN$
YN$ = UCASE$(LEFT$(YN$, 1))
IF YN$ = "N" THEN
  a = a + 1
  QB.COLOR 7, -1
  LOCATE 2 + (loco * 2), 1 + (locol * 2): PRINT "ÚÁ¿";
  LOCATE 3 + (loco * 2), 1 + (locol * 2): PRINT "´"; : QB.COLOR 3, -1: PRINT "Û"; : QB.COLOR 7, -1: PRINT "Ã";
  LOCATE 4 + (loco * 2), 1 + (locol * 2): PRINT "ÀÂÙ";
  FOR locol2 = 1 TO locol * 2
    LOCATE 3 + (loco * 2), locol2: PRINT "Ä";
  NEXT
  FOR locol2 = locol * 2 + 4 TO 21
    LOCATE 3 + (loco * 2), locol2: PRINT "Ä";
  NEXT
  FOR loco2 = 2 TO loco * 2 + 1
    LOCATE loco2, locol * 2 + 2: PRINT "³";
  NEXT
  FOR loco2 = (loco * 2) + 5 TO 10
    LOCATE loco2, locol * 2 + 2: PRINT "³";
  NEXT
  LOCATE 11, 1
  PRINT SPACE$(70): PRINT SPACE$(70): PRINT SPACE$(70): PRINT SPACE$(70)
  PRINT SPACE$(70): PRINT SPACE$(70): PRINT SPACE$(70): PRINT SPACE$(70)
  GOTO Looking
END IF
GOTO founduser

'QB.CLS
'QB.COLOR 5: INPUT "Who would you like to attack -¯>", Nam$
'IF LTRIM$(RTRIM$(Nam$)) = "X" OR RTRIM$(Nam$) = "" THEN GOTO ShitNotHere
'FOR UserRecord = 1 TO leng
'GET 1, UserRecord, RecStuff
'FOR searchlen = 1 TO LEN(Nam$)
'  IF MID$(UCASE$(RTRIM$(RecStuff.Nam)), searchlen, LEN(Nam$)) = UCASE$(Nam$) THEN
'  QB.COLOR 5: PRINT "Found: "; : QB.COLOR 6: PRINT RecStuff.Nam; : QB.COLOR 5: PRINT "... Is this who ya want? [Y/N] ";
'  inputyn$ = UCASE$(INPUT$(1)): PRINT inputyn$
'  IF inputyn$ = "Y" THEN GOTO founduser
'  END IF
'NEXT searchlen
'NEXT UserRecord
'ShitNotHere:
'PRINT "Sorry, that person is not playing this game!"
'Pause
'QB.CLS
'GET 1, Record%, RecStuff
'RETURN
founduser:
UserRecord = a
Usernam$ = RTRIM$(RecStuff.Nam)
UserHit = RecStuff.currenthit
UserWeapon$ = RTRIM$(RecStuff.WeaponN)
UserAttacks = RecStuff.Attacks
UserDefences = RecStuff.Defences
UserEXP = RecStuff.exper
UserCash = RecStuff.cashonhand
GET 1, record%, RecStuff
IF UserRecord = record% THEN PRINT "You can't attack yourself!": pause: RETURN
IF UserHit <= 0 THEN PRINT "Sorry, that user is dead!": pause: RETURN
QB.CLS -1
IF ASC(RecStuff.FightLeft) > 0 THEN RecStuff.FightLeft = CHR$(ASC(RecStuff.FightLeft) - 1)
IF ASC(RecStuff.FightLeft) <= 0 THEN QB.COLOR 10, -1: PRINT "Sorry, you are out of fights today.": pause: RETURN
RANDOMIZE TIMER
PRINT "You scroll around the maze-like city streets, searching for "; Usernam$
UserBat:
IF RecStuff.currenthit < 0 THEN RETURN
IF RecStuff.currenthit > 0 THEN
QB.COLOR 9, -1
PRINT
PRINT " HitPoints: ("; : QB.COLOR 10, -1: PRINT RecStuff.currenthit; : QB.COLOR 9, -1: PRINT "of"; : QB.COLOR 10, -1: PRINT RecStuff.totalhit; : QB.COLOR 9, -1: PRINT ")  Fights:"; : QB.COLOR 10, -1
                    PRINT ASC(RecStuff.FightLeft); : QB.COLOR 9, -1: PRINT "  Gold:"; : QB.COLOR 10, -1: PRINT RecStuff.cashonhand + RecStuff.cashinbank;
                    QB.COLOR 9, -1: PRINT "Gems:"; : QB.COLOR 10, -1: PRINT ASC(RecStuff.Gems): QB.COLOR 9, -1
PRINT " The Arena   (A,R,F)  (? for menu)"
PRINT " Your command, "; RTRIM$(RecStuff.Nam); "?  :"
PRINT
PRINT " ("; : QB.COLOR 10, -1: PRINT "A"; : QB.COLOR 9, -1: PRINT ")ttack "; Usernam$
PRINT " ("; : QB.COLOR 10, -1: PRINT "F"; : QB.COLOR 9, -1: PRINT ")ight to the Death!"
PRINT " ("; : QB.COLOR 10, -1: PRINT "R"; : QB.COLOR 9, -1: PRINT ")un away!!!"
QB.COLOR 10, -1
END IF
PRINT
PRINT
QB.COLOR 9, -1
PRINT " Your choice, warrior";
WHILE UserHit > 0 AND RecStuff.currenthit > 0
 DO
  Fight$ = INKEY$
  LOOP UNTIL Fight$ <> ""
 Fight$ = UCASE$(Fight$)
 SELECT CASE Fight$
        CASE "F"
         QB.CLS -1
          DO WHILE ((UserHit > 0) AND (RecStuff.currenthit > 0))
           CALL UserBattle(Usernam$, UserHit, UserAttacks, UserDefences, UserWeapon$, UserEXP, UserRecord, UserCash)
          LOOP
         CASE "A"
           CALL UserBattle(Usernam$, UserHit, UserAttacks, UserDefences, UserWeapon$, UserEXP, UserRecord, UserCash)
          GOTO UserBat
         CASE "R"
          PRINT "You run away!": RecStuff.FightLeft = CHR$(ASC(RecStuff.FightLeft) + 1)
RETURN
 END SELECT
WEND
RETURN


Chat:
NoConvo = 0: i = 0: marker = 0: a = 0: m = 0: R = 1
xyz = FREEFILE
OPEN "CONVO.TXT" FOR BINARY SHARED AS xyz
IF LOF(xyz) = 0 THEN NoConvo = 1: CLOSE xyz: KILL "CONVO.TXT": GOTO createchat
CLOSE xyz
OPEN "CONVO.TXT" FOR INPUT SHARED AS xyz
REDIM GetIt$(25), by$(13), msg$(13)
DO
a = a + 1
LINE INPUT #xyz, GetIt$(a)
LOOP UNTIL EOF(xyz)
CLOSE xyz
IF INT(a / 2) <> a / 2 THEN KILL "CONVO.TXT": a = 0: QB.CLS -1: NoConvo = 1: GOTO createchat
FOR i = 1 TO a
IF INT(i / 2) <> i / 2 THEN by$(R) = GetIt$(i)
IF INT(i / 2) = i / 2 THEN msg$(R) = GetIt$(i): R = R + 1
NEXT i
R = R - 1
QB.CLS -1
QB.COLOR 15, -1
PRINT "                            Ú"; : QB.COLOR 7, -1: PRINT "["; : QB.COLOR 11, -1: PRINT "Player Conversations"; : QB.COLOR 7, -1: PRINT "]"; : QB.COLOR 15, -1: PRINT "¿"
QB.COLOR 8, -1
PRINT "ÚÄÄÄÄÄÄÄ"; : QB.COLOR 7, -1: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄ"; : QB.COLOR 15, -1: PRINT "ÄÄÄÄÄÄÄÙ"; : QB.COLOR 8, -1: PRINT "ÄÄÄÄÄÄÄÄ"; : QB.COLOR 7, -1: PRINT "ÄÄÄÄÄÄÄÄ"; : QB.COLOR 15, -1: PRINT "ÄÄÄÄÄÄÙ"; : QB.COLOR 8, -1: PRINT "ÄÄÄÄÄÄÄÄ"; :  _
QB.COLOR 7, -1: PRINT "ÄÄÄÄÄÄÄÄÄ"; : QB.COLOR 15, -1: PRINT "ÄÄÄÄÄÄÄÄ¿"
FOR m = 1 TO R
'ÚÂ¿ÀÙÄ
QB.COLOR 8, -1
PRINT "³"; : QB.COLOR 15, -1: PRINT "  ÚÄ"; : QB.COLOR 7, -1: PRINT "ÄÄÄ"; : QB.COLOR 8, -1: PRINT "Ä["; : QB.COLOR 11, -1: PRINT RTRIM$(by$(m)); : QB.COLOR 8, -1: PRINT "]";
Kool = 78 - (LEN(RTRIM$(by$(m))) + 12)
QB.COLOR 15, -1
PRINT SPC(Kool); "³"
QB.COLOR 7, -1
PRINT "ÀÄ"; : QB.COLOR 15, -1: PRINT "ÄÁ"; : QB.COLOR 7, -1: PRINT "Ä"; : QB.COLOR 8, -1: PRINT "["; : QB.COLOR 9, -1: PRINT msg$(m); : QB.COLOR 8, -1: PRINT "]";
Cool = 78 - (LEN(msg$(m)) + 7) - 1
Cool2 = Cool \ 3
Cool = Cool - Cool2
QB.COLOR 8, -1
FOR QwErTy = 1 TO Cool2: PRINT "Ä"; : NEXT
Cool2 = Cool \ 2
Cool = Cool - Cool2
QB.COLOR 7, -1
FOR QwErTy = 1 TO Cool2: PRINT "Ä"; : NEXT
QB.COLOR 15, -1
FOR QwErTy = 1 TO Cool: PRINT "Ä"; : NEXT
IF m <> R THEN PRINT "´"
IF m = R THEN PRINT "Ù"
NEXT m
PRINT
QB.COLOR 7, -1
PRINT "("; : QB.COLOR 8, -1: PRINT "A"; : QB.COLOR 7, -1: PRINT ")"; : QB.COLOR 8, -1: PRINT "dd to List or "; : QB.COLOR 15, -1: PRINT "("; : QB.COLOR 7, -1: PRINT "ENTER"; : QB.COLOR 15, -1: PRINT ")"; : QB.COLOR 7, -1: PRINT " to continue"; :  _
QB.COLOR 15, -1: PRINT ": "; : a$ = UCASE$(INPUT$(1)):                                                           PRINT a$;
IF a$ = "A" THEN GOTO createchat
IF a$ = CHR$(13) THEN RETURN
GOTO Chat
createchat:
QB.COLOR 9, -1
PRINT : PRINT "Enter the message:": QB.COLOR 11, -1
INPUT "", thismsg$
IF LEN(thismsg$) > 65 THEN GOTO createchat
IF INT(a / 2) <> a / 2 OR NoConvo = 1 THEN
OPEN "convo.txt" FOR OUTPUT AS xyz
PRINT #xyz, RTRIM$(RecStuff.Nam)
PRINT #xyz, thismsg$
CLOSE xyz
ELSE
OPEN "convo.tmp" FOR OUTPUT AS xyz
IF R > 9 THEN startin = 2 ELSE startin = 1
FOR m = startin TO R
PRINT #xyz, by$(m)
PRINT #xyz, msg$(m)
NEXT m
PRINT #xyz, RTRIM$(RecStuff.Nam)
PRINT #xyz, thismsg$
CLOSE xyz
KILL "convo.txt"
NAME "convo.tmp" AS "convo.txt"
END IF
RETURN

WeaponComp:
IF VAL(RecStuff.Expert) = 0 THEN getscreen "{WEAPON}"
IF temp = 1 THEN getscreen "{WEAPON}": temp = 0
'Screen.Weapon
QB.COLOR 15, -1
PRINT
PRINT " Locale "; : QB.COLOR 7, 0: PRINT ">"; : QB.COLOR 8, 0: PRINT "> "; : QB.COLOR 11, 0: PRINT "Galactron "; : QB.COLOR 3, 0: PRINT ">"; : QB.COLOR 9, 0: PRINT " Weapon Complex"
QB.COLOR 12, 0: PRINT " <"; : QB.COLOR 4, 0: PRINT "<"; : QB.COLOR 12, 0: PRINT "? "; : QB.COLOR 4, 0: PRINT "- "; : QB.COLOR 12, 0: PRINT "Menu"; : QB.COLOR 4, 0: PRINT ">"; : QB.COLOR 12, 0: PRINT "> "; : QB.COLOR 6, 0: PRINT "Your choice"; :  _
QB.COLOR 14, 0: PRINT ", "; : QB.COLOR 15, 0: PRINT RTRIM$(RecStuff.Nam); " ";
Choice$ = UCASE$(INPUT$(1))
PRINT Choice$
IF Choice$ = "S" THEN GOSUB sellweapon
IF Choice$ = "B" THEN CALL BuyWeapon
IF Choice$ = "L" THEN CALL ListWeapon
IF Choice$ = "Q" OR ASC(Choice$) = 13 THEN GOTO StartGalactron
IF Choice$ = "?" THEN temp = 1: GOTO WeaponComp
GOTO WeaponComp
ShieldCtr:
IF VAL(RecStuff.Expert) = 0 THEN getscreen "{ARMOR}"
IF temp = 1 THEN getscreen "{ARMOR}": temp = 0
'Screen.Shielding
QB.COLOR 15, -1
PRINT
PRINT " Locale "; : QB.COLOR 7, 0: PRINT ">"; : QB.COLOR 8, 0: PRINT "> "; : QB.COLOR 11, 0: PRINT "Galactron "; : QB.COLOR 3, 0: PRINT ">"; : QB.COLOR 9, 0: PRINT " Advanced Shielding"
QB.COLOR 12, 0: PRINT " <"; : QB.COLOR 4, 0: PRINT "<"; : QB.COLOR 12, 0: PRINT "? "; : QB.COLOR 4, 0: PRINT "- "; : QB.COLOR 12, 0: PRINT "Menu"; : QB.COLOR 4, 0: PRINT ">"; : QB.COLOR 12, 0: PRINT "> "; : QB.COLOR 6, 0: PRINT "Your choice"; :  _
QB.COLOR 14, 0: PRINT ", "; : QB.COLOR 15, 0: PRINT RTRIM$(RecStuff.Nam); " ";
Choice$ = UCASE$(INPUT$(1))
PRINT Choice$
IF Choice$ = "B" THEN CALL BuyArmor
IF Choice$ = "S" THEN GOSUB sellarmor
IF Choice$ = "L" THEN CALL ListArmor
IF Choice$ = "Q" OR ASC(Choice$) = 13 THEN GOTO StartGalactron
IF Choice$ = "?" THEN temp = 1: GOTO ShieldCtr
GOTO ShieldCtr

sellarmor:
IF RTRIM$(RecStuff.ArmorN) = "Hands" THEN
    PRINT "    "; CHR$(34); "Ahahahaha... you are a fool!"; CHR$(34); " He grabs your hands and throws"
    PRINT "  then down into two large bracelets and locks them shut.  He picks up an"
    PRINT "  axe and........"; CHR$(34): QB.COLOR 4, -1: PRINT "AHHHHHHHHHHHHHHHH!!!!!!!!"; : QB.COLOR 4, -1: PRINT CHR$(34)
    RecStuff.currenthit = 0
    pause
    CALL EndNow
END IF
PRINT TAB(5); "So... you want to sell that "; RTRIM$(RecStuff.ArmorN); "??  I'll take it off your hands"
RANDOMIZE TIMER
fudge = INT(RND * (RecStuff.ArmorC / 10)) - (RecStuff.ArmorC / 20)
PRINT TAB(3); "for no more than..."; LTRIM$(RTRIM$(STR$(RecStuff.ArmorC + fudge))); "!  So, what do you think? [Y/N]"
a$ = ""
DO UNTIL a$ <> ""
 a$ = INPUT$(1)
LOOP
IF UCASE$(a$) = "Y" THEN PRINT TAB(5); "DEAL!": RecStuff.cashonhand = RecStuff.cashonhand + RecStuff.ArmorC: RecStuff.Defences = RecStuff.Defences - RecStuff.ArmorD: RecStuff.ArmorN = "Skin"
IF UCASE$(a$) = "N" THEN PRINT TAB(5); "Okay, fine! Get out!"
pause
RETURN

sellweapon:
IF RTRIM$(RecStuff.WeaponN) = "Hands" THEN
    PRINT "    "; CHR$(34); "Ahahahaha... you are a fool!"; CHR$(34); " He grabs your hands and throws"
    PRINT "  then down into two large bracelets and locks them shut.  He picks up an"
    PRINT "  axe and........"; CHR$(34); : QB.COLOR 4, -1: PRINT "AHHHHHHHHHHHHHHHH!!!!!!!!"; : QB.COLOR 9, -1: PRINT CHR$(34)
    RecStuff.currenthit = 0
    pause
    CALL EndNow
END IF
PRINT TAB(5); "So... you want to sell that "; RTRIM$(RecStuff.WeaponN); "??  I'll take it off your hands"
RANDOMIZE TIMER
fudge = INT(RND * (RecStuff.WeaponC / 10)) - (RecStuff.WeaponC / 20)
PRINT TAB(3); "for no more than..."; LTRIM$(RTRIM$(STR$(RecStuff.WeaponC + fudge))); "!  So, what do you think? [Y/N]"
a$ = ""
DO UNTIL a$ <> ""
 a$ = INPUT$(1)
LOOP
IF UCASE$(a$) = "Y" THEN PRINT TAB(5); "DEAL!": RecStuff.cashonhand = RecStuff.cashonhand + RecStuff.WeaponC + fudge: RecStuff.Attacks = RecStuff.Attacks - RecStuff.WeaponS: RecStuff.WeaponN = "Hands"
IF UCASE$(a$) = "N" THEN PRINT TAB(5); "Okay, fine! Get out!"
pause
RETURN
END SUB

SUB getscreen (firsttag$)
lala = FREEFILE
OPEN "menutxt" + RecStuff.Planet + ".dat" FOR INPUT SHARED AS lala
DO
INPUT #lala, dummy$
LOOP UNTIL dummy$ = firsttag$ OR EOF(lala)
IF dummy$ = firsttag$ THEN
  DO
    IF NOT EOF(lala) THEN LINE INPUT #lala, dummy$
    IF LEFT$(dummy$, 1) <> "{" THEN CALL pipe(dummy$, 1)
  LOOP UNTIL LEFT$(dummy$, 1) = "{"
ELSE
  PRINT firsttag$; " missing from menu file!"
END IF
CLOSE lala
END SUB

SUB IcePlanet
END SUB

SUB IGM
QB.CLS -1
DIM a$(500), descr$(250), file$(250)
IF record% THEN
        PUT 1, record%, RecStuff
ELSE
        OPEN "OUT.IGM" FOR INPUT AS 1
        LINE INPUT #1, des$
        LINE INPUT #1, Nam$
        CLOSE 1
        OPEN "GWTPlay.Dat" FOR RANDOM AS 1 LEN = LEN(RecStuff)
        leng = LOF(1) / LEN(RecStuff)
        FOR record% = 1 TO leng
        GET 1, record%, RecStuff
        IF RTRIM$(RecStuff.Nam) = Nam$ THEN EXIT FOR
        NEXT record%
        KILL "OUT.IGM"
        KILL "IGM.BAT"
END IF
IF RecStuff.lastdate = DateNow$ AND RecStuff.currenthit = 0 THEN QB.CLS -1: QB.COLOR 9, -1: PRINT "You are dead for today.": pause: EndNow
xyz = FREEFILE
OPEN "IGM.DAT" FOR BINARY SHARED AS xyz
IF LOF(xyz) = 0 THEN CLOSE xyz: KILL "IGM.DAT": PRINT "No IGM's!": pause: EXIT SUB
CLOSE xyz
OPEN "IGM.DAT" FOR INPUT SHARED AS xyz
DO
e = e + 1
LINE INPUT #xyz, a$(e)
LOOP UNTIL EOF(xyz)
' IF INT(e / 2) <> e / 2 THEN QB.CLS : PRINT "IGM.DAT is messed up!": CLOSE xyz: pause: EXIT SUB
igmstart:
total = 0: a = 0
FOR i = 1 TO e
IF LTRIM$(RTRIM$(a$(i))) = "" THEN GOTO skip
IF LEFT$(a$(i), 1) = ";" THEN GOTO skip
R = R + 1
IF a = 0 THEN a = 1 ELSE a = 0
IF a = 1 THEN descr$(R) = a$(i): total = total + 1: QB.COLOR 8, -1: PRINT "("; : QB.COLOR 10, -1: PRINT LTRIM$(STR$(total)); : QB.COLOR 8, -1: PRINT ")"; : QB.COLOR 2, -1: PRINT RTRIM$(descr$(R))
IF a = 0 THEN file$(R) = a$(i)
skip:
NEXT i
PRINT
QB.COLOR 2, -1: INPUT "Enter Command (Q)uit: ", b$
IF b$ = "" THEN GOTO igmstart
IF UCASE$(b$) = "Q" THEN CLOSE xyz: EXIT SUB
IF VAL(b$) < 1 THEN GOTO igmstart
IF VAL(b$) > total THEN GOTO igmstart
CLOSE xyz
OPEN "IGM.BAT" FOR OUTPUT AS xyz
PRINT #xyz, file$(VAL(b$) * 2)
PRINT #xyz, "GWT.BAT"
CLOSE xyz
OPEN "OUT.IGM" FOR OUTPUT AS xyz
PRINT #xyz, descr$(VAL(b$))
PRINT #xyz, RTRIM$(RecStuff.Nam)
RESET
SYSTEM
END SUB

SUB MonstGet
ERASE Monst
fff = FREEFILE
OPEN "ENEMY.DAt" FOR RANDOM SHARED AS #fff LEN = LEN(Monster)
mleng = LOF(fff) / LEN(Monster)
zx = 0
zxx = 0
DO
  IF zx = mleng THEN EXIT DO
  zx = zx + 1
  GET #fff, zx, Monster
  IF ASC(Monster.Level) = ASC(RecStuff.Level) THEN
    zxx = zxx + 1
    Monst(zxx) = zx
  END IF
LOOP
CLOSE fff
MonstFlag = zxx
END SUB

SUB PreCivilization
END SUB

SUB TradeShield
DIM Trade AS Trade
TradeFre = FREEFILE
OPEN "Trade.Dat" FOR RANDOM SHARED AS #TradeFre LEN = LEN(Trade)
TradeLen = LOF(TradeFre) / LEN(Trade)
NewLen = 0
FOR wek% = 1 TO TradeLen
GET #TradeFre, wek%, Trade
  IF Trade.Flag = "S" THEN NewLen = NewLen + 1
NEXT
Over = NewLen
IF Over > 15 THEN Over = 15
Over = 15 - Over
Over2 = (Over / 15) * 4
IF Over2 < 1 THEN Over2 = 1

TradeStart2:
IF VAL(RecStuff.Expert) = 0 THEN getscreen "{TRADEARMOR}"
IF temp = 1 THEN getscreen "{TRADEARMOR}": temp = 0
QB.COLOR 15, 0: PRINT
PRINT " Locale "; : QB.COLOR 7, 0: PRINT ">"; : QB.COLOR 8, 0: PRINT "> "; : QB.COLOR 11, 0: PRINT "Galactron "; : QB.COLOR 3, 0: PRINT ">"; : QB.COLOR 9, 0: PRINT " Trader's Corner "; : QB.COLOR 1, 0: PRINT ">"; : QB.COLOR 13, 0: PRINT  _
" Shield Trading"
QB.COLOR 12, 0: PRINT " <"; : QB.COLOR 4, 0: PRINT "<"; : QB.COLOR 12, 0: PRINT "? "; : QB.COLOR 4, 0: PRINT "- "; : QB.COLOR 12, 0: PRINT "Menu"; : QB.COLOR 4, 0: PRINT ">"; : QB.COLOR 12, 0: PRINT "> "; : QB.COLOR 6, 0: PRINT " Your choice"; :  _
QB.COLOR 14, 0: PRINT ", "; : QB.COLOR 15, 0: PRINT RTRIM$(RecStuff.Nam); " ";
DO
  Key$ = INKEY$
LOOP WHILE Key$ = ""
Key$ = LEFT$(UCASE$(Key$), 1)
PRINT Key$
IF Key$ = "L" THEN GOSUB TradeList2
IF Key$ = "?" THEN temp = 1: GOTO TradeStart2
IF Key$ = "R" OR ASC(Key$) = 13 THEN GOSUB TradeEnd2
IF Key$ = "E" THEN IF RecStuff.Expert = "0" THEN RecStuff.Expert = "1" ELSE RecStuff.Expert = "0"
GOTO TradeStart2


TradeList2:
Butt% = 0
PRINT
FOR wek% = 1 TO TradeLen
GET #TradeFre, wek%, Trade
IF Trade.Flag = "S" THEN
  Butt% = Butt% + 1
  PRINT "<"; Butt%; "> "; Trade.Nam;
  IF Trade.Much > RecStuff.ArmorD THEN
    PRINT " +"; INT(Trade.Cost * (((Trade.Much - RecStuff.ArmorD) / Trade.Much) * (Over2 / 4)))
  ELSE
    PRINT
  END IF
END IF
NEXT
PRINT
IF NewLen > 0 THEN
  PRINT " Hit 1 to"; NewLen; "for shield trading. Enter for nothing"
ELSE
  PRINT "Sorry, our trading stand isn't really doing that well!"
END IF
IF NewLen > 0 THEN
  QB.COLOR 15, 0
  PRINT
  PRINT " Locale "; : QB.COLOR 7, 0: PRINT ">"; : QB.COLOR 8, 0: PRINT "> "; : QB.COLOR 11, 0: PRINT "Galactron "; : QB.COLOR 3, 0: PRINT ">"; : QB.COLOR 9, 0: PRINT " Trader's Corner "; : QB.COLOR 1, 0: PRINT ">"; : QB.COLOR 13, 0: PRINT  _
" Shield Trading "; : QB.COLOR 5, 0: PRINT "> "; : QB.COLOR 12, 0: PRINT "List"
  QB.COLOR 6, 0: PRINT " Your choice"; : QB.COLOR 14, 0: PRINT ", "; : QB.COLOR 15, 0: PRINT RTRIM$(RecStuff.Nam); " ";
  INPUT "", FE$
  FE$ = UCASE$(FE$)

  Butt% = 0
  IF VAL(FE$) > 0 AND VAL(FE$) <= NewLen THEN
    FOR wewe% = 1 TO TradeLen
      GET #TradeFre, wewe%, Trade
      IF Trade.Flag = "S" THEN Butt% = Butt% + 1
      IF Butt% = VAL(FE$) THEN EXIT FOR
    NEXT
  PRINT
  IF Trade.Much > 0 THEN ExtraCost& = INT(Trade.Cost * (((Trade.Much - RecStuff.ArmorD) / Trade.Much) * (Over2 / 4)))
  IF RecStuff.cashonhand >= ExtraCost% THEN
  IF Trade.Much > RecStuff.ArmorD THEN
     RecStuff.cashonhand = RecStuff.cashonhand - ExtraCost&
     PRINT " " + RTRIM$(LTRIM$(STR$(ExtraCost&))) + " credits were charged for the upgrade."
  END IF
   
  IF RecStuff.ArmorD > 0 THEN
     TradeLen = TradeLen + 1
    GET TradeFre, TradeLen, Trade
     Trade.Nam = RecStuff.ArmorN
     Trade.Flag = "S"
     Trade.Cost = RecStuff.ArmorC * 2
     Trade.Much = RecStuff.ArmorD
    PUT TradeFre, TradeLen, Trade
    PRINT " Weapon traded in."
  ELSE
    NewLen = NewLen - 1
  END IF

  RecStuff.Attacks = RecStuff.Attacks - RecStuff.ArmorD
  GET TradeFre, wewe%, Trade
  RecStuff.ArmorN = Trade.Nam
  PRINT " You recieve a(n) "; Trade.Nam
  RecStuff.ArmorC = Trade.Cost / 2
  IF RecStuff.ArmorD > Trade.Much THEN endstr$ = " lost " + LTRIM$(RTRIM$(STR$(RecStuff.ArmorD - Trade.Much))) + " points of attack strength." ELSE endstr$ = " gained " + LTRIM$(RTRIM$(STR$(Trade.Much - RecStuff.ArmorD))) +  _
" points of attack strength."
  IF RecStuff.ArmorD = Trade.Much THEN endstr$ = " neither gained nor lost any points of attack strength."
  RecStuff.ArmorD = Trade.Much
  RecStuff.Attacks = RecStuff.Attacks + RecStuff.ArmorD
  PRINT " You have" + endstr$
     Trade.Nam = ""
     Trade.Flag = "X"
     Trade.Cost = 0
     Trade.Much = 0
    PUT TradeFre, wewe%, Trade
  ELSE
    PRINT " Stupid! Get some more money!"
  END IF
  ELSE
    IF VAL(FE$) < 0 OR VAL(FE$) > NewLen THEN PRINT " Idiot! Pick one that's there!"
  END IF
END IF
RETURN


TradeEnd2:
IF RecStuff.ArmorD > 0 THEN
PRINT
PRINT "    As you are about to leave an old man walks up to you and says, "; CHR$(34); "Tell ya"
PRINT " what, I'll take that shield o' yours for "; RTRIM$(LTRIM$(STR$(INT(RecStuff.ArmorC * (.5 + (Over / 15 * 1)))))); "!"; CHR$(34)
PRINT "    "; CHR$(34); "Well, yes or no???(y/N)"; CHR$(34); " ";
FE$ = UCASE$(INPUT$(1))
PRINT FE$
IF FE$ = "Y" THEN
  GET #TradeFre, TradeLen + 1, Trade
  Trade.Nam = RecStuff.ArmorN
  Trade.Much = RecStuff.ArmorD
  Trade.Cost = RecStuff.ArmorC * 2
  Trade.Flag = "S"
  PUT #TradeFre, TradeLen + 1, Trade
  RecStuff.cashonhand = RecStuff.cashonhand + INT(RecStuff.ArmorC * (.5 + (Over / 15 * 1)))
  RecStuff.Attacks = RecStuff.Attacks - RecStuff.ArmorD
  RecStuff.ArmorN = "Skin"
  RecStuff.ArmorD = 0
  RecStuff.ArmorC = 0
END IF
CLOSE TradeFre
EXIT SUB
ELSE
CLOSE TradeFre
EXIT SUB
END IF
END SUB

SUB TradeWeapon
DIM Trade AS Trade
TradeFre = FREEFILE
OPEN "Trade.Dat" FOR RANDOM SHARED AS #TradeFre LEN = LEN(Trade)
TradeLen = LOF(TradeFre) / LEN(Trade)
NewLen = 0
FOR wek% = 1 TO TradeLen
GET #TradeFre, wek%, Trade
  IF Trade.Flag = "W" THEN NewLen = NewLen + 1
NEXT
Over = NewLen
IF Over > 15 THEN Over = 15
Over = 15 - Over
Over2 = (Over / 15) * 4
IF Over2 < 1 THEN Over2 = 1

TradeStart:
IF VAL(RecStuff.Expert) = 0 THEN getscreen "{TRADEWEAPON}"
IF temp = 1 THEN getscreen "{TRADEWEAPON}": temp = 0
QB.COLOR 15, 0: PRINT
PRINT " Locale "; : QB.COLOR 7, 0: PRINT ">"; : QB.COLOR 8, 0: PRINT "> "; : QB.COLOR 11, 0: PRINT "Galactron "; : QB.COLOR 3, 0: PRINT ">"; : QB.COLOR 9, 0: PRINT " Trader's Corner "; : QB.COLOR 1, 0: PRINT ">"; : QB.COLOR 13, 0: PRINT  _
" Weapon Trading"
QB.COLOR 12, 0: PRINT " <"; : QB.COLOR 4, 0: PRINT "<"; : QB.COLOR 12, 0: PRINT "? "; : QB.COLOR 4, 0: PRINT "- "; : QB.COLOR 12, 0: PRINT "Menu"; : QB.COLOR 4, 0: PRINT ">"; : QB.COLOR 12, 0: PRINT "> "; : QB.COLOR 6, 0: PRINT " Your choice"; :  _
QB.COLOR 14, 0: PRINT ", "; : QB.COLOR 15, 0: PRINT RTRIM$(RecStuff.Nam); " ";
DO
  Key$ = INKEY$
LOOP WHILE Key$ = ""
Key$ = LEFT$(UCASE$(Key$), 1)
PRINT Key$
IF Key$ = "L" THEN GOSUB TradeList
IF Key$ = "?" THEN temp = 1: GOTO TradeStart
IF Key$ = "R" OR ASC(Key$) = 13 THEN GOSUB TradeEnd
IF Key$ = "E" THEN IF RecStuff.Expert = "0" THEN RecStuff.Expert = "1" ELSE RecStuff.Expert = "0"
GOTO TradeStart


TradeList:
Butt% = 0
PRINT
FOR wek% = 1 TO TradeLen
GET #TradeFre, wek%, Trade
IF Trade.Flag = "W" THEN
  Butt% = Butt% + 1
  PRINT "<"; Butt%; "> "; Trade.Nam;
  IF Trade.Much > RecStuff.WeaponS THEN
    PRINT " +"; INT(Trade.Cost * (((Trade.Much - RecStuff.WeaponS) / Trade.Much) * (Over2 / 4)))
  ELSE
    PRINT
  END IF
END IF
NEXT
PRINT
PRINT " Hit 1 to"; NewLen; "for weapon trading. Enter for nothing"
IF NewLen > 0 THEN
  QB.COLOR 15, 0
  PRINT
  PRINT " Locale "; : QB.COLOR 7, 0: PRINT ">"; : QB.COLOR 8, 0: PRINT "> "; : QB.COLOR 11, 0: PRINT "Galactron "; : QB.COLOR 3, 0: PRINT ">"; : QB.COLOR 9, 0: PRINT " Trader's Corner "; : QB.COLOR 1, 0: PRINT ">"; : QB.COLOR 13, 0: PRINT  _
" Weapon Trading "; : QB.COLOR 5, 0: PRINT "> "; : QB.COLOR 12, 0: PRINT "List"
  QB.COLOR 6, 0: PRINT " Your choice"; : QB.COLOR 14, 0: PRINT ", "; : QB.COLOR 15, 0: PRINT RTRIM$(RecStuff.Nam); " ";
  INPUT "", FE$
  FE$ = UCASE$(FE$)
 
  Butt% = 0
  IF VAL(FE$) > 0 AND VAL(FE$) <= NewLen THEN
    FOR wewe% = 1 TO TradeLen
      GET #TradeFre, wewe%, Trade
      IF Trade.Flag = "W" THEN Butt% = Butt% + 1
      IF Butt% = VAL(FE$) THEN EXIT FOR
    NEXT
  PRINT
  ExtraCost& = INT(Trade.Cost * (((Trade.Much - RecStuff.WeaponS) / Trade.Much) * (Over2 / 4)))
  IF RecStuff.cashonhand >= ExtraCost% THEN
  IF Trade.Much > RecStuff.WeaponS THEN
     RecStuff.cashonhand = RecStuff.cashonhand - ExtraCost&
     PRINT " " + RTRIM$(LTRIM$(STR$(ExtraCost&))) + " credits were charged for the upgrade."
  END IF
    
     TradeLen = TradeLen + 1
    GET TradeFre, TradeLen, Trade
     Trade.Nam = RecStuff.WeaponN
     Trade.Flag = "W"
     Trade.Cost = RecStuff.WeaponC * 2
     Trade.Much = RecStuff.WeaponS
    PUT TradeFre, TradeLen, Trade
    PRINT " Weapon traded in."
 
  RecStuff.Attacks = RecStuff.Attacks - RecStuff.WeaponS
  GET TradeFre, wewe%, Trade
  RecStuff.WeaponN = Trade.Nam
  PRINT " You recieve a(n) "; Trade.Nam
  RecStuff.WeaponC = Trade.Cost / 2
  IF RecStuff.WeaponS > Trade.Much THEN endstr$ = " lost " + LTRIM$(RTRIM$(STR$(RecStuff.WeaponS - Trade.Much))) + " points of attack strength." ELSE endstr$ = " gained " + LTRIM$(RTRIM$(STR$(Trade.Much - RecStuff.WeaponS))) +  _
" points of attack strength."
  IF RecStuff.WeaponS = Trade.Much THEN endstr$ = " neither gained nor lost any points of attack strength."
  RecStuff.WeaponS = Trade.Much
  RecStuff.Attacks = RecStuff.Attacks + RecStuff.WeaponS
  PRINT " You have" + endstr$
     Trade.Nam = ""
     Trade.Flag = "X"
     Trade.Cost = 0
     Trade.Much = 0
    PUT TradeFre, wewe%, Trade
  ELSE
    PRINT " Stupid! Get some more money!"
  END IF
  ELSE
    IF VAL(FE$) < 0 OR VAL(FE$) > NewLen THEN PRINT " Idiot! Pick one that's there!"
  END IF





END IF
RETURN


TradeEnd:
IF RecStuff.WeaponS > 0 THEN
PRINT
PRINT "    As you are about to leave an old man walks up to you and says, "; CHR$(34); "Tell ya"
PRINT " what, I'll take that weapon o' yours for "; RTRIM$(LTRIM$(STR$(INT(RecStuff.WeaponC * (.5 + (Over / 15 * 1)))))); "!"; CHR$(34)
PRINT "    "; CHR$(34); "Well, yes or no???(y/N)"; CHR$(34); " ";
FE$ = UCASE$(INPUT$(1))
PRINT FE$
IF FE$ = "Y" THEN
  GET #TradeFre, TradeLen + 1, Trade
  Trade.Nam = RecStuff.WeaponN
  Trade.Much = RecStuff.WeaponS
  Trade.Cost = RecStuff.WeaponC * 2
  Trade.Flag = "W"
  PUT #TradeFre, TradeLen + 1, Trade
  RecStuff.cashonhand = RecStuff.cashonhand + INT(RecStuff.WeaponC * (.5 + (Over / 15 * 1)))
  RecStuff.Attacks = RecStuff.Attacks - RecStuff.WeaponS
  RecStuff.WeaponN = "Hands"
  RecStuff.WeaponS = 0
  RecStuff.WeaponC = 0
END IF
CLOSE TradeFre
EXIT SUB
ELSE
CLOSE TradeFre
EXIT SUB
END IF
END SUB

SUB WaterWorld
END SUB

