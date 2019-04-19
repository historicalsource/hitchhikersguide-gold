

	.FUNCT	MINERAL-WATER-F
	EQUAL?	PRSA,V?DRINK-FROM,V?DRINK \?CCL3
	PRINTR	"Bad idea. Even Santraginus Five seawater is illegal on most planets. (You can imagine what kind of beach communities they have.)"
?CCL3:	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL7
	ICALL	PERFORM,V?EXAMINE,PRSO
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?CCL9
	PRINTR	"This is one of those clever new always-open always-closed bottles."
?CCL9:	EQUAL?	PRSA,V?THROW,V?POUR \FALSE
	CALL1	LIQUID-SPILL
	RSTACK	


	.FUNCT	HOLD-F,RARG
	EQUAL?	RARG,M-END \?CCL3
	FSET?	HOLD,NDESCBIT /?CCL3
	FSET	HOLD,NDESCBIT
	FSET	PEANUTS,TAKEBIT
	FCLEAR	PEANUTS,NDESCBIT
	FCLEAR	PEANUTS,TRYTAKEBIT
	FCLEAR	TOWEL,TRYTAKEBIT
	MOVE	PEANUTS,PROTAGONIST
	MOVE	FORD,HERE
	MOVE	MINERAL-WATER,FORD
	SET	'GROGGY,TRUE-VALUE
	CALL	QUEUE,I-GROGGY,3
	PUT	STACK,0,1
	CALL	QUEUE,I-FORD,6
	PUT	STACK,0,1
	CALL	QUEUE,I-ANNOUNCEMENT,18
	PUT	STACK,0,1
	CALL	QUEUE,I-GUARDS,36
	PUT	STACK,0,1
	RANDOM	6 >LINE-NUMBER
	RANDOM	3 >WORD-NUMBER
	ADD	SCORE,8 >SCORE
	SET	'P-IT-OBJECT,PEANUTS
	CRLF	
	PRINTI	"Ford removes the bottle of "
	PRINTD	MINERAL-WATER
	PRINTR	" which he's been waving under your nose. He tells you that you are aboard a Vogon spaceship, and gives you some peanuts."
?CCL3:	EQUAL?	RARG,M-END \?CCL9
	FSET?	HOLD,REVISITBIT \?CCL9
	SET	'DREAMING,TRUE-VALUE
	CRLF	
	ICALL2	JIGS-UP,STR?91
	RTRUE	
?CCL9:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a squalid room filled with grubby mattresses, unwashed cups, and unidentifiable bits of smelly alien underwear. A door lies to port, and an airlock lies to starboard."
	ZERO?	GOWN-HUNG /?CND16
	PRINTI	" Your gown is hanging from a hook"
	FSET?	TOWEL,SURFACEBIT /?CND16
	PRINTC	46
?CND16:	FSET?	TOWEL,SURFACEBIT \?CND24
	ZERO?	GOWN-HUNG /?PRG31
	PRINTI	" and a "
	JUMP	?PRG33
?PRG31:	PRINTI	" A "
?PRG33:	PRINTI	"towel is draped over a drain on the floor."
?CND24:	ZERO?	PANEL-BLOCKER /?CND35
	EQUAL?	PANEL-BLOCKER,SATCHEL /?CND35
	PRINTI	" Resting in front of a "
	PRINTD	ROBOT-PANEL
	PRINTI	" at the base of one wall is"
	ICALL2	ARTICLE,PANEL-BLOCKER
	PRINTR	"."
?CND35:	CRLF	
	RTRUE	


	.FUNCT	I-GROGGY
	CALL	QUEUE,I-GROGGY,-1
	PUT	STACK,0,1
	INC	'GROGGY-COUNTER
	ZERO?	GROGGY \?CND1
	CALL2	INT,I-GROGGY
	PUT	STACK,0,0
	SET	'GROGGY-COUNTER,0
	RFALSE	
?CND1:	CRLF	
	EQUAL?	GROGGY-COUNTER,1,2 \?CCL5
	PRINTI	"You begin to feel "
	EQUAL?	GROGGY-COUNTER,2 \?PRG12
	PRINTI	"in"
?PRG12:	PRINTR	"distinctly groggy."
?CCL5:	EQUAL?	GROGGY-COUNTER,3 \?PRG18
	PRINTR	"You begin to feel very indistinct."
