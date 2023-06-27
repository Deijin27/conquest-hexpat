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

bitfield CellValue
{
    shape: 2;
    depth: 1;
    mosaic: 1;
    objMode: 2;
    nextFlag: 1;
    rotateScaleFlag: 1;
};

bitfield CellValue2
{
    
    xSign: 1;
};

bitfield CellValue3
{
    indexPalette: 4;
    priority: 2;
    tileOffset: 10;
};

struct Cell
{
    s8 yOffset;
    CellValue flags;
    u8 xOffset;
    u8 moreFlags;
    CellValue3 evenMoreFlags;
};

struct CellBank
{
    u16 cellCount;
    u16 readOnlyCellInfo;
    u32 cellOffset;
    if (parent.bankType == 1)
    {
        u16 xMax;
        u16 yMax;
        u16 xMin;
        u16 yMin;
    }
    Cell cells[cellCount] @ (16 + 32 + 16 * parent.bankCount + cellOffset);
};

struct CEBK
{
    NitroChunkHeader header;
    u16 bankCount;
    u16 bankType;
    u32 bankDataOffset;
    u8 blockSize;
    u8 zeros[3];
    u32 partitionDataOffset;
    u64 zero;
    CellBank banks[bankCount];
};


struct Label
{
    u32 offsetName;
    char name[] @ (16 + parent.parent.bankChunk.header.chunkLength + 8 + parent.parent.bankChunk.bankCount * 4 + offsetName);
};

struct LABL
{
    NitroChunkHeader header;
    // the number of lates doesn't actually seem to match the number of cell banks
    // is it the number of animations? Regardless, a consisent way without knowing how
    // many is to read u32 while <= 0xFF
    //Label labels[parent.bankChunk.bankCount];
};

struct UEXT
{
    NitroChunkHeader header;
    u32 unknown;
};


struct NCER
{
    NitroFileHeader header;
    CEBK bankChunk;
    LABL labels @ (16 + bankChunk.header.chunkLength);
    UEXT uext @ (16 + bankChunk.header.chunkLength + labels.header.chunkLength);
};


NCER ncer @ 0x00;