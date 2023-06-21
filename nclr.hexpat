struct NitroFileHeader
{
	char magicNumber[4];
	u16 byteOrderMarker;
	u16 version;
	u32 fileLength;
	u16 headerLength;
	u16 chunkCount;
};

struct NitroChunkHeader
{
	char magicNumber[4];
	u32 chunkLength;
};

struct PLTT
{
    NitroChunkHeader header;
    u16 format;
    u16 unknown1; // always zero afaik
    u32 unknown2; // always zero afaik
    u32 dataLength;
    u32 dataStartOffset;
    u8 paletteData[dataLength];
};

struct PCMP
{
    NitroChunkHeader header;
    u16 paletteCount;
    u16 deadMemory;
    u32 dataStartOffset;
    u16 palettes[paletteCount];
    
};

struct NCLR
{
    NitroFileHeader header;
    PLTT pltt;
    PCMP pcmp;
};

NCLR nclr @ 0x00;