

struct Header
{
	u32 magicNumber; // 0x0040E3C4, or sometimes the C4 is instead BC
	u32 unknown;
	u32 numFiles; // max 8
	
	
};

enum FileType : u32
{
	NSBMD,
	NSBTX,
	NSBTP,
	UNKNOWN_3,
	NSBMA,
	UNKNOWN_5,
	CHAR, // used for raw texture data in pokemon models
	NSBTA
};

Header header @ 0x00;
u32 fileOffsets[header.numFiles] @ 0x0C; // padded to 8 with 0x00
FileType fileTypes[header.numFiles] @ 0x2C; // padded to 8 with 0xFF


