#define FOOTSTEP_WOOD "wood"
#define FOOTSTEP_FLOOR "floor"
#define FOOTSTEP_TILES "tiles"
#define FOOTSTEP_PLATING "plating"
#define FOOTSTEP_CARPET "carpet"
#define FOOTSTEP_SAND "sand"
#define FOOTSTEP_GRASS "grass"
#define FOOTSTEP_WATER "water"
#define FOOTSTEP_LAVA "lava"
#define FOOTSTEP_MEAT "meat"
#define FOOTSTEP_CATWALK "catwalk"
//barefoot sounds
#define FOOTSTEP_WOOD_BAREFOOT "woodbarefoot"
#define FOOTSTEP_WOOD_CLAW "woodclaw"
#define FOOTSTEP_HARD_BAREFOOT "hardbarefoot"
#define FOOTSTEP_HARD_CLAW "hardclaw"
#define FOOTSTEP_CARPET_BAREFOOT "carpetbarefoot"
//misc footstep sounds
#define FOOTSTEP_GENERIC_HEAVY "heavy"


//footstep mob defines
#define FOOTSTEP_MOB_CLAW "footstep_claw"
#define FOOTSTEP_MOB_BAREFOOT "footstep_barefoot"
#define FOOTSTEP_MOB_HEAVY "footstep_heavy"
#define FOOTSTEP_MOB_SHOE "footstep_shoe"
#define FOOTSTEP_MOB_HUMAN "footstep_human" //Warning: Only works on /mob/living/carbon/human
#define FOOTSTEP_MOB_SLIME "footstep_slime"
#define FOOTSTEP_MOB_RUST "footstep_rust"
#define FOOTSTEP_OBJ_MACHINE "footstep_machine"
#define FOOTSTEP_OBJ_ROBOT "footstep_robot"

//priority defines for the footstep_override element
#define STEP_SOUND_NO_PRIORITY 0
#define STEP_SOUND_CONVEYOR_PRIORITY 1
#define STEP_SOUND_TABLE_PRIORITY 2

///the name of the index key for priority
#define STEP_SOUND_PRIORITY "step_sound_priority"

// Indexes for footstep data
#define FOOTSTEP_SOUNDS 1
#define FOOTSTEP_VOLUME 2
#define FOOTSTEP_RANGE 3

