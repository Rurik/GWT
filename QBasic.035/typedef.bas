TYPE Monster
    Level AS STRING * 1
    Nam AS STRING * 15       ' Name
    Sex AS STRING * 1        ' Pervert! Nah, 1 = Male 0 = Female :) hehe
    Attack AS INTEGER        ' Attack strength
    Health AS INTEGER        ' Hitpoints
    Gold AS LONG             ' Gold you get if win
    say1 AS STRING * 75      ' Sayings (random)
    say2 AS STRING * 75
    say3 AS STRING * 75
    say4 AS STRING * 75
    Weapon AS STRING * 15    ' Weapon
END TYPE
TYPE RecStuff
    Nam AS STRING * 21       ' User's Player Name
    RNam AS STRING * 50      ' Real Name of User {unused}
    Pword AS STRING * 10     ' Users Password
    Level AS STRING * 1      ' Short int {unused}
    Gems AS STRING * 1       ' # of gems as Short Int
    Race AS STRING * 1       ' # or A in string format.
    Job AS STRING * 1        ' # in string format.
    currenthit AS INTEGER    ' Hitpoints left
    totalhit AS INTEGER      ' Total Hitpoints
    exper AS LONG            ' Experience
    cashonhand AS LONG       ' $$$ in your hands
    cashinbank AS LONG       ' $$$ in the bank
    Attacks AS INTEGER       ' Used for battle
    Defences AS INTEGER      ' this has to be done later
    SeenMaster AS STRING * 1 ' boolean {unused}
    WeaponN AS STRING * 15   ' Weapon Name
    WeaponC AS LONG          ' $ received if weapon is sold
    WeaponS AS INTEGER       ' Strength deducted if weapon is sold
    ArmorN AS STRING * 15    ' Armor Name
    ArmorC AS LONG           ' $ received if armor is sold
    ArmorD AS INTEGER        ' Defence deducted if armor is sold
    FightLeft AS STRING * 1  ' Arena Fights left - short int.
    TotalFight AS STRING * 1 ' Total Arena Fights per day - short int
    Playerkills AS INTEGER   ' # of players user killed {unused}
    Sex AS STRING * 1        ' 1 if male 0 if female
    lastdate AS STRING * 6   ' date of last played.
    wongame AS STRING * 1    ' # of times won - short int {unused}
    LockFights AS STRING * 1 ' fights in locker
    Trip AS STRING * 1       ' Did I trip bellgirl? 1 = YES 0 = huh?
    Flirt AS STRING * 1      ' Did I flirt? 1 = YES 0 = huh?
    SFans AS STRING * 1      ' Did I kill fans? 1 = YES 0 = huh?
    Expert AS STRING * 1     ' Expert Mode On 1 = Yes!
    Blank AS STRING * 20     ' For the future... part of magic shop {unused}
    Affect AS STRING * 1     ' ditto {unused}
    Much AS LONG             ' ditto {unused}
    SeenM AS STRING * 1      ' Seen Master Today {unused}
    Sleeper AS STRING * 1    ' Where sleeping {unused}
    Planet AS STRING * 1     ' Planet :)
END TYPE
TYPE email
  Nam AS STRING * 20 ' who sent it
  Flag AS INTEGER     ' dah.. figure it out yerself
  msg AS STRING * 70  ' msg line
END TYPE
TYPE WepArm
  Nam AS STRING * 15
  Cost AS LONG
  Much AS INTEGER
END TYPE
TYPE Trade
  Nam AS STRING * 15
  Cost AS LONG
  Much AS INTEGER
  Flag AS STRING * 1
END TYPE
TYPE Cave
  Nam AS STRING * 50
  Lastdate as string * 6
  Bless as string * 1
END TYPE