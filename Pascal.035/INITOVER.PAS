UNIT InitOver;
(**) INTERFACE (**)
Uses Overlay, Dos, Crt, DDplus;

(**) IMPLEMENTATION (**)

  (*NOTE: You will have to choose the buffer size
    for each particular program.  The bigger it is,
    the less "thrashing" as the program reads from
    disk.  However, the bigger it is, the less Heap
    memory is available.  Hence we define the buffer
    size in terms of the amount of heap space needed
    by the program.*)

CONST
  HeapNeeded:longint = 60000{180000};

  PROCEDURE SetUpOverlay;
  VAR
    OverlayName    : String[79];
    BufferSize,
    OrigBufferSize : LongInt;
    N              : Word;
    Message        : Boolean;
    X              : LongInt;
  BEGIN
    Message := FALSE;
    IF Lo(DosVersion) >= 3 THEN OverlayName := ParamStr(0)
    ELSE
      BEGIN
        OverlayName := FSearch('GWTMAIN.EXE',GetEnv('PATH'));
        IF OverlayName = '' THEN BEGIN
          Write('The main program must be named');
          WriteLn('"GWTMAIN.EXE",');
          Write('and it must reside on your PATH ');
          WriteLn('or in the current directory.');
          Halt(1);
        END;
      END;
    WriteLn;
    OverlayName := FExpand(OverlayName);
    WriteLn('Loading ',OverlayName,'...');
    Dec(OverlayName[0], 3);
    OverlayName := OverlayName + 'OVR';
    OvrInit(OverlayName);
    IF OvrResult = OvrNotFound THEN BEGIN
      Write('Overlay file not found: ');
      WriteLn(OverlayName);
      Halt(2);
    END;
    IF OvrResult <> OvrOK THEN BEGIN
      WriteLn('Error loading overlay file: ');
      WriteLn(OverlayName);
      Halt(3);
    END;
    IF EMSOK then OvrInitEMS;
    IF EMSOK then Begin
     CASE OvrResult OF
      OvrOK:; {just continue}
      OvrNoEMSDriver:
      BEGIN
        Write('No EMS driver in system.  Program ');
        WriteLn('will read overlay from disk');
        Message := TRUE;
      END;
      OvrNoEMSMemory:
      BEGIN
        Write('Not enough EMS memory in system.  ');
        Write('Program will read ');
        WriteLn('overlay from disk');
        Message := TRUE;
      END;
      ELSE
        WriteLn('Overlay manager error.');
        Halt( 4 );
      END;
    End;
    OrigBufferSize := OvrGetBuf;
    BufferSize:=MaxAvail-HeapNeeded;
    OvrSetBuf(BufferSize);
    IF OvrResult <> OvrOK THEN BEGIN
      Write('Could not set overlay buffer to ');
      Write(BufferSize,'.  Remaining at default: ');
      WriteLn(OrigBufferSize);
      Message := TRUE;
    END;
    IF Message THEN BEGIN
      NoSound;
      Sound(1200);Delay(2);NoSound;Delay(50);Sound(1000);Delay(2);NoSound;
      N:=5000;
      REPEAT
        Delay(1);
        Dec(N);
      UNTIL (N = 0) OR KeyPressed;
      IF KeyPressed THEN IF ReadKey = #0 THEN;
    END;
  END;

BEGIN
  SetUpOverlay;
END.