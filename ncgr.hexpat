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

struct CHAR
{
    NitroChunkHeader header;
    u16 tilesPerColumn;
    u16 tilesPerRow;
    u32 format;
    u16 unknown1;
    u16 unknown2;
    u32 isTiled; // 0 == tiled
    u32 dataLength;
    u32 dataStartOffset;
    u8 data[dataLength];
};

struct NCGR
{
    NitroFileHeader header;
    CHAR pixelData;
};

NCGR ncgr @ 0x00;