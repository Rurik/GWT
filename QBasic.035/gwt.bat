@echo off
if not exist igm.bat ren open.ans open.an4
if not exist igm.bat ren open.an1 open.ans
if not exist igm.bat ren open.an2 open.an1
if not exist igm.bat ren open.an3 open.an2
if not exist igm.bat ren open.an4 open.an3
DOORWAY SYS /B:Z /O:T /V:D /P:GWTMAIN.EXE
if exist IGM.BAT igm.bat

