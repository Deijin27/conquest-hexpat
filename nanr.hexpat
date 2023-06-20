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

struct AnimFrame
{
    u32 offsetData [[color("FF0000")]];
    u16 unknown1 [[color("00FF00")]];
    u16 deadMemory [[color("0000FF")]];
    // some frames share the same value, so no dupes to save space i suppose
    u16 numCell @(16 + 8 + parent.parent.blockOffset_Cells + offsetData);
};

struct AnimBank
{
    u32 frameCount [[color("00FFFF")]];
    u16 dataType [[color("FF00FF")]];
    u16 unknown1 [[color("FFFF00")]];
    u16 unknown2 [[color("44FF99")]];
    u16 unknown3 [[color("FF4499")]];
    u32 offsetFrame [[color("0044FF")]];
    AnimFrame frames[frameCount] @(16 + 8 + parent.blockOffset_Frames + offsetFrame);
};



struct ABNK
{
    NitroChunkHeader header;
    u16 bankCount;
    u16 tFrames;
    u32 blockOffset_Anim;
    u32 blockOffset_Frames;
    u32 blockOffset_Cells;
    u64 reserved;
    AnimBank banks[bankCount];
    // pad with 0xCC to be divisible by 4 ?
};

struct Label
{
    u32 offsetName;
    char name[] @ (16 + parent.parent.animBankChunk.header.chunkLength + 8 + parent.parent.animBankChunk.bankCount * 4 + offsetName);
};

struct LABL
{
    NitroChunkHeader header;
    Label labels[parent.animBankChunk.bankCount];
    // null terminated names, i guess just until you hit the end.
};

struct UEXT
{
    NitroChunkHeader header;
    u32 unknown;
};

struct NANR
{
    NitroFileHeader header;
    ABNK animBankChunk;
    LABL labels @ (16 + animBankChunk.header.chunkLength);
    UEXT uext @ (16 + animBankChunk.header.chunkLength + labels.header.chunkLength);
};

NANR nanr @ 0x00;