GLOBAL_LIST_INIT(footstep, list(
	FOOTSTEP_WOOD = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/wood1.ogg' = 1,
			'sound/effects/footstep/wood2.ogg' = 1,
			'sound/effects/footstep/wood3.ogg' = 1,
			'sound/effects/footstep/wood4.ogg' = 1,
			'sound/effects/footstep/wood5.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE = 0,
	),
		FOOTSTEP_FLOOR = list(
			FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/floor1.ogg' = 1,
			'sound/effects/footstep/floor2.ogg' = 1,
			'sound/effects/footstep/floor3.ogg' = 1,
			'sound/effects/footstep/floor4.ogg' = 1,
			'sound/effects/footstep/floor5.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 75,
		FOOTSTEP_RANGE -1,
	),
	FOOTSTEP_PLATING = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/plating1.ogg' = 1,
			'sound/effects/footstep/plating2.ogg' = 1,
			'sound/effects/footstep/plating3.ogg' = 1,
			'sound/effects/footstep/plating4.ogg' = 1,
			'sound/effects/footstep/plating5.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE = 1,
		),
	FOOTSTEP_CARPET = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/carpet1.ogg' = 1,
			'sound/effects/footstep/carpet2.ogg' = 1,
			'sound/effects/footstep/carpet3.ogg' = 1,
			'sound/effects/footstep/carpet4.ogg' = 1,
			'sound/effects/footstep/carpet5.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 75,
		FOOTSTEP_RANGE = -1,
	),
	FOOTSTEP_SAND = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/asteroid1.ogg' = 1,
			'sound/effects/footstep/asteroid2.ogg' = 1,
			'sound/effects/footstep/asteroid3.ogg' = 1,
			'sound/effects/footstep/asteroid4.ogg' = 1,
			'sound/effects/footstep/asteroid5.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 75,
		FOOTSTEP_RANGE = 0,
	),
	FOOTSTEP_GRASS = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/grass1.ogg' = 1,
			'sound/effects/footstep/grass2.ogg' = 1,
			'sound/effects/footstep/grass3.ogg' = 1,
			'sound/effects/footstep/grass4.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 75,
		FOOTSTEP_RANGE = 0,
	),
	FOOTSTEP_WATER = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/water1.ogg' = 1,
			'sound/effects/footstep/water2.ogg' = 1,
			'sound/effects/footstep/water3.ogg' = 1,
			'sound/effects/footstep/water4.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE = 1,
	),
	FOOTSTEP_LAVA = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/lava1.ogg' = 1,
			'sound/effects/footstep/lava2.ogg' = 1,
			'sound/effects/footstep/lava3.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE = 0,
	),
	FOOTSTEP_MEAT = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/meatslap.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE = 0,
	),
	FOOTSTEP_CATWALK = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/catwalk1.ogg' = 1,
			'sound/effects/footstep/catwalk2.ogg' = 1,
			'sound/effects/footstep/catwalk3.ogg' = 1,
			'sound/effects/footstep/catwalk4.ogg' = 1,
			'sound/effects/footstep/catwalk5.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE = 1,
	),
	FOOTSTEP_TILES = list(
		FOOTSTEP_SOUNDS = list(
			'maplestation_modules/sound/footstep/tile1.ogg' = 6,
			'maplestation_modules/sound/footstep/tile2.ogg' = 6,
			'maplestation_modules/sound/footstep/tile3.ogg' = 6,
			'maplestation_modules/sound/footstep/tile4.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 25,
		FOOTSTEP_RANGE = 1,
	),
))
//bare footsteps lists
GLOBAL_LIST_INIT(barefootstep, list(
	FOOTSTEP_WOOD_BAREFOOT = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/woodbarefoot1.ogg' = 1,
			'sound/effects/footstep/woodbarefoot2.ogg' = 1,
			'sound/effects/footstep/woodbarefoot3.ogg' = 1,
			'sound/effects/footstep/woodbarefoot4.ogg' = 1,
			'sound/effects/footstep/woodbarefoot5.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 80,
		FOOTSTEP_RANGE = -1,
	),
	FOOTSTEP_HARD_BAREFOOT = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/hardbarefoot1.ogg' = 1,
			'sound/effects/footstep/hardbarefoot2.ogg' = 1,
			'sound/effects/footstep/hardbarefoot3.ogg' = 1,
			'sound/effects/footstep/hardbarefoot4.ogg' = 1,
			'sound/effects/footstep/hardbarefoot5.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 80,
		FOOTSTEP_RANGE = -1,
	),
	FOOTSTEP_CARPET_BAREFOOT = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/carpetbarefoot1.ogg' = 1,
			'sound/effects/footstep/carpetbarefoot2.ogg' = 1,
			'sound/effects/footstep/carpetbarefoot3.ogg' = 1,
			'sound/effects/footstep/carpetbarefoot4.ogg' = 1,
			'sound/effects/footstep/carpetbarefoot5.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 75,
		FOOTSTEP_RANGE = -2,
	),
	FOOTSTEP_SAND = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/asteroid1.ogg' = 1,
			'sound/effects/footstep/asteroid2.ogg' = 1,
			'sound/effects/footstep/asteroid3.ogg' = 1,
			'sound/effects/footstep/asteroid4.ogg' = 1,
			'sound/effects/footstep/asteroid5.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 75,
		FOOTSTEP_RANGE = 0,
	),
	FOOTSTEP_GRASS = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/grass1.ogg' = 1,
			'sound/effects/footstep/grass2.ogg' = 1,
			'sound/effects/footstep/grass3.ogg' = 1,
			'sound/effects/footstep/grass4.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 75,
		FOOTSTEP_RANGE = 0,
	),
	FOOTSTEP_WATER = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/water1.ogg' = 1,
			'sound/effects/footstep/water2.ogg' = 1,
			'sound/effects/footstep/water3.ogg' = 1,
			'sound/effects/footstep/water4.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE = 1,
	),
	FOOTSTEP_LAVA = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/lava1.ogg' = 1,
			'sound/effects/footstep/lava2.ogg' = 1,
			'sound/effects/footstep/lava3.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE = 0,
	),
	FOOTSTEP_MEAT = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/meatslap.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE = 0,
	),
))

