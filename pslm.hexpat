struct PslmHeader
{
	char magicNumber[4];
	u16 fileLength;
	u16 width;
	u16 height;
	u16 terrainSectionOffset;
	u16 gimmickSectionOffset;
	u16 gimmickCount;
};

struct Position
{
	u8 x [[color("067890")]];
	u8 y [[color("C67890")]];
};

enum Terrain : u8
{
	Normal,
    Magma,
    Water,
    Electric,
    Grass,
    Ice,
    Fighting,
    Poison,
    Ground,
    Flying,
    Psychic,
    Bug,
    Rock,
    Ghost,
    Dragon,
    Dark,
    Steel,
    Sand,
    Soil,
    Snow,
    Swamp,
    Bog,
    Scaffolding,
    Hidden,
    HiddenPoison,
    Unused_1,
    Void,
    Default,
};

struct TerrainEntry
{
	u32 subCellZValues[9] [[color("AABBCC")]];
	Terrain terrain [[color("FF0000")]];
	u8 unknown3 [[color("00FF00")]];
	u8 unknown4 [[color("0000FF")]];
	u8 unknown5 [[color("00AA33")]];
};

enum Gimmick : u8
{
	dummy_0,
	Banner,
	dummy_1,
	Tree_0,
	Tree_1,
	DeadTree_0,
	DeadTree_1,
	Rock_0,
	Rock_1,
	Hole_0,
	Hole_1,
	Hole_2,
	TreasureBox_0,
	TreasureBox_1,
	TreasureBox_2,
	Tree_3,
	Tree_4,
	Ice_0,
	Ice_1,
	NoEntry_0,
	NoEntry_1,
	dummy_2,
	Trap,
	dummy_3,
	Log,
	PillarofFire_0,
	PillarofFire_1,
	Volcano,
	HotSpring,
	Fountain,
	NoEntry_2,
	dummy_4,
	FloodGate_0,
	GateSwitch_0,
	FloodGate_1,
	GateSwitch_1,
	dummy_5,
	dummy_6,
	dummy_7,
	dummy_8,
	ElectricSwitch_0,
	ElectricSystem,
	dummy,
	NoEntry_3,
	Vine_0,
	Vine_1,
	Vine_2,
	StrangeGrass,
	StrangeFlower,
	GreenGrass_0,
	dummy_9,
	ThinIce,
	Icicle_0,
	dummy_10,
	DriftingIce,
	Icicle_1,
	FightBell_0,
	dummy_11,
	RingsEdge,
	dummy_12,
	dummy_13,
	dummy_14,
	Screen,
	dummy_15,
	dummy_16,
	WaterBucket,
	Screen_0,
	Screen_1,
	SecretPassage,
	Oasis,
	WindGust,
	dummy_17,
	Tree,
	Lift,
	JumpRamp,
	RopeBridge_0,
	RopeBridge_1,
	RopeBridge_2,
	dummy_18,
	WarpBlue,
	WarpOrange,
	WarpGreen,
	dummy_19,
	dummy_20,
	FloatingCube,
	NoEntry,
	Switch,
	PokemariBall,
	dummy_21,
	WaterFeature,
	dummy_22,
	StoneDoor,
	DoorSwitch,
	Boulder,
	dummy_23,
	Fireball_1,
	Statue,
	dummy_24,
	Fireball_2,
	Fireball_3,
	RevivalNode_0,
	RevivalNode_1,
	PyroNode,
	AquaNode,
	HerbalNode,
	ElectroNode,
	dummy_25,
	dummy_26,
	Roulette,
	SurpriseBox,
	dummy_27,
	dummy_28,
	CogWheel,
	Camera,
	Fence_0,
	Fence_1,
	Crane,
	YellowGrass,
	LimeGrass,
	BlueGrass,
	GreenGrass_1,
	ElectricSwitch_1,
	ElectricSwitch_2,
	ElectricSwitch_3,
	dummy_29,
	dummy_30,
	dummy_31,
	dummy_32,
	ElectricSwitch_4,
	dummy_33,
	FightBell_1,
	MysteriousNode_0,
	MysteriousNode_1,
	MysteriousNode_2,
	MysteriousNode_3,
	MysteriousNode_4,
	MysteriousNode_5,
	dummy_34,
	dummy_35,
	dummy_36,
	dummy_37,
	dummy_38,
	dummy_39,
	dummy_40,
	dummy_41,
	dummy_42,
	dummy_43,
	dummy_44,
};

enum Orientation : u8
{
    East,
    South,
    West,
    North,
    Default = 0xFF
};

struct ParamPair
{
	u16 a, b;
};
    
struct GimmickEntry
{
	Gimmick gimmick [[color("DD55DD")]];
	Position position;
	Orientation orientation [[color("DDDD55")]];
	u32 unknownValue [[color("000000")]];
	u32 paramPairCount [[color("FF0000")]];
	ParamPair paramPairs[paramPairCount] [[color("00FFFF")]];
};

struct Pslm
{
	PslmHeader header;
	Position positions[64];
	TerrainEntry terrain[header.width*header.height];
	u32 gimmickOffsets [header.gimmickCount] [[color("662299")]];
	GimmickEntry gimmicks [header.gimmickCount];
};

Pslm pslm @ 0x00;
