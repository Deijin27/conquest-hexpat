
struct Header
{
	char magicNumber[4]; // LSP\0
	u32 fortyEight;
	u32 fileId; // file names is this in hex
	u32 numGroups;
	u32 numOffsets;
	u32 tableBDataOffset;
	u32 unknown;
	u32 fileLength;
};

Header header @ 0x00;

u32 groupItemCounts[header.numGroups] @ 0x20;

u32 groupAOffsets[header.numOffsets] @ 0x100; 
