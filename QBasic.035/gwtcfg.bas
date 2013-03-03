OPEN "GWT.CFG" FOR OUTPUT AS 1
CLS
COLOR 9
INPUT "Path for Score files --=*> ", path$
IF RIGHT$(path$, 1) <> "\" THEN path$ = path$ + "\"
INPUT "Path to your DOOR.SYS drop file --=*> ", droppath$
IF RIGHT$(droppath$, 1) <> "\" THEN droppath$ = droppath$ + "\"
INPUT "Use Renegade Pipe? (Y/n):", rg$
rg$ = UCASE$(rg$)
IF rg$ = "" THEN rg$ = "Y"
IF LEFT$(rg$, 1) <> "N" THEN rg$ = "Y"
INPUT "Make Ansi file? (Y/n): ", ansi$
ansi$ = UCASE$(ansi$)
IF ansi$ = "" THEN ansi$ = "Y"
IF LEFT$(ansi$, 1) <> "N" THEN ansi$ = "Y"
INPUT "Make Ascii file? (Y/n): ", ascii$
ascii$ = UCASE$(ascii$)
IF ascii$ = "" THEN ascii$ = "Y"
IF LEFT$(ascii$, 1) <> "N" THEN ascii$ = "Y"
IF rg$ = "Y" THEN rgbull% = 1 ELSE rgbull% = 0
IF ansi$ = "Y" THEN ansibull% = 1 ELSE ansibull% = 0
IF ascii$ = "Y" THEN asciibull% = 1 ELSE asciibull% = 0
INPUT "How many monster fights per day[15]?", Fights%
IF Fights% < 1 THEN Fights% = 15
IF Fights% > 255 THEN Fights% = 255
INPUT "How many levels[10]?", levels%
IF levels% < 1 THEN levels% = 10
IF levels% > 255 THEN levels% = 255
PRINT #1, path$
PRINT #1, rgbull%
PRINT #1, ansibull%
PRINT #1, asciibull%
PRINT #1, droppath$
PRINT #1, Fights%
PRINT #1, levels%
RESET

