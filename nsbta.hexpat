
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

struct ChannelData
{
	u16 numFrames;
	u8 unknown;
	u8 flags;
	u32 offset;
};

struct MaterialTrackRadixData
{
	ChannelData scaleU;
	ChannelData scaleV;
	ChannelData rot;
	ChannelData transU;
	ChannelData transV;
};

struct MaterialTrackRadixDict : RadixDict
{
	MaterialTrackRadixData data[entryCount];
	Name names[entryCount];
};

struct Anim
{
	char type;
	if (type == 'M')
	{
		u8 revision;
		char type1[2];
	}
	u16 numFrames;
	u8 flag;
	u8 texMtxMode;
	MaterialTrackRadixDict materialTrackRadix;
};

struct SRT0
{
	NitroChunkHeader header;
	OffsetRadixDict mdlDict;
	Anim anim[mdlDict.entryCount];
};

struct BTA0
{
	NitroFileHeader header;
	u32 chunk1Offset;
	SRT0 srtChunk;
};

BTA0 bta0 @ 0x00;