?PRG18:	PRINTI	"Your serious allergic reaction to protein loss from"
	PRINT	BEAM
	PRINTI	"s becomes a cause celebre amongst various holistic pressure groups in the Galaxy and leads to a total ban on dematerialisation. Within fifty years, space travel is replaced by a keen interest in old furniture restoration and market gardening. In this new, quieter Galaxy, the art of telepathy flourishes as never before, creating a new universal harmony which brings all life together, converts all matter into thought and brings about the rebirth of the entire Universe on a higher and better plane of existence.

However, none of this affects you, because you are dead."
	CRLF	
	CALL1	FINISH
	RSTACK	


	.FUNCT	DISPENSER-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"The dispenser is tall, has a button at around eye-level, and says ""Babel Fish"" in large letters. Anything dispensed would probably come out the slot at around knee-level."
	ICALL1	FINE-PRODUCT
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?PUT-IN-FRONT \?CCL7
	EQUAL?	PRSO,EARS,HEAD \?CCL7
	SET	'LYING-DOWN,TRUE-VALUE
	PRINTI	"You are now lying down with your ear near the "
	PRINTD	DISPENSER
	PRINTR	" slot."
?CCL7:	EQUAL?	PRSA,V?LIE-DOWN \FALSE
	ZERO?	IN-FRONT-FLAG /FALSE
	ICALL	PERFORM,V?PUT-IN-FRONT,HEAD,DISPENSER
	RTRUE	


	.FUNCT	DISPENSER-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	ZERO?	LYING-DOWN /?CCL6
	PRINTR	"You can't reach it from down here."
?CCL6:	ZERO?	FISH-COUNTER \?CND4
	PRINTR	"Click."
?CND4:	DEC	'FISH-COUNTER
	PRINTI	"A single "
	PRINTD	BABEL-FISH
	PRINTI	" shoots out of the slot. It sails across the room and "
	ZERO?	GOWN-HUNG \?PRG19
	PRINTI	"through a "
	PRINTD	FISH-HOLE
	PRINTI	" in the wall, just under a "
	PRINTD	HOOK
	PRINTR	"."
?PRG19:	PRINTI	"hits the dressing gown. The fish slides down the "
	ZERO?	SLEEVE-TIED /?PRG26
	PRINTI	"inside (nice try, though)"
	JUMP	?PRG28
?PRG26:	PRINTI	"sleeve"
?PRG28:	PRINTI	" of the gown and falls to the floor, "
	FSET?	TOWEL,SURFACEBIT /?PRG35
	PRINTR	"vanishing through the grating of a hitherto unnoticed drain."
?PRG35:	PRINTI	"landing on the towel. A split second later, a tiny cleaning robot whizzes across the floor, grabs the fish, and continues its breakneck pace toward a "
	PRINTD	ROBOT-PANEL
	PRINTI	" at the base of the wall. "
	ZERO?	PANEL-BLOCKER \?CCL39
	PRINTR	"The robot zips through the panel, and is gone."
?CCL39:	EQUAL?	PANEL-BLOCKER,SATCHEL /?PRG48
	PRINTI	"The robot zips around"
	ICALL2	ARTICLE,PANEL-BLOCKER
	PRINTR	", through the panel, and is gone."
?PRG48:	PRINTI	"The robot plows into the satchel, sending the "
	PRINTD	BABEL-FISH
	EQUAL?	ITEM-ON-SATCHEL,MAIL /?PRG56
	ZERO?	ITEM-ON-SATCHEL /?PRG56
	PRINTI	" and"
	ICALL	ARTICLE,ITEM-ON-SATCHEL,TRUE-VALUE
?PRG56:	PRINTI	" flying through the air in a graceful arc"
	EQUAL?	ITEM-ON-SATCHEL,MAIL /?CCL60
	PRINTI	". "
	PRINT	ROBOT-FLIES-IN
	PRINTI	"catches the "
	PRINTD	BABEL-FISH
	PRINTC	32
	ZERO?	ITEM-ON-SATCHEL /?PRG68
	MOVE	ITEM-ON-SATCHEL,LOCAL-GLOBALS
	PRINTI	"and also manages to catch"
	ICALL	ARTICLE,ITEM-ON-SATCHEL,TRUE-VALUE
	SET	'ITEM-ON-SATCHEL,FALSE-VALUE
	JUMP	?PRG70
