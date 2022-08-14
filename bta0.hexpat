
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

struct Name
{
	char name[16];
};

struct RadixNode
{
	u8 refBit [[color("FF0000")]];
	u8 idxLeft [[color("00FF00")]];
	u8 idxRight [[color("0000FF")]];
	u8 idxEntry [[color("999999")]];
};

struct RadixDict
{
	u8 revision;
	u8 entryCount;
	u16 sizeDictBlock;
	u16 unknown;
	u16 offsetEntry;
	RadixNode radixTree[entryCount+1];
	u16 unitSize;
	u16 offsetName;
};

struct OffsetRadixDict : RadixDict
{
	u32 offsets[entryCount];
	
	Name names[entryCount];
};

struct BigRadixDict : RadixDict
{
    u32 offsets[entryCount];
	u32 offsets[entryCount];
	u32 offsets[entryCount];
	u32 offsets[entryCount];
	u32 offsets[entryCount];
	u32 offsets[entryCount];
	u32 offsets[entryCount];
	u32 offsets[entryCount];
	u32 offsets[entryCount];
	Name names[entryCount];
};

struct SRT0
{
	NitroChunkHeader header;
	OffsetRadixDict mdlDict;
	
};

struct BTA0
{
	NitroFileHeader header;
	u32 chunk1Offset;
	SRT0 srtChunk;
};




BTA0 bta0 @ 0x00;
BigRadixDict inner @ 0x4C;

