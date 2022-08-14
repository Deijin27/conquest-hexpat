
struct FatEntry
{
	u32 offset;
	u32 length;
};

struct LinkHeader
{
    char magicNumber[4];
    u32 numFiles;
    u32 offsetScaler;
    u32 unknown; // maybe just padding
};

struct Link
{
	
};


LinkHeader header @ 0x00;
FatEntry fat[header.numFiles] @ 0x10;

u32 i;
for (u32 i = 0, i < header.numFiles, i = i + 1)
{
	
};