?PRG68:	PRINTI	"(which is all the flying junk it can find)"
?PRG70:	PRINTR	", and exits."
?CCL60:	EQUAL?	ITEM-ON-SATCHEL,MAIL \FALSE
	MOVE	MAIL,LOCAL-GLOBALS
	ADD	SCORE,12 >SCORE
	MOVE	BABEL-FISH,PROTAGONIST
	CALL2	RUNNING?,I-ANNOUNCEMENT
	ZERO?	STACK /?CCL76
	CALL	QUEUE,I-GUARDS,4
	PUT	STACK,0,1
	JUMP	?CND74
?CCL76:	FSET?	CAPTAINS-QUARTERS,TOUCHBIT /?CND74
	CALL	QUEUE,I-ANNOUNCEMENT,4
	PUT	STACK,0,1
	CALL	QUEUE,I-GUARDS,7
	PUT	STACK,0,1
?CND74:	SET	'FISH-COUNTER,0
	SET	'ITEM-ON-SATCHEL,FALSE-VALUE
	PRINTI	" surrounded by a cloud of junk mail. Another robot flies in and begins madly collecting the cluttered plume of mail. The "
	PRINTD	BABEL-FISH
	PRINTR	" continues its flight, landing with a loud ""squish"" in your ear."


	.FUNCT	FISH-HOLE-F
	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL3
	PRINTI	"You see only "
	PRINTD	DARK-OBJECT
	PRINTR	"."
?CCL3:	EQUAL?	PRSA,V?PUT \?CCL7
	EQUAL?	PRSI,FISH-HOLE \?CCL7
	FSET?	PRSO,INTEGRALBIT \?CCL12
	CALL1	PART-OF
	RSTACK	
?CCL12:	GETP	PRSO,P?SIZE
	LESS?	STACK,5 \?PRG17
	MOVE	PRSO,LOCAL-GLOBALS
	PRINTR	"It falls through the hole and vanishes."
?PRG17:	PRINTR	"It doesn't fit through the hole."
?CCL7:	EQUAL?	PRSA,V?PUT-IN-FRONT,V?PUT-ON \?CCL20
	EQUAL?	PRSI,FISH-HOLE \?CCL20
	EQUAL?	PRSO,ME,EARS,HANDS /?CCL24
	EQUAL?	PRSO,HEAD \?CND23
?CCL24:	ICALL	PERFORM,V?STAND-BEFORE,FISH-HOLE
	RTRUE	
?CND23:	ICALL	PERFORM,V?HANG,PRSO,HOOK
	RTRUE	
?CCL20:	EQUAL?	PRSA,V?SPUT-ON,V?BLOCK-WITH \?CCL28
	EQUAL?	PRSO,FISH-HOLE \?CCL28
	ICALL	PERFORM,V?HANG,PRSI,HOOK
	RTRUE	
?CCL28:	EQUAL?	PRSA,V?BLOCK \?CCL32
	ICALL	PERFORM,V?STAND-BEFORE,FISH-HOLE
	RTRUE	
?CCL32:	EQUAL?	PRSA,V?LIE-DOWN \FALSE
	ZERO?	IN-FRONT-FLAG /FALSE
	ICALL	PERFORM,V?STAND-BEFORE,FISH-HOLE
	RTRUE	


	.FUNCT	HOOK-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	ZERO?	GOWN-HUNG /?PRG9
	PRINTR	"Your gown is hanging from it."
?PRG9:	PRINTR	"The hook is attached to the wall, inches above a tiny hole."
?CCL3:	EQUAL?	PRSA,V?PUT-ON,V?HANG \FALSE
	ZERO?	LYING-DOWN /?CCL15
	PRINT	WHILE-LYING
	CRLF	
	RTRUE	
?CCL15:	EQUAL?	PRSO,GOWN \?CCL19
	FSET?	GOWN,WORNBIT \?CND20
	ICALL1	IDROP
	RTRUE	
?CND20:	SET	'GOWN-HUNG,TRUE-VALUE
	MOVE	GOWN,HERE
	FSET	GOWN,NDESCBIT
	FSET	GOWN,TRYTAKEBIT
	FCLEAR	GOWN,OPENBIT
	PRINTR	"The gown is now hanging from the hook, covering a tiny hole."
?CCL19:	EQUAL?	PRSO,HEAD,EARS,HANDS \?CCL25
	ICALL	PERFORM,V?STAND-BEFORE,HOOK
	RTRUE	
