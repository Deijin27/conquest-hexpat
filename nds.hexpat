
enum Unitcode : u8
{
	Nds,
	Dsi_0,
	NdsPlusDsi,
	Dsi_1
};

struct NdsHeader
{
	char GameTitle[12];
	char GameCode[4];
	char MakerCode[2];
	Unitcode Unitcode;
	u8 EncryptionSeedSelect;
	u8 DeviceCapacity;
	u8 Reserved_0[7];
	u16 GameRevision; // Used by Dsi Titles
	u8 RomVersion;
	u8 InternalFlags;
	u32 Arm9RomOffset;
	u32 Arm9EntryAddress;
	u32 Arm9LoadAddress;
	u32 Arm9Size;
	u32 Arm7RomOffset;
	u32 Arm7EntryAddress;
	u32 Arm7LoadAddress;
	u32 Arm7Size;
	u32 FileNameTableOffset;
	u32 FileNameTableLength;
	u32 FileAllocationTableOffset;
	u32 FileAllocationTableLength;
	u32 Arm9OverlayOffset;
	u32 Arm9OverlayLength;
	u32 Arm7OverlayOffset;
	u32 Arm7OverlayLength;
	u32 NormalCardControlRegisterSettings;
	u32 SecureCardControlRegisterSettings;
	u32 IconBannerOffset;
	u16 SecureAreaCrc; // 2K
	u16 SecureTransferTimeout;
	u32 Arm9Autoload;
	u32 Arm7Autoload;
	u64 SecureDisable;
	u32 NtrRegionRomSize; // excluding dsi area
	u32 HeaderSize;
	u8 Reserved_1[56]; // 56
	u8 NintendoLogo[156]; // 156
	u16 NintendoLogoCrc;
	u16 HeaderCrc;
	u8 DebuggerReserved[32]; // 32
};

struct FolderAlloc
{
	u32 contentsStartOffset;
	u16 fatStartIndex;
	u8 parentFolderAllocIndex;
	u8 unknown;
};

struct FNT
{
};

NdsHeader header @ 0x00;


u8 fnt[header.FileNameTableLength] @ header.FileNameTableOffset;







