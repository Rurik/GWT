SUB hPRINT (text$, cr)
FOR a = 1 TO LEN(text$)
  PRINT MID$(text$, a, 1);
  FOR delay = 1 TO INT(RND * (1500) + 1): NEXT delay
NEXT a
IF cr THEN PRINT
END SUB
SUB Tower
RANDOMIZE TIMER
up% = INT(RND * (5) + 1)
IF up% > 3 THEN
  qb.COLOR 3, 0
  PRINT "   You grasp onto the ladder, and start your way up the tower."; : makedot 5, 1
  PRINT " Whew, it's a long way up there!"; : makedot 4, 0: PRINT " Your arms are starting to weaken!"
  PRINT " You finally see the top ahead!"; : makedot 3, 0: PRINT "Ut oh!, Your arms are too tired!"
  PRINT " You cannot go any farther.  You glance down at the clouds below you as your"
  PRINT " arms fall from the ladder!"; : makedot 8, 1
  qb.COLOR 4, 0
  CenterText "You have died!"
  RecStuff.currenthit = 0
  pause
  CALL EndNow
ELSE
  qb.COLOR 5, 0
  PRINT "   You grasp onto the ladder, and start your way up the tower."; : makedot 5, 1
  PRINT " Whew, it's a long way up there!"; : makedot 4, 0: PRINT " Your arms are starting to weaken!"
  PRINT " You finally see the top ahead!"; : makedot 3, 0: PRINT "Ut oh!  You don't think you can make it!"
  PRINT " With your last bit of strength, you pull yourself onto the top of the tower,"
  PRINT " and crawl towards the small hut on top."
END IF
pause
inputme:
getscreen "{TOWER}"
inputmemore:
i$ = UCASE$(INPUT$(1))
IF i$ = "J" THEN GOSUB jumpofftower
IF i$ = "C" THEN GOSUB climbdowntower
IF i$ = "þ" THEN GOSUB elevator '-=<********CHEAT HEHEHE********>=-`
IF i$ = "L" THEN GOSUB citymap
IF i$ = "T" THEN GOSUB throwrox
IF i$ = "?" THEN GOTO inputme
GOTO inputmemore

jumpofftower:
qb.COLOR 4, 0
PRINT "  Are you sure you would like to commit suicide and start over??";
die$ = UCASE$(INPUT$(1)): PRINT die$
IF die$ = "N" THEN RETURN
PRINT " OK... you glance over the edge of the railing and watch the dark clouds swirl"
PRINT " into a dark vortex.  Taking a deep breath, to step forward, and gravity yanks"
PRINT " you down into the clouds. The wind blows through your hair, and for a single"
PRINT " moment, you feel at peace with the world."; : makedot 10, 0
PRINT " Then you hit the ground!"
RecStuff.RNam = "X"
pause
EndNow

throwrox:
didithit = INT(RND * (1) + 1)
PRINT " You notice a pile of large rocks in the corner.  You firmly grasp one, and walk towards"
PRINT " the edge of the tower.  Lifting the rock over your head, you throw it down towards into"
PRINT " clouds."; : makedot 10, 0:
IF didithit THEN
  PRINT "  BOOM!  You hear the crash, and a loud scream!"
ELSE
  PRINT "  BOOM!  You hear a crash."
END IF
threwrox = 1
pause
RETURN

hitsomeone:
PUT 1, record%, RecStuff
CLOSE 1
OPEN "GWTPLAY.DAT" FOR RANDOM AS 1 LEN = LEN(RecStuff)
leng = LOF(1) / LEN(RecStuff)
getauser:

a = INT(RND * (leng - 1) + 1)
IF a = record% THEN GOTO getauser
GET 1, a, RecStuff
IF RecStuff.Sex = "1" THEN Sex$ = "him" ELSE Sex$ = "her"
PRINT " As you walk away from the tower, you notice a small figure bleeding on the"
PRINT " ground. Walking closer, you find "; RTRIM$(RecStuff.Nam); " crouched over."
PRINT " Beside "; Sex$; " You notice the large rock that you had thrown from the"
PRINT " tower. Chuckling, you turn around and run away!"
GET 1, record%, RecStuff
pause
RETURN

climbdowntower:
qb.COLOR 6, 0
hplost = RecStuff.currenthit / 2
PRINT " You hang over the edge of the tower, and grasp onto the ladder.  You start your"
PRINT " way down the ladder."; : makedot 6, 0: PRINT "Whew, you think you can make it the whole way!"
PRINT " About halfway down, your arms stiffen, and you fall off!"; : makedot 10, 1
PRINT " You groan and lift yourself off the ground. You are bleeding everywhere, though"
PRINT " you're still alive!  You notice that in the fall you lost "; hplost; " hitpoints! "
RecStuff.currenthit = RecStuff.currenthit - hplost
IF threwrox = 1 THEN GOSUB hitsomeone
pause
EXIT SUB

elevator:
hPRINT " HAHA, Cheater!  Now you will DIE HAHA... uhhh. nah, I'll let you go -=]", 1
hPRINT " You climb into a small box in the corner, tap a blue button on the side", 1
hPRINT " Then the box closes up, and drops downwards through the tower.", 0: makedot 7, 1
hPRINT " The box hits the ground with a painful thump, and you crawl out.  The box", 1
hPRINT " immediately returns to the roof.", 1
IF threwrox = 1 THEN GOSUB hitsomeone
pause
EXIT SUB

citymap:
getscreen "{CITYMAP}"
pause
RETURN

END SUB