?CCL25:	FSET?	PRSO,TAKEBIT \?CCL27
	FSET?	PRSO,TRYTAKEBIT \?CCL30
	PRINT	NOT-HOLDING
	ICALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	"."
?CCL30:	MOVE	PRSO,HERE
	PRINTR	"It slips off the hook."
?CCL27:	CALL1	V-COUNT
	RSTACK	


	.FUNCT	DRAIN-F
	EQUAL?	PRSA,V?PUT-ON \?CCL3
	FSET?	TOWEL,SURFACEBIT \?CCL6
	PRINTR	"The drain is already covered by the towel."
?CCL6:	ZERO?	LYING-DOWN /?CCL10
	PRINT	WHILE-LYING
	CRLF	
	RTRUE	
?CCL10:	EQUAL?	PRSO,TOWEL \?PRG15
	FSET	TOWEL,CONTBIT
	FSET	TOWEL,SURFACEBIT
	FSET	TOWEL,OPENBIT
	FSET	TOWEL,NDESCBIT
	FSET	TOWEL,TRYTAKEBIT
	MOVE	TOWEL,HERE
	ICALL	PERFORM,V?EXAMINE,DRAIN
	RTRUE	
?PRG15:	PRINTI	"The drain is too large to be covered by"
	ICALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	"."
?CCL3:	EQUAL?	PRSA,V?LOOK-INSIDE \?CCL20
	ICALL	PERFORM,V?LOOK-INSIDE,FISH-HOLE
	RTRUE	
?CCL20:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET?	TOWEL,SURFACEBIT \FALSE
	PRINTR	"The towel completely covers the drain."


	.FUNCT	ROBOT-PANEL-F
	EQUAL?	PRSA,V?CLOSE,V?EXAMINE \?CCL3
	PRINTR	"The panel, only a few inches high, is currently closed."
?CCL3:	EQUAL?	PRSA,V?OPEN \?CCL7
	PRINT	BUDGE
	CRLF	
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?BLOCK \?CCL11
	SET	'AWAITING-REPLY,6
	CALL	QUEUE,I-REPLY,2
	PUT	STACK,0,1
	PRINTI	"With "
	PRINTD	HANDS
	PRINTR	"s? By force of will?"
?CCL11:	EQUAL?	PRSA,V?LIE-DOWN \?CCL15
	ZERO?	IN-FRONT-FLAG /?CCL15
	ICALL	PERFORM,V?STAND-BEFORE,ROBOT-PANEL
	RTRUE	
?CCL15:	EQUAL?	PRSA,V?PUT-ON,V?PUT-IN-FRONT,V?PUT-IN-FRONT \?CCL19
	EQUAL?	PRSI,ROBOT-PANEL \?CCL19
	ICALL	PERFORM,V?BLOCK-WITH,ROBOT-PANEL,PRSO
	RTRUE	
?CCL19:	EQUAL?	PRSA,V?SPUT-ON,V?BLOCK-WITH \FALSE
	EQUAL?	PRSO,ROBOT-PANEL \FALSE
	EQUAL?	PRSI,EARS,HANDS,HEAD /?CTR27
	EQUAL?	PRSI,EYES \?CCL28
?CTR27:	CALL1	V-COUNT
	RSTACK	
?CCL28:	CALL2	HELD?,PRSI
	ZERO?	STACK \?CCL32
	PRINT	NOT-HOLDING
	ICALL	ARTICLE,PRSI,TRUE-VALUE
	PRINTR	"."
?CCL32:	ZERO?	PANEL-BLOCKER /?CCL38
	PRINTI	"But"
	ICALL	ARTICLE,PANEL-BLOCKER,TRUE-VALUE
	PRINTI	" is already in front of the "
	PRINTD	ROBOT-PANEL
	PRINTR	"."
?CCL38:	ZERO?	LYING-DOWN /?CCL44
	PRINT	WHILE-LYING
	CRLF	
	RTRUE	
?CCL44:	MOVE	PRSI,HERE
	SET	'PANEL-BLOCKER,PRSI
	FSET	PRSI,TRYTAKEBIT
	PRINTI	"Okay,"
	EQUAL?	PRSI,SATCHEL \?CCL51
	PRINTI	" the satchel is lying on its side"
	JUMP	?PRG56
?CCL51:	FSET	PRSI,NDESCBIT
	ICALL	ARTICLE,PRSI,TRUE-VALUE
	PRINTI	" is sitting"
