'$INCLUDE: 'typedef.bas'
DIM RecStuff AS RecStuff, Cave AS Cave
a$ = DATE$
datenow$ = LEFT$(a$, 2) + MID$(a$, 4, 2) + RIGHT$(a$, 2)
OPEN "OUT.IGM" FOR INPUT AS 2
LINE INPUT #2, des$
LINE INPUT #2, Nam$
CLOSE 2
OPEN "GWTPlay.dat" FOR RANDOM AS 1 LEN = LEN(RecStuff)
OPEN "CAVE.DAT" FOR RANDOM AS 2 LEN = LEN(Cave)
leng = LOF(1) / LEN(RecStuff)
Cleng = LOF(2) / LEN(Cave)
FOR record% = 1 TO leng
GET 1, record%, RecStuff
IF RTRIM$(RecStuff.Nam) = Nam$ THEN EXIT FOR
NEXT record%
FOR Crecord% = 1 TO Cleng
GET 2, Crecord%, Cave
IF RTRIM$(Cave.Nam) = RTRIM$(RecStuff.RNam) THEN EXIT FOR
NEXT Crecord%
IF RTRIM$(Cave.Nam) <> RTRIM$(RecStuff.RNam) THEN
  Crecord% = Cleng + 1
  Cave.Bless = "0"
  Cave.Nam = RTRIM$(RecStuff.RNam)
  Cave.lastdate = datenow$
  PUT 2, Crecord%, Cave
END IF
IF Cave.lastdate <> datenow$ THEN Cave.Bless = "0"
main:
CLS
COLOR 2
PRINT "Welcome to the Cavern": COLOR 10
PRINT "---------------------": COLOR 2
PRINT
PRINT "This is an example of an IGM..."
PRINT : COLOR 9
PRINT "  ("; : COLOR 11: PRINT "A"; : COLOR 9: PRINT ")"; : COLOR 3: PRINT "sk for Blessing from Code Red": COLOR 9
PRINT "  ("; : COLOR 11: PRINT "V"; : COLOR 9: PRINT ")"; : COLOR 3: PRINT "iew your stats": COLOR 9
PRINT "  ("; : COLOR 11: PRINT "Q"; : COLOR 9: PRINT ")"; : COLOR 3: PRINT "uit to game"
PRINT : COLOR 3
PRINT "Enter command: "; : a$ = UCASE$(INPUT$(1)): COLOR 11: PRINT a$
IF a$ = "Q" THEN GOTO EndOfThis
IF a$ = "A" THEN GOSUB Blessing: GOTO main
IF a$ = "V" THEN GOSUB viewstat: GOTO main
GOTO main
EndOfThis:
PUT 1, record%, RecStuff
PUT 2, Crecord%, Cave
RESET
SYSTEM
Blessing:
CLS
IF Cave.Bless = "1" THEN
  COLOR 10: PRINT "Code Red is not around...."
DO
LOOP UNTIL INKEY$ <> ""
RETURN
END IF
COLOR 10: PRINT "Asking for blessing";
FOR i = 1 TO 10
PRINT ".";
FOR m = 1 TO 200
NEXT m
NEXT i
RANDOMIZE TIMER
a = INT(RND * 4) + 1
IF a = 1 THEN
PRINT : PRINT "You get 5 hit point off! You are evil!!!!!!"
RecStuff.currenthit = RecStuff.currenthit - 5
IF RecStuff.currenthit < 1 THEN RecStuff.lastdate = datenow$
Cave.lastdate = datenow$
Cave.Bless = "1"
END IF
IF a = 2 THEN
PRINT : PRINT "You get 5 extra hitpoints!!!"
RecStuff.currenthit = RecStuff.currenthit + 5
RecStuff.totalhit = RecStuff.totalhit + 5
Cave.lastdate = datenow$
Cave.Bless = "1"
END IF
IF a = 3 THEN
PRINT : PRINT "You get $500 extra!!"
RecStuff.cashonhand = RecStuff.cashonhand + 500
Cave.lastdate = datenow$
Cave.Bless = "1"
END IF
IF a = 4 THEN
PRINT : PRINT "You get 5 extra arena fights today!"
RecStuff.FightLeft = CHR$(ASC(RecStuff.FightLeft) + 5)
Cave.lastdate = datenow$
Cave.Bless = "1"
END IF
DO
LOOP UNTIL INKEY$ <> ""
RETURN
viewstat:
CLS
IF RecStuff.Race = "1" THEN Race$ = "Humaniod"
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
IF RecStuff.Job = "1" THEN Job$ = "Sniper"
IF RecStuff.Job = "2" THEN Job$ = "GWT Officer"
IF RecStuff.Job = "3" THEN Job$ = "Mercenary"
IF RecStuff.Job = "4" THEN Job$ = "Bounty Hunter"
IF RecStuff.Job = "5" THEN Job$ = "Navigator"
IF RecStuff.Job = "6" THEN Job$ = "IP Diplomatic"
IF RecStuff.Job = "7" THEN Job$ = "Student"
IF RecStuff.Job = "8" THEN Job$ = "Arena Fighter"
IF RecStuff.Job = "9" THEN Job$ = "Self Employed"
COLOR 11
PRINT "              Galactic Warriors Tournament Personal Statistics"
COLOR 9
PRINT " -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
PRINT
COLOR 11
PRINT " Name: "; RTRIM$(RecStuff.Nam)
PRINT " Race: "; Race$
PRINT " Occupation: "; Job$
PRINT " Hit Points: "; RecStuff.currenthit; "/"; RecStuff.totalhit
PRINT " Experience: "; RecStuff.exper
PRINT " Level: "; ASC(RecStuff.Level)
PRINT " Credits In Hand: "; RecStuff.cashonhand
PRINT " Credits Compiled In Bank: "; RecStuff.cashinbank
PRINT " Attack Strength: "; RecStuff.Attacks
PRINT " Defense Strength: "; RecStuff.Defences
PRINT " Weapon: "; RecStuff.WeaponN
PRINT " Shielding: "; RecStuff.ArmorN
PRINT " Arena Fights: "; ASC(RecStuff.FightLeft); "/"; ASC(RecStuff.TotalFight)
PRINT " Magic:"; ASC(RecStuff.MagicLeft); "/"; ASC(RecStuff.TotalMagic)
PRINT
COLOR 9
PRINT " -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
COLOR 11
PRINT "                      Statistics For: "; RTRIM$(RecStuff.RNam)
COLOR 9
PRINT " -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
DO
LOOP UNTIL INKEY$ <> ""
RETURN