//claw footsteps lists
GLOBAL_LIST_INIT(clawfootstep, list(
	FOOTSTEP_WOOD_CLAW = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/woodclaw1.ogg' = 1,
			'sound/effects/footstep/woodclaw2.ogg' = 1,
			'sound/effects/footstep/woodclaw3.ogg' = 1,
			'sound/effects/footstep/woodclaw2.ogg' = 1,
			'sound/effects/footstep/woodclaw1.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 90,
		FOOTSTEP_RANGE = 1,
	),
	FOOTSTEP_HARD_CLAW = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/hardclaw1.ogg' = 1,
			'sound/effects/footstep/hardclaw2.ogg' = 1,
			'sound/effects/footstep/hardclaw3.ogg' = 1,
			'sound/effects/footstep/hardclaw4.ogg' = 1,
			'sound/effects/footstep/hardclaw1.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 90,
		FOOTSTEP_RANGE = 1,
	),
	FOOTSTEP_CARPET_BAREFOOT = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/carpetbarefoot1.ogg' = 1,
			'sound/effects/footstep/carpetbarefoot2.ogg' = 1,
			'sound/effects/footstep/carpetbarefoot3.ogg' = 1,
			'sound/effects/footstep/carpetbarefoot4.ogg' = 1,
			'sound/effects/footstep/carpetbarefoot5.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 75,
		FOOTSTEP_RANGE = -2,
	),
	FOOTSTEP_SAND = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/asteroid1.ogg' = 1,
			'sound/effects/footstep/asteroid2.ogg' = 1,
			'sound/effects/footstep/asteroid3.ogg' = 1,
			'sound/effects/footstep/asteroid4.ogg' = 1,
			'sound/effects/footstep/asteroid5.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 75,
		FOOTSTEP_RANGE =  0,
	),
	FOOTSTEP_GRASS = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/grass1.ogg' = 1,
			'sound/effects/footstep/grass2.ogg' = 1,
			'sound/effects/footstep/grass3.ogg' = 1,
			'sound/effects/footstep/grass4.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 75,
		FOOTSTEP_RANGE =  0,
	),
	FOOTSTEP_WATER = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/water1.ogg' = 1,
			'sound/effects/footstep/water2.ogg' = 1,
			'sound/effects/footstep/water3.ogg' = 1,
			'sound/effects/footstep/water4.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE =  1,
	),
	FOOTSTEP_LAVA = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/lava1.ogg' = 1,
			'sound/effects/footstep/lava2.ogg' = 1,
			'sound/effects/footstep/lava3.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE =  0),
	,
	FOOTSTEP_MEAT = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/meatslap.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE =  0,
	),
))

//heavy footsteps list
GLOBAL_LIST_INIT(heavyfootstep, list(
	FOOTSTEP_GENERIC_HEAVY = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/heavy1.ogg' = 1,
			'sound/effects/footstep/heavy2.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE =  2,
	),
	FOOTSTEP_WATER = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/water1.ogg' = 1,
			'sound/effects/footstep/water2.ogg' = 1,
			'sound/effects/footstep/water3.ogg' = 1,
			'sound/effects/footstep/water4.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE =  2,
	),
	FOOTSTEP_LAVA = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/footstep/lava1.ogg' = 1,
			'sound/effects/footstep/lava2.ogg' = 1,
			'sound/effects/footstep/lava3.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE =  0,
	),
	FOOTSTEP_MEAT = list(
		FOOTSTEP_SOUNDS = list(
			'sound/effects/meatslap.ogg' = 1,
		),
		FOOTSTEP_VOLUME = 100,
		FOOTSTEP_RANGE =  0,
	),
))