?PRG56:	PRINTI	" in front of the "
	PRINTD	ROBOT-PANEL
	PRINTR	"."


	.FUNCT	BABEL-FISH-F
	EQUAL?	PRSA,V?REMOVE,V?TAKE \FALSE
	PRINTI	"That would be foolish. Having a "
	PRINTD	BABEL-FISH
	PRINTR	" in your ear is terribly useful."


	.FUNCT	GLASS-CASE-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"The "
	PRINTD	GLASS-CASE
	PRINTI	" is "
	FSET?	GLASS-CASE,OPENBIT \?PRG11
	PRINTI	"open"
	JUMP	?PRG13
?PRG11:	PRINTI	"closed"
?PRG13:	PRINTI	". Attached to it are a "
	PRINTD	KEYBOARD
	PRINTR	" and a switch."
?CCL3:	EQUAL?	PRSA,V?OPEN \?CCL16
	FSET?	GLASS-CASE,OPENBIT /?CCL16
	PRINT	BUDGE
	CRLF	
	RTRUE	
?CCL16:	EQUAL?	PRSA,V?MUNG \FALSE
	PRINTI	"The hold of the Vogon ship is virtually undamaged by the explosion of the "
	PRINTD	GLASS-CASE
	ICALL2	JIGS-UP,STR?94
	RTRUE	


	.FUNCT	GLASS-CASE-OPENS
	FSET?	GLASS-CASE,OPENBIT \?CCL3
	PRINTI	"Nothing happens."
	CRLF	
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL3:	FSET	GLASS-CASE,OPENBIT
	PRINTI	"The "
	PRINTD	GLASS-CASE
	PRINTI	" opens."
	CRLF	
	FCLEAR	PLOTTER,TRYTAKEBIT
	ZERO?	GLASS-CASE-SCORE \?CND8
	SET	'GLASS-CASE-SCORE,TRUE-VALUE
	ADD	SCORE,25 >SCORE
?CND8:	CALL1	FUCKING-CLEAR
	RSTACK	


	.FUNCT	CASE-SWITCH-F
	EQUAL?	PRSA,V?PUSH,V?TURN,V?LAMP-ON /?CCL3
	EQUAL?	PRSA,V?THROW,V?MOVE \FALSE
?CCL3:	CALL2	HELD?,BABEL-FISH
	ZERO?	STACK /?PRG25
	PRINTI	"A recording plays: ""To open the case, type in the "
	EQUAL?	WORD-NUMBER,1 \?CCL13
	PRINTI	"first"
	JUMP	?PRG23
?CCL13:	EQUAL?	WORD-NUMBER,2 \?CCL17
	PRINTI	"second"
	JUMP	?PRG23
?CCL17:	EQUAL?	WORD-NUMBER,3 \?PRG23
	PRINTI	"third"
?PRG23:	PRINTR	" word from the second verse of the Captain's current favourite poem. WARNING: An incorrect input will cause the case to explode."""
?PRG25:	PRINTI	"A recording plays: ""A"
	ICALL2	PRODUCE-GIBBERISH,5
	CRLF	
	RTRUE	


	.FUNCT	PRODUCE-GIBBERISH,N,GIBBERISH-COUNTER,SUPER-COUNTER
	SET	'SUPER-COUNTER,0
?PRG1:	INC	'SUPER-COUNTER
	SET	'GIBBERISH-COUNTER,0
?PRG3:	INC	'GIBBERISH-COUNTER
	CALL2	PICK-ONE,GIBBERISH
	PRINT	STACK
	EQUAL?	GIBBERISH-COUNTER,10 \?PRG3
	EQUAL?	SUPER-COUNTER,N /?REP4
	PRINTI	" o"
?REP4:	EQUAL?	SUPER-COUNTER,N \?PRG1
	PRINTI	"."""
	RTRUE	


	.FUNCT	I-ANNOUNCEMENT
	CALL	QUEUE,I-ANNOUNCEMENT,-1
	PUT	STACK,0,1
	CRLF	
	PRINTI	"An announcement is coming over the ship's intercom. """
	CALL	HELD?,BABEL-FISH,PROTAGONIST
	ZERO?	STACK /?PRG8
	PRINTR	"This is the Captain. My instruments show that we've picked up a couple of hitchhikers. I hate freeloaders, and when my guards find you I'll have you thrown into space. On second thought, maybe I'll read you some of my poetry first. Repeating..."""
