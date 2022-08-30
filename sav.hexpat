
struct BlockHeader
{
    u32 checksum [[color("FF0000")]];
	u32 u2 [[color("00FF00")]];
	u32 u3 [[color("0000FF")]];
	char text[10] [[color("999999")]];
	u16 u4;
};

struct BlockHeader_v2
{
	u32 checksum [[color("FF0000")]];
	u32 u2 [[color("00FF00")]];
	u32 u3 [[color("0000FF")]];
	char text[10] [[color("999999")]];
};

struct UnknownSubHeader
{
	u16 u4 [[color("FF00FF")]];
	u16 u5 [[color("00FFFF")]];
	u32 u6 [[color("FFFF00")]];
};

struct PokemonBlock
{
	BlockHeader pokemonHeader;
	UnknownSubHeader subHeader;
	u16 pokemon[0x40];
};

struct ZeroBlock
{
    BlockHeader zeroHeader;
    UnknownSubHeader subHeader;
    u8 zeros[0x10];
};

struct WeirdBlock
{
	BlockHeader weirdHeader;
	UnknownSubHeader subHeader;
	u8 zeros[0x14];
};

struct GalleryContent
{
	u16 unknown;
};

struct Warrior
{
	u16 unknown [[color("847494")]];
	u16 un2[8] [[color("749484")]];
};

struct SWPokemon
{	
	u8 scenarioPokemonId [[color("9411AA")]];
	bool scenarioPokemonIsDefault [[color("4AB289")]];
};

bitfield SWBit
{
	u1: 5;
	u2: 5;
	army: 5;
	kingdom: 5;
	class: 3 [[comment("0 = Army Leader, 1 = Army Member, 5 = default")]];
	warriorId: 9;
};

bitfield SWBit2
{
	unkSw: 9;
	u13bit: 13;
	item: 8;
	u2bit: 2;
};

struct ScenarioWarrior_v1
{
	SWBit fields;
	u32 notPadding;
	SWBit2 fields2;
	u16 alsoNotPadding;
	SWPokemon pokemon[8];
	u16 notPaddingToo;
};

struct ScenarioWarrior_v2
{
	SWBit fields;
	u32 notPadding;
	SWBit2 fields2;
	u16 alsoNotPadding;
	u8 u1;;
	SWPokemon pokemon[8];
	u8 u2;
};

struct GalleryBlock_v1
{
	BlockHeader galleryHeader;
	Warrior warriors[0xC8];
	// there is one un-owned set of pokemon first
	SWPokemon pokemon[7];
	u16 notPaddingToo;
	// then the scenario warrior data
	ScenarioWarrior_v1 scenarioWarriors[0x61];
	
};

struct GalleryBlock_v2
{
	BlockHeader galleryHeader;
	Warrior warriors[0xC8];
	
};

struct OnlyWarriorBlock
{
	BlockHeader header;
	ScenarioWarrior_v2 scenarioWarriors[0xD2];
};

bitfield SPBits
{
	unknown: 4;
	ability: 8;
	speIV: 5;
	defIV: 5;
	atkIV: 5;
	hpIV: 5;
};

struct ScenarioPokemon
{
	u8 pokemon;
	u8 u1;
	u16 exp;
	SPBits field;
};

struct ScenarioPokemonBlock
{
	BlockHeader header;
	ScenarioPokemon pokemon[0x30B];
	// there is one un-owned set of pokemon first
	SWPokemon pokemon[3];
	u16 notPaddingToo;
	// then the scenario warrior data
	ScenarioWarrior_v1 warriors[0xf];
};

struct SAV
{
	PokemonBlock p1;
	PokemonBlock p2;
	ZeroBlock z1;
	WeirdBlock w1;
};

SAV sav @ 0x00;

OnlyWarriorBlock onlyWarriorBlk @ 0x189D;
ScenarioPokemonBlock spBlk @0x3d3a;
GalleryBlock_v2 gallery @ 0x78b6;
OnlyWarriorBlock onlyWarriorBlk2 @ 0xCE5A;
GalleryBlock_v2 gallery2 @ 0x12e74;
//padding to 0x40000

