struct SAV_Sect {
    u8 s0 [0xA0];
    u8 s1 [0xA0];
    u8 s2 [0x30];
    u8 s3 [0xC76];
    u8 s4 [0xAB8];
    u8 s5 [0x1A58];
    u8 s6 [0xA44];
    u8 s7 [0x2278];
    u8 s8_ [0xF18];
    u8 s9 [0x504];
    u8 s10 [0x408];
    u8 s11 [0xE0];
    u8 s12 [0x3D08];
};

struct SAV {
   SAV_Sect sect1;
   SAV_Sect sect2;
};

SAV sav @ 0x00;