?PRG8:	PRINTC	69
	ICALL2	PRODUCE-GIBBERISH,10
	CRLF	
	RTRUE	


	.FUNCT	I-GUARDS
	EQUAL?	HERE,HOLD \?CCL3
	CALL2	INT,I-ANNOUNCEMENT
	PUT	STACK,0,0
	CRLF	
	PRINTI	"Guards burst in and grab you and Ford, who comes slowly awake. They drag you down the corridor to a large cabin, where they strap you into large, menacing chairs..."
	CRLF	
	CRLF	
	SET	'HERE,CAPTAINS-QUARTERS
	MOVE	NAME,HERE
	SET	'LYING-DOWN,FALSE-VALUE
	CALL	QUEUE,I-CAPTAIN,2
	PUT	STACK,0,1
	SET	'FORD-SLEEPING,FALSE-VALUE
	FSET	FORD,NDESCBIT
	MOVE	PROTAGONIST,POETRY-APPRECIATION-CHAIR
	SET	'OHERE,FALSE-VALUE
	ICALL1	V-LOOK
	MOVE	FORD,HERE
	MOVE	GUARDS,HERE
	RTRUE	
?CCL3:	IN?	RIFLES,LOCAL-GLOBALS /FALSE
	CRLF	
	PRINT	GUARDS-REALIZE
	PRINTI	"They"
	ICALL1	GUARD-DEATH
	RTRUE	


	.FUNCT	CAPTAINS-QUARTERS-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is the cabin of the "
	PRINTD	VOGON-CAPTAIN
	PRINTI	". You and Ford are strapped into "
	PRINTD	POETRY-APPRECIATION-CHAIR
	PRINTR	"s."


	.FUNCT	POETRY-APPRECIATION-CHAIR-F,RARG
	ZERO?	RARG \FALSE
	EQUAL?	PRSA,V?LEAP,V?WALK,V?DISEMBARK /?CTR4
	EQUAL?	PRSA,V?WALK-AROUND \?CCL5
?CTR4:	SET	'AWAITING-REPLY,7
	CALL	QUEUE,I-REPLY,2
	PUT	STACK,0,1
	PRINTR	"You're strapped in, remember?"
?CCL5:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	EQUAL?	PRSO,POETRY-APPRECIATION-CHAIR \FALSE
	CALL1	TELL-ME-HOW
	RSTACK	


	.FUNCT	VOGON-CAPTAIN-F
	EQUAL?	PRSA,V?THANK,V?HELLO,V?TELL /?PRG8
	EQUAL?	PRSA,V?ASK-FOR,V?ASK-ABOUT \?CCL3
	EQUAL?	VOGON-CAPTAIN,PRSO \?CCL3
?PRG8:	PRINTI	"One of the guards lightly bashes your skull with the butt of his weapon"
	CALL2	HELD?,BABEL-FISH
	ZERO?	STACK /?PRG15
	PRINTI	". ""This is a poetry appreciation session, prisoner. No talking!"""
	CRLF	
	JUMP	?CND10
?PRG15:	PRINTI	" and says, ""A"
	ICALL2	PRODUCE-GIBBERISH,2
	CRLF	
?CND10:	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL3:	IN?	POETRY,HERE \FALSE
	EQUAL?	PRSA,V?BLOCK \FALSE
	ICALL	PERFORM,V?LISTEN,POETRY
	RTRUE	


	.FUNCT	I-CAPTAIN
	CALL	QUEUE,I-CAPTAIN,-1
	PUT	STACK,0,1
	INC	'CAPTAIN-COUNTER
	CRLF	
	EQUAL?	CAPTAIN-COUNTER,1 \?CND1
	PRINTI	"""If he's going to read us his poetry,"" mutters Ford, sweating profusely, ""just pray he softens us up with some cudgels first..."""
	CRLF	
	CRLF	
?CND1:	CALL	HELD?,BABEL-FISH,PROTAGONIST
	ZERO?	STACK \?CCL7
	PRINTI	"The "
	PRINTD	VOGON-CAPTAIN
	PRINTI	" says, ""O"
	ICALL2	PRODUCE-GIBBERISH,2
	EQUAL?	CAPTAIN-COUNTER,6 \?CCL12
	CALL1	GUARDS-TO-AIRLOCK
	RSTACK	
