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


struct ModelInfo
{
	u8 sbcType;
	u8 scalingRule;
	u8 texMtxMode;
	u8 numNode;
	u8 numMat;
	u8 numShp;
	u8 firstUnusedMtxStackId;
	u8 unknown;
	float posScale;
	float invPosScale;
	u16 numVertex;
	u16 numPolygon;
	u16 numTriangle;
	u16 numQuad;
	u16 boxX; // float2
	u16 boxY; // float2
	u16 boxZ; // float2
	u16 boxW; // float2
	u16 boxH; // float2
	u16 boxD; // float2
	float boxPosScale;
	float boxInvPosScale;
};

struct NodeSetData
{
	u32 offset;
};

struct NodeData
{
	u16 flag;
	u16 unknown;
	if ((flag & 1) == 0) 
	{
		float tx;
		float ty;
		float tz;
	}
	if ((flag & 2) == 0)
	{
		if ((flag & 8) == 0)
		{
			u16 f01;
			u16 f02;
			u16 f10;
			u16 f11;
			u16 f12;
			u16 f20;
			u16 f21;
			u16 f22;
		}
		else
		{
			u16 A;
			u16 B;
		}
	}
	if ((flag & 4) == 0)
	{
		float sx;
		float sy;
		float sz;
		float invSx;
		float invSy;
		float invSz;
	}
};

struct NodeSet
{
	OffsetRadixDict dict;
	NodeData nodeData[dict.entryCount];
};

struct ToMatDictData
{
	u16 offset;
	u8 numMat;
	u8 bound;
};

struct ToMatRadixDict: RadixDict
{
	ToMatDictData data[entryCount];
	Name names[entryCount];
};

enum NNS_G3D_MATFLAG : u16
{
	TEXMTX_USE = 1,
	TEXMTX_SCALEONE = 2,
	TEXMTX_ROTZERO = 4,
	TEXMTX_TRANSZERO = 8,
	ORIGWH_SAME = 16, // 0x0010
	WIREFRAME = 32, // 0x0020
	DIFFUSE = 64, // 0x0040
	AMBIENT = 128, // 0x0080
	VTXCOLOR = 256, // 0x0100
	SPECULAR = 512, // 0x0200
	EMISSION = 1024, // 0x0400
	SHININESS = 2048, // 0x0800
	TEXPLTTBASE = 4096, // 0x1000
	EFFECTMTX = 8192, // 0x2000
};

struct Material
{
	u16 itemTag;
	u16 size;
	u32 diffAmb;
	u32 specEmi;
	u32 polyAttr;
	u32 polyAttrMask;
	u32 texImageParam;
	u32 texImageParamMask;
	u16 texPaletteBase;
	u16 flag; //NNS_G3D_MATFLAG
	u16 origWidth;
	u16 origHeight;
	float magWeight;
	float magHeight;
	if ((flag & 2) == 0) // scaleone
	{
		float scaleS;
		float scaleT;
	}
	if ((flag & 4) == 0) // rotzero
	{
		u16 rotSin;
		u16 rotCos;
	}
	if ((flag & 8) == 0) // transzero
	{
		float transS;
		float transT;
	}
	if ((flag & 0x2000) == 0) // effectmtx
	{
		float effectMtx[0x10];
	}
};

struct MaterialSet
{
	u16 offsetDictTextToMatList;
	u16 offsetDictPalToMatList;
	OffsetRadixDict materialSetDict;
	ToMatRadixDict texToMatDict;
	ToMatRadixDict palToMatDict;
	//u8 texMaterials[1];
	//u8 palMaterials[palToMatDict.entryCount];
	// how can i loop through the values now?
};

enum NNS_G3D_SHPFLAG : u32
{
	USE_NORMAL = 1,
	USE_COLOR = 2,
	USE_TEXCOORD = 4,
	USE_RESTOREMTX = 8,
};

struct Shape
{
	u16 itemTag;
	u16 size;
	NNS_G3D_SHPFLAG flag;
	u32 offsetDL;
	u32 sizeDL;
};


struct ShapeSet
{
	OffsetRadixDict shapeSetDict;
	Shape shapes[shapeSetDict.entryCount];
	// get the dls somehow
};

struct EvpMatrixEnvelope
{
	float invM[4 * 3];
	float invN[3 * 3];
};

struct Model
{
	u32 size;
	u32 offsetSbc;
	u32 offsetMaterial;
	u32 offsetShape;
	u32 offsetEvpMatrix;
	
	ModelInfo info;
	NodeSet nodes;
	u8 sbc[offsetMaterial-offsetSbc];
	MaterialSet materials;
    $ = offsetShape + 68;
	
	//padding [offsetShape-offsetMaterial];
	ShapeSet shapes;
	if (offsetEvpMatrix != 0)
	{
		//$ = offsetEvpMatrix + 0;
		//EvpMatrixEnvelope evpMatrices[nodes.dict.entryCount];
	}
};


struct MDL0
{
	NitroChunkHeader header;
	OffsetRadixDict mdlDict;
	Model models[mdlDict.entryCount];
};

struct BMD0
{
	NitroFileHeader header;
	u32 chunk1Offset;
	MDL0 mdl0;
};

BMD0 bmd0 @ 0x00;



