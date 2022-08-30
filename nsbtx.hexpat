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

struct TexInfo
{
	u32 vramKey;
	u16 sizeTex; //<<3
	u16 offsetDict;
	u16 flag;
	u16 nothing;
	u32 offsetTex;
};

struct Tex4x4Info
{
	u32 vramKey;
	u16 sizeTex; //<<3
	u16 offsetDict; // relative to the start of tex0
	u16 flag;
	u16 nothing;
	u32 offsetTex;
	u32 offsetTexPalIdx;
};

struct PalInfo
{
	u32 vramKey;
	u16 sizePal;
	u16 flag;
	u16 offsetDict;
	u16 nothing;
	u32 offsetPal;
};

struct RadixNode
{
	u8 refBit [[color("FF0000")]];
	u8 idxLeft [[color("00FF00")]];
	u8 idxRight [[color("0000FF")]];
	u8 idxEntry [[color("999999")]];
};

bitfield TexParams
{
	unknownBits: 2;
	alpha: 1;
	format: 3 [[comment("Texture Format\n0: NONE\n1: A3I5\n2: PLTT4\n3: PLTT16\n4: PLTT256\n5: COMP4x4\n6: A5I3\n7: DIRECT")]];
	height: 3; //8 << this value
    width: 3; // 8 << this value
    flipY: 1;
    flipX: 1;
    repeatY: 1;
	repeatX: 1;
};

bitfield TexDupeParams
{
	one: 1;
	height2: 20;
	width2: 11;
};



struct DictTexData
{
	u16 texOffset; //  << 3
	TexParams params;
	TexDupeParams dupeParams;
};

struct DictPalData
{
	u16 offset; //<<3
	u16 flag;
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

struct TexRadixDict : RadixDict
{
	DictTexData data[entryCount];
	Name names[entryCount];
};

struct PalRadixDict : RadixDict
{
	DictPalData data[entryCount];
	Name names[entryCount];
};

struct TEX0
{
	NitroChunkHeader header;
	TexInfo texInfo;
	Tex4x4Info tex4x4Info;
	PalInfo palInfo;
	TexRadixDict texDict;
	PalRadixDict palDict;
	u8 texData[texInfo.sizeTex << 3];
	u8 tex4x4Data[tex4x4Info.sizeTex << 3];
	u8 palData[palInfo.sizePal << 3];
};

struct BTX0
{
	NitroFileHeader header;
	u32 chunk1Offset;
	TEX0 tex0;
};

BTX0 btx0 @ 0x00;