?CCL12:	CRLF	
	RTRUE	
?CCL7:	EQUAL?	CAPTAIN-COUNTER,1 \?CCL14
	PRINTI	"""Hello, hitchhikers!"" begins the "
	PRINTD	VOGON-CAPTAIN
	PRINTR	". ""I've decided to read you a verse of my poetry!"""
?CCL14:	EQUAL?	CAPTAIN-COUNTER,2 \?CCL18
	PRINTR	"""Oh freddled gruntbuggly, thy nacturations are to me!"""
?CCL18:	EQUAL?	CAPTAIN-COUNTER,3 \?CCL22
	PRINTR	"""As plurdled gabbleblotchits on a lurgid bee."""
?CCL22:	EQUAL?	CAPTAIN-COUNTER,4 \?CCL26
	PRINTR	"""Groop I implore thee, my foonting turlingdromes."""
?CCL26:	EQUAL?	CAPTAIN-COUNTER,5 \?CCL30
	PRINTR	"""And hooptiously drangle me with crinkly bindlewurdles, or I will rend thee in the gobberwarts with my blurglecruncheon, see if I don't!"""
?CCL30:	EQUAL?	CAPTAIN-COUNTER,6 \?CCL34
	ZERO?	POEM-ENJOYED /?PRG40
	PRINTR	"""You looked like you enjoyed my poem. I think...yes, I think I'll read the NEXT verse, also!"""
?PRG40:	PRINTI	"""You didn't seem to enjoy my poem at all! Guards, toss them out the airlock!"""
	CALL1	GUARDS-TO-AIRLOCK
	RSTACK	
?CCL34:	EQUAL?	CAPTAIN-COUNTER,7 \?CCL43
	EQUAL?	LINE-NUMBER,1,2 \?CCL46
	PRINT	LINE-A
	CRLF	
	RTRUE	
?CCL46:	EQUAL?	LINE-NUMBER,3,4 \?PRG53
	PRINT	LINE-B
	CRLF	
	RTRUE	
?PRG53:	PRINT	LINE-C
	CRLF	
	RTRUE	
?CCL43:	EQUAL?	CAPTAIN-COUNTER,8 \?CCL56
	EQUAL?	LINE-NUMBER,3,5 \?CCL59
	PRINT	LINE-A
	CRLF	
	RTRUE	
?CCL59:	EQUAL?	LINE-NUMBER,1,6 \?PRG66
	PRINT	LINE-B
	CRLF	
	RTRUE	
?PRG66:	PRINT	LINE-C
	CRLF	
	RTRUE	
?CCL56:	EQUAL?	CAPTAIN-COUNTER,9 \?CCL69
	EQUAL?	LINE-NUMBER,4,6 \?CCL72
	PRINT	LINE-A
	CRLF	
	RTRUE	
?CCL72:	EQUAL?	LINE-NUMBER,2,5 \?PRG79
	PRINT	LINE-B
	CRLF	
	RTRUE	
?PRG79:	PRINT	LINE-C
	CRLF	
	RTRUE	
?CCL69:	EQUAL?	CAPTAIN-COUNTER,10 \?CCL82
	PRINTR	"""Gerond withoutitude form into formless bloit, why not then? Moose."""
?CCL82:	EQUAL?	CAPTAIN-COUNTER,11 \FALSE
	PRINTI	"""Since you have somehow managed to survive two verses of my poetry, I have no choice but to space you. Guards!"""
	CALL1	GUARDS-TO-AIRLOCK
	RSTACK	


	.FUNCT	GUARDS-TO-AIRLOCK
	CALL2	INT,I-CAPTAIN
	PUT	STACK,0,0
	PRINTI	" A guard grabs you and Ford, and drags you toward the hold. Ford whispers, ""Don't worry, I'll think of something!"""
	CRLF	
	CRLF	
	FCLEAR	HOLD,TOUCHBIT
	ICALL2	GOTO,HOLD
	FCLEAR	FORD,NDESCBIT
	MOVE	GUARDS,HERE
	MOVE	FORD,HERE
	CALL	QUEUE,I-FORD,1
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	POETRY-F
	EQUAL?	PRSA,V?LISTEN,V?ENJOY \?CCL3
	LESS?	CAPTAIN-COUNTER,2 \?CCL3
	PRINTI	"The "
	PRINTD	VOGON-CAPTAIN
	PRINTR	" hasn't begun yet!"
