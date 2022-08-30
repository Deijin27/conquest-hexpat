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

struct PatternKeyFrame
{
	u16 frame;
	u8 texIndex;
	u8 palIndex;
};

struct TexPatAnimRadixData
{
	u16 numKeyFrames;
	u16 flag;
	u16 ratioDataFrame; // Fixed point
	u16 offset;
};

struct TexPatAnimRadixDict : RadixDict
{
	TexPatAnimRadixData data[entryCount];
	Name names[entryCount];
};

struct PatternAnimation
{
	char type;
	if (type == 'M')
	{
		u8 revision;
		char type1[2];
	}
	u16 numFrames;
	u8 numTextures;
	u8 numPalettes;
	u16 texturesOffset;
	u16 palettesOffset;
	TexPatAnimRadixDict texPatRadix;
	PatternKeyFrame keyFrames[6];
	Name textures[numTextures];
	Name palettes[numPalettes];
};


struct PAT0
{
	NitroChunkHeader header;
	OffsetRadixDict radixDict;
	PatternAnimation anims[6];
};

struct BTP0
{
	NitroFileHeader header;
	u32 chunkOffsets[header.chunkCount];
	PAT0 mdl0;
};

BTP0 btp0 @ 0x00;









