unit typedef;
interface
TYPE
Monsters = record
  Nam:STRING[15];       {Name}
  Level:char;
  Sex:char;             {Pervert! Nah, 1 = Male 0 = Female :) hehe}
  Attack,               {Attack strength}
  Health:INTEGER;       {Hitpoints}
  Gold:Longint;         {Gold you get if win}
  say1,say2,say3,say4:STRING[75];
  Weapon:STRING[15];    {Weapon}
end;
Perma = record
    Node:INTEGER;
    Nam:STRING[21];
    Level:STRING[1];
    Recordnum:INTEGER;
end;
RecStuf = record
    Nam:STRING[21];       {User's Player Name}
    RNam:STRING[50];      {Real Name of User (unused)}
    Pword:STRING[10];     {Users Password}
    Level,                 {Short int (unused)}
    Gems,                  {# of gems as Short Int}
    Race,                  {# or A in string format.}
    Job:char;             {# in string format.}
    currenthit,            {Hitpoints left}
    totalhit:INTEGER;     {Total Hitpoints}
    exper,                 {Experience}
    cashonhand,            { $$$ in your hands}
    cashinbank:LONGint;   { $$$ in the bank}
    Attacks,               {Used for battle}
    Defences:INTEGER;     {this has to be done later}
    SeenMaster:boolean; {boolean (unused)}
    WeaponN:STRING[15];   {Weapon Name}
    WeaponC:LONGint;      { $ received if weapon is sold}
    WeaponS:INTEGER;      {Strength deducted if weapon is sold}
    ArmorN:STRING[15];    {Armor Name}
    ArmorC:LONGint;       { $ received if armor is sold}
    ArmorD,                {Defence deducted if armor is sold}
    FightLeft,             {Arena Fights left - short int.}
    TotalFight:integer;    {Total Arena Fights per day - short int}
    Playerkills:INTEGER;  {# of players user killed (unused)}
    Sex:STRING[1];        {1 if male 0 if female}
    Lastdate: STRING[8];   {date of last played.}
    wongame,               {# of times won - short int (unused)}
    LockFights:integer;    {fights in locker}
    Trip,                  {Did I trip bellgirl? 1 = YES 0 = huh?}
    Flirt,                 {Did I flirt? 1 = YES 0 = huh?}
    SFans:boolean;         {Did I kill fans? 1 = YES 0 = huh?}
    Expert:boolean;          {Expert Mode On 1 = Yes!}
    Blank:STRING[20];     {For the future... part of magic shop (unused)}
    Affect:STRING[1];     {ditto (unused)}
    Much:LONGint;         {ditto (unused)}
    SeenM:boolean;         {Seen Master Today (unused)}
    Sleeper,               {Where sleeping (unused)}
    Planet:string[1];      {Planet :)}
    ThrewRox:boolean;      {1 = Threw Rocks}
end;
emails = record
  Nam:STRING[20];         {who sent it}
  Flag:INTEGER;           {dah.. figure it out yerself}
  msg:STRING[70];         {msg line}
End;
WepArmtype = record
  Nam:STRING[15];
  Cost:LONGint;
  Much:INTEGER;
end;
Tradetype = record
  Nam:STRING[15];
  Cost:Longint;
  Much:INTEGER;
  Flag:STRING[1];
End;
Cave = record
  Nam:STRING[50];
  Lastdate:STRING[6];
  Bless:STRING[1];
end;
GWTCfg=record
  path:string[255];
  rgbull, ansibull, asciibull:boolean;
  droppath:string[255];
  Fights,levels:integer;
end;

var Perm:Perma;
    RecStuff:RecStuf;
    WepArm:Weparmtype;
    Monster:Monsters;
    EMail:emails;
    Trade:tradetype;
    cfg:GWTCfg;
    door,CRLF, boing,droppath, DateNow:string;
    asciibull, rgbull, ansibull,ANSi:boolean;
    path:string;
    NoConvo, MonstFlag,recordnum,status, PermRec, doodoo:integer;
    Monst:array[1..500] of integer;
    TradeFre:file of tradetype;
    Permfile:file of perma;
    Monstdata:file of monsters;
    emailfile:file of emails;
implementation
end.