?CCL3:	EQUAL?	PRSA,V?ENJOY \?CCL9
	CALL2	HELD?,BABEL-FISH
	ZERO?	STACK \?CCL12
	PRINTR	"You can't even understand it, let alone enjoy it!"
?CCL12:	ZERO?	POEM-ENJOYED /?CCL16
	SET	'AWAITING-REPLY,8
	CALL	QUEUE,I-REPLY,2
	PUT	STACK,0,1
	PRINTR	"Hey, let's not overdo it, okay?"
?CCL16:	SET	'POEM-ENJOYED,TRUE-VALUE
	ADD	SCORE,15 >SCORE
	PRINTI	"You realise that, although the "
	PRINTD	POETRY
	PRINTR	" is indeed astoundingly bad, worse things happen at sea, and in fact, at school. With an effort for which Hercules himself would have patted you on the back, you grit your teeth and enjoy the stuff."
?CCL9:	EQUAL?	PRSA,V?LISTEN \?CCL22
	PRINTR	"You have no choice. Why not relax and enjoy it?"
?CCL22:	IN?	POETRY,HERE \?CCL26
	EQUAL?	PRSA,V?BLOCK \?CCL26
	ICALL	PERFORM,V?LISTEN,POETRY
	RTRUE	
?CCL26:	EQUAL?	PRSA,V?EXAMINE,V?READ \FALSE
	PRINTR	"You can't see it from here."


	.FUNCT	VOGON-CORRIDOR-DOOR-F
	EQUAL?	PRSA,V?THROUGH,V?UNLOCK,V?OPEN \FALSE
	CALL2	DO-WALK,P?WEST
	RSTACK	


	.FUNCT	VOGON-AIRLOCK-DOOR-F
	EQUAL?	PRSA,V?THROUGH,V?OPEN \FALSE
	PRINT	BUDGE
	CRLF	
	RTRUE	


	.FUNCT	AIRLOCK-OBJECT-F
	EQUAL?	PRSA,V?WALK-TO,V?THROUGH \?CCL3
	EQUAL?	HERE,AIRLOCK \?CCL6
	PRINT	LOOK-AROUND
	CRLF	
	RTRUE	
?CCL6:	EQUAL?	HERE,HOLD \FALSE
	CALL2	DO-WALK,P?WEST
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?DISEMBARK,V?EXIT,V?LEAVE \FALSE
	EQUAL?	HERE,AIRLOCK \?PRG16
	CALL2	DO-WALK,P?EAST
	RSTACK	
?PRG16:	PRINT	LOOK-AROUND
	CRLF	
	RTRUE	


	.FUNCT	AIRLOCK-F,RARG
	EQUAL?	RARG,M-END \FALSE
	INC	'AIRLOCK-COUNTER
	CRLF	
	EQUAL?	AIRLOCK-COUNTER,1 \?CCL6
	PRINTI	"Ford points at the "
	PRINTD	VOGON-OUTER-DOOR
	PRINTR	". ""In about two minutes, it will open and we'll be ejected into the vacuum of space. But don't panic, I'll think of something."""
?CCL6:	EQUAL?	AIRLOCK-COUNTER,2 \?CCL10
	PRINTR	"Ford is mumbling to himself."
?CCL10:	EQUAL?	AIRLOCK-COUNTER,3 \?CCL14
	PRINTR	"Ford produces a pencil and begins scribbling equations on the wall."
?CCL14:	EQUAL?	AIRLOCK-COUNTER,4 \FALSE
	PRINTI	"Ford's eyes light up. ""Do you still have the Electronic Sub-Etha Auto Hitching Thu..."" At that moment, the airlock door opens, and you and Ford are blown out into space.

"
	CALL2	HELD?,GUIDE
	ZERO?	STACK /?PRG25
	PRINTI	"Your elbow must have struck some key on "
	PRINTD	GUIDE
	PRINTI	" because it begins droning out an entry, coincidentally enough the entry on SPACE. """
	PRINT	SPACE-TEXT
	PRINTI	""" (Footnote 9)"
	CRLF	
	CRLF	
?PRG25:	PRINTI	"Precisely twenty-nine seconds later, you and Ford are scooped up by a passing ship. Gasping for air, you pass out..."
	CRLF	
	CRLF	
	SET	'HEART-PROB,100
	CALL2	GOTO,DARK
	RSTACK	

	.ENDI
