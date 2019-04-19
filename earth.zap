

	.FUNCT	HOME-F
	ZERO?	HOUSE-DEMOLISHED /?CCL3
	EQUAL?	PRSA,V?ENJOY \?CCL3
	PRINT	ZEN
	PRINTI	" You can't enjoy a "
	PRINTD	RUBBLE
	PRINTR	" properly till it's at least a hundred years old. Also, you are haunted by the tragic vision of your favourite teapot lying shattered among the dust.
There is also the matter of all your clothes."
?CCL3:	EQUAL?	PRSA,V?BOARD,V?WALK-TO,V?THROUGH \?CCL9
	EQUAL?	HERE,FRONT-OF-HOUSE,FRONT-PORCH \?CCL12
	CALL2	DO-WALK,P?NORTH
	RSTACK	
?CCL12:	EQUAL?	HERE,BEDROOM \?CCL14
	PRINT	LOOK-AROUND
	CRLF	
	RTRUE	
?CCL14:	CALL1	V-WALK-AROUND
	RSTACK	
?CCL9:	EQUAL?	PRSA,V?DISEMBARK,V?EXIT,V?LEAVE \?CCL18
	EQUAL?	HERE,FRONT-PORCH \?CCL21
	CALL2	DO-WALK,P?SOUTH
	RSTACK	
?CCL21:	EQUAL?	HERE,BEDROOM \?PRG24
	CALL1	V-WALK-AROUND
	RSTACK	
?PRG24:	PRINT	LOOK-AROUND
	CRLF	
	RTRUE	
?CCL18:	EQUAL?	PRSA,V?LIE-DOWN \?CCL27
	EQUAL?	HERE,FRONT-OF-HOUSE \?CCL27
	ZERO?	IN-FRONT-FLAG /?CCL27
	ICALL	PERFORM,V?LIE-DOWN,GROUND
	RTRUE	
?CCL27:	EQUAL?	PRSA,V?EXAMINE \?CCL32
	ZERO?	HOUSE-DEMOLISHED /?CCL32
	PRINTI	"It is now a "
	PRINTD	RUBBLE
	PRINTR	"."
?CCL32:	EQUAL?	IDENTITY-FLAG,FORD \FALSE
	CALL1	UNIMPORTANT-THING-F
	RSTACK	


	.FUNCT	HOUSE-F
	EQUAL?	PRSO,HOUSE \?CCL3
	ICALL	PERFORM,PRSA,HOME,PRSI
	RTRUE	
?CCL3:	ICALL	PERFORM,PRSA,PRSO,HOME
	RTRUE	


	.FUNCT	I-HOUSEWRECK
	EQUAL?	HERE,BEDROOM,FRONT-PORCH \FALSE
	CRLF	
	PRINTI	"Astoundingly, a "
	PRINTD	BULLDOZER
	PRINTI	" pokes through your wall. However, you have no time for surprise because the ceiling is collapsing on you as"
	CALL1	BETTER-LUCK
	RSTACK	


	.FUNCT	BETTER-LUCK
	PRINTI	" your home is unexpectedly demolished to make way for a new bypass. You are seriously injured in the process, but on your way to the hospital"
	ICALL1	MAKE-WAY-FOR
	CRLF	
	FSET?	BEDROOM,ONBIT /?CCL5
	PRINTI	"Next time, try turning on the light."
	CRLF	
	JUMP	?CND3
?CCL5:	FSET?	GOWN,OPENBIT /?PRG14
	ZERO?	HEADACHE /?PRG14
	PRINTI	"Too bad you never found an aspirin for your hangover."
	CRLF	
	JUMP	?CND3
?PRG14:	PRINTI	"Better luck next life."
	CRLF	
?CND3:	CALL1	FINISH
	RSTACK	


	.FUNCT	HANGOVER-F
	EQUAL?	PRSA,V?ASK-ABOUT \?CCL3
	EQUAL?	PRSI,HANGOVER /FALSE
?CCL3:	ZERO?	HEADACHE \?CCL7
	EQUAL?	IDENTITY-FLAG,ZAPHOD /?CCL7
	PRINTI	"You can't feel any"
	EQUAL?	HANGOVER,PRSO \?CCL14
	ICALL1	PRSO-PRINT
	JUMP	?PRG15
?CCL14:	ICALL1	PRSI-PRINT
?PRG15:	PRINTR	" here."
?CCL7:	EQUAL?	PRSA,V?EXAMINE \?CCL18
	CALL1	V-DIAGNOSE
	RSTACK	
?CCL18:	EQUAL?	PRSA,V?DROP,V?THROW,V?GIVE \FALSE
	CALL1	V-COUNT
	RSTACK	


	.FUNCT	BEDROOM-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The bedroom is a mess.
It is a small bedroom with a faded carpet and old wallpaper. There is a washbasin, a chair"
	FSET?	GOWN,NDESCBIT \?PRG10
	PRINTI	" with a tatty dressing gown slung over it"
?PRG10:	PRINTR	", and a window with the curtains drawn. Near the exit leading south is a phone."


	.FUNCT	BEDROOM-EXIT-F
	FSET?	BEDROOM-DOOR,OPENBIT /?CCL3
	PRINTI	"The door is closed."
	CRLF	
	SET	'P-IT-OBJECT,BEDROOM-DOOR
	RFALSE	
?CCL3:	ZERO?	HEADACHE /?CCL7
	PRINTI	"You miss the doorway by a good eighteen inches. The wall jostles you rather rudely."
	CRLF	
	RFALSE	
?CCL7:	FSET?	BULLDOZER,INVISIBLE \?PRG14
	PRINTI	"You make your way down to the front porch."
	CRLF	
	CRLF	
	JUMP	?CND1
?PRG14:	PRINTI	"You rush down the stairs in panic."
	CRLF	
	CRLF	
?CND1:	FCLEAR	LIGHT,LIGHTBIT
	RETURN	FRONT-PORCH


	.FUNCT	PHONE-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	FSET?	PHONE,TOUCHBIT \?CCL6
	ICALL	PERFORM,V?CALL,DAIS
	RTRUE	
?CCL6:	FSET	PHONE,TOUCHBIT
	PRINTI	"You pick up the receiver."
	PRINT	DIALING-TONE
	FSET?	TOOTHBRUSH,TOUCHBIT \?CND9
	ICALL1	TWO-TREES
?CND9:	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?REPLY \FALSE
	PRINTR	"It isn't ringing."


	.FUNCT	GLOBAL-BED-F
	EQUAL?	GLOBAL-BED,PRSO \?CCL3
	ICALL	PERFORM,PRSA,BED,PRSI
	RTRUE	
?CCL3:	ICALL	PERFORM,PRSA,PRSO,BED
	RTRUE	


	.FUNCT	BED-F,RARG
	EQUAL?	RARG,M-BEG \?CCL3
	EQUAL?	PRSA,V?TAKE \?CCL6
	FSET?	PRSO,TAKEBIT \?CCL6
	IN?	PRSO,BED /?CCL6
	CALL2	HELD?,PRSO
	ZERO?	STACK \?CCL6
	PRINTI	"You can't reach it from the bed."
	ZERO?	HEADACHE /?CND13
	PRINTR	" The effort almost kills you."
?CND13:	CRLF	
	RTRUE	
?CCL6:	EQUAL?	PRSA,V?LOOK-INSIDE,V?OPEN \?CCL18
	EQUAL?	PRSO,CURTAINS \?CCL18
	ICALL	PERFORM,V?TAKE,PHONE
	SET	'P-IT-OBJECT,CURTAINS
	RTRUE	
?CCL18:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?CCL22
	EQUAL?	PRSO,BEDROOM-DOOR \?CCL22
	ICALL	PERFORM,V?TAKE,PHONE
	SET	'P-IT-OBJECT,BEDROOM-DOOR
	RTRUE	
?CCL22:	EQUAL?	PRSA,V?WALK \FALSE
	CALL2	OUT-OF-FIRST,BED
	RSTACK	
?CCL3:	ZERO?	RARG \FALSE
	EQUAL?	PRSA,V?DISEMBARK \?CCL30
	ZERO?	HEADACHE /?CCL30
	LOC	PROTAGONIST
	EQUAL?	STACK,BED \?CCL30
	MOVE	PROTAGONIST,HERE
	SET	'OHERE,FALSE-VALUE
	SET	'LYING-DOWN,FALSE-VALUE
	PRINTR	"Very difficult, but you manage it. The room is still spinning. It dips and sways a little."
?CCL30:	EQUAL?	PRSA,V?LOOK-UNDER \?CCL37
	MOVE	STUFF-UNDER-BED,HERE
	PRINTR	"There's nothing there. Well, there are a few soiled handkerchiefs, a book you thought you'd lost, a couple of foreign coins, and something else which can't be fully described in a family game, but nothing you'd actually want."
?CCL37:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	EQUAL?	PRSO,BED \FALSE
	CALL1	TELL-ME-HOW
	RSTACK	


	.FUNCT	CURTAINS-F
	EQUAL?	PRSA,V?LOOK-INSIDE,V?OPEN \FALSE
	FCLEAR	BULLDOZER,INVISIBLE
	PRINTI	"As you part "
	PRINTD	CURTAINS
	PRINTI	" you see that i"
	PRINT	NICE-DAY
	PRINTI	", and a large yellow "
	PRINTD	BULLDOZER
	PRINTI	" is advancing on "
	PRINTD	HOME
	PRINTR	"."


	.FUNCT	GOWN-F
	EQUAL?	PRSA,V?CLOSE,V?OPEN \?CCL3
	FSET?	GOWN,WORNBIT /?CCL3
	PRINTR	"It's hard to open or close the pocket unless you're wearing the gown."
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL9
	PRINTI	"The dressing gown is faded and battered, and is clearly a garment which has seen better decades. It has a pocket which is "
	FSET?	GOWN,OPENBIT \?PRG17
	PRINTI	"open"
	JUMP	?CND12
?PRG17:	PRINTI	"closed"
?CND12:	ZERO?	GOWN-HUNG /?PRG24
	PRINTI	". It is hanging from a "
	PRINTD	HOOK
	PRINTC	46
	JUMP	?CND19
?PRG24:	PRINTI	", and a small loop at the back of the collar."
?CND19:	ZERO?	SLEEVE-TIED /?CND26
	PRINTR	" The sleeves are tied closed."
?CND26:	CRLF	
	RTRUE	
?CCL9:	EQUAL?	PRSA,V?TAKE \?CCL31
	EQUAL?	GOWN,PRSO \?CCL31
	ZERO?	HEADACHE /?CCL31
	FCLEAR	GOWN,TRYTAKEBIT
	FCLEAR	GOWN,NDESCBIT
	MOVE	GOWN,PROTAGONIST
	PRINTR	"Luckily, this is large enough for you to get hold of. You notice something in the pocket."
?CCL31:	EQUAL?	PRSA,V?WEAR \?CCL38
	ZERO?	SLEEVE-TIED /?CCL38
	PRINTR	"You'll have to untie the sleeve first."
?CCL38:	EQUAL?	PRSA,V?UNTIE,V?TIE \FALSE
	ICALL	PERFORM,PRSA,SLEEVES
	RTRUE	


	.FUNCT	SLEEVES-F
	CALL2	VISIBLE?,GOWN
	ZERO?	STACK \?CCL3
	CALL2	CANT-SEE,SLEEVES
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?TAKE,V?WEAR \?CCL5
	ICALL	PERFORM,PRSA,GOWN
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?CLOSE,V?TIE \?CCL7
	SET	'PRSO,GOWN
	CALL1	IDROP
	ZERO?	STACK \TRUE
	ZERO?	SLEEVE-TIED /?CCL12
	PRINTR	"It is."
?CCL12:	SET	'SLEEVE-TIED,TRUE-VALUE
	PRINTR	"The sleeves are now tied closed."
?CCL7:	EQUAL?	PRSA,V?OPEN,V?UNTIE \FALSE
	ZERO?	SLEEVE-TIED /?PRG24
	SET	'SLEEVE-TIED,FALSE-VALUE
	PRINTR	"Untied."
?PRG24:	PRINTR	"It isn't tied!"


	.FUNCT	TWO-TREES
	SET	'AWAITING-REPLY,9
	CALL	QUEUE,I-REPLY,2
	PUT	STACK,0,1
	PRINTI	" Shouldn't you be taking more interest in events in the world around you? While you've got it...?"
	RTRUE	


	.FUNCT	THING-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"Apart from a label on the bottom saying ""Made in Ibiza"" it furnishes you with no clue as to its purpose, if indeed it has one. You are surprised to see it because you thought you'd thrown it away. Like most gifts from your aunt,"
	PRINT	GET-RID
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?DROP \?CCL7
	EQUAL?	HERE,MAZE,ACCESS-SPACE /?CCL7
	MOVE	THING,HERE
	PRINTR	"It falls to the ground with a light ""thunk."" It doesn't do anything else at all."
?CCL7:	EQUAL?	PRSA,V?CLOSE \FALSE
	PRINTR	"Come to think of it, you vaguely remember an instruction booklet with directions for that. You never read it and lost it months ago."


	.FUNCT	I-THING
	RANDOM	4
	ADD	4,STACK
	CALL	QUEUE,I-THING,STACK
	PUT	STACK,0,1
	EQUAL?	IDENTITY-FLAG,ARTHUR \FALSE
	EQUAL?	HERE,ENGINE-ROOM \?PRD5
	LESS?	LOOK-COUNTER,3 /FALSE
?PRD5:	EQUAL?	HERE,DARK,ACCESS-SPACE,MAZE /FALSE
	CALL2	VISIBLE?,THING
	ZERO?	STACK \FALSE
	CALL	HELD?,THING,PROTAGONIST
	ZERO?	STACK \FALSE
	IN?	FLEET,HERE /FALSE
	FCLEAR	THING,NDESCBIT
	FCLEAR	THING,INVISIBLE
	RANDOM	100
	LESS?	40,STACK /?CCL13
	MOVE	THING,HERE
	RFALSE	
?CCL13:	FSET?	GOWN,WORNBIT \?CCL15
	FSET?	GOWN,OPENBIT \?CCL15
	RANDOM	100
	LESS?	65,STACK /?CCL15
	MOVE	THING,GOWN
	RFALSE	
?CCL15:	MOVE	THING,PROTAGONIST
	RFALSE	


	.FUNCT	TABLET-F
	EQUAL?	PRSA,V?DRINK,V?TAKE,V?EAT \FALSE
	MOVE	TABLET,LOCAL-GLOBALS
	FCLEAR	SCREWDRIVER,TRYTAKEBIT
	FCLEAR	TOOTHBRUSH,TRYTAKEBIT
	SET	'HEADACHE,FALSE-VALUE
	ADD	SCORE,10 >SCORE
	PRINTR	"You swallow the tablet. After a few seconds the room begins to calm down and behave in an orderly manner. Your terrible headache goes."


	.FUNCT	CLOTHES-EXIT-F
	FSET?	GOWN,WORNBIT \?CCL3
	RETURN	FRONT-OF-HOUSE
?CCL3:	SET	'AWAITING-REPLY,10
	CALL	QUEUE,I-REPLY,2
	PUT	STACK,0,1
	PRINT	ARRESTED
	CRLF	
	RFALSE	


	.FUNCT	MAIL-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	FSET?	MAIL,TOUCHBIT /?CCL3
	FSET	MAIL,TOUCHBIT
	FCLEAR	MAIL,TRYTAKEBIT
	MOVE	MAIL,PROTAGONIST
	PRINTR	"You gather up the pile of mail."
?CCL3:	EQUAL?	PRSA,V?OPEN \FALSE
	ICALL	PERFORM,V?READ,MAIL
	RTRUE	


	.FUNCT	HOUSE-ENTER-F
	ZERO?	HOUSE-DEMOLISHED /?CCL3
	PRINTI	"You can't enter a "
	PRINTD	RUBBLE
	PRINTC	46
	CRLF	
	RFALSE	
?CCL3:	EQUAL?	IDENTITY-FLAG,FORD \?CCL7
	EQUAL?	PRSA,V?THROUGH /?CND8
	PRINTI	"Enter the house? "
?CND8:	ICALL2	PRIVATE,STR?68
	RFALSE	
?CCL7:	ZERO?	PROSSER-LYING \?CCL13
	PRINTI	"The "
	PRINTD	BULLDOZER
	ICALL2	JIGS-UP,STR?69
	RFALSE	
?CCL13:	CALL	QUEUE,I-HOUSEWRECK,5
	PUT	STACK,0,1
	RETURN	FRONT-PORCH


	.FUNCT	FRONT-OF-HOUSE-F,RARG
	EQUAL?	RARG,M-ENTER \?CCL3
	FCLEAR	BULLDOZER,INVISIBLE
	IN?	DOG,COUNTRY-LANE \?CCL6
	ZERO?	DOG-FED \?CND7
	ICALL1	I-DOG
?CND7:	CALL	QUEUE,I-VOGONS,3
	PUT	STACK,0,1
	PRINTI	"You reach the site of what was "
	EQUAL?	IDENTITY-FLAG,FORD \?PRG16
	PRINTI	"Arthur's"
	JUMP	?PRG18
?PRG16:	PRINTI	"your"
?PRG18:	PRINTI	" home. It is now a "
	PRINTD	RUBBLE
	PRINTI	". "
	PRINTD	PROSSER
	PRINTI	" looks sheepishly triumphant, a trick few people can do, as it requires a lot of technically complex deltoid muscle work."
	CRLF	
	CRLF	
	RTRUE	
?CCL6:	EQUAL?	IDENTITY-FLAG,FORD /FALSE
	ZERO?	PROSSER-LYING \FALSE
	CALL	QUEUE,I-BULLDOZER,-1
	PUT	STACK,0,1
	RFALSE	
?CCL3:	EQUAL?	RARG,M-LOOK \?CCL25
	EQUAL?	IDENTITY-FLAG,FORD \?CCL28
	FSET?	FRONT-OF-HOUSE,NDESCBIT /?CCL28
	FSET	BEER,NDESCBIT
	SET	'DRUNK-LEVEL,0
	FSET	ARTHUR,NDESCBIT
	FSET	FRONT-OF-HOUSE,NDESCBIT
	PRINTI	"Before you is the house of your friend, "
	PRINTD	ARTHUR
	PRINTI	", who is lying in front of a "
	PRINTD	BULLDOZER
	PRINTI	"; you have no idea why. You have no idea about most things about Arthur, even why you regard him as a friend, but you do, and must therefore return his towel before you leave."
	JUMP	?CND26
?CCL28:	ZERO?	HOUSE-DEMOLISHED /?CCL35
	PRINTI	"There is a huge "
	PRINTD	RUBBLE
	JUMP	?PRG44
?CCL35:	EQUAL?	IDENTITY-FLAG,FORD \?PRG42
	PRINTI	"Arthur's house is"
	JUMP	?PRG44
?PRG42:	PRINTI	"You can enter your home"
?PRG44:	PRINTI	" to the north. A path leads around it to the northeast and northwest, and a country lane is visible to the south."
?CND26:	FSET?	FRONT-OF-HOUSE,NDESCBIT /?CND46
	EQUAL?	IDENTITY-FLAG,ARTHUR \?CND46
	FSET	FRONT-OF-HOUSE,NDESCBIT
	PRINTI	" All that lies between your home and the huge yellow "
	PRINTD	BULLDOZER
	PRINTR	" bearing down on it is a few yards of mud."
?CND46:	CRLF	
	RTRUE	
?CCL25:	EQUAL?	RARG,M-END \FALSE
	EQUAL?	IDENTITY-FLAG,FORD \FALSE
	FSET?	ARTHUR,NDESCBIT \FALSE
	FCLEAR	ARTHUR,NDESCBIT
	RFALSE	


	.FUNCT	I-BULLDOZER
	ZERO?	LYING-DOWN \?CCL2
	ZERO?	HOUSE-DEMOLISHED /?CND1
?CCL2:	CALL2	INT,I-BULLDOZER
	PUT	STACK,0,0
	RFALSE	
?CND1:	FSET	PROSSER,TOUCHBIT
	IGRTR?	'BULLDOZER-COUNTER,4 \?CCL7
	CALL2	INT,I-BULLDOZER
	PUT	STACK,0,0
	PRINT	BULLDOZER-PILES
	CRLF	
	CALL1	BRICK-DEATH
	RSTACK	
?CCL7:	EQUAL?	HERE,FRONT-OF-HOUSE \FALSE
	CRLF	
	PRINTI	"The "
	PRINTD	BULLDOZER
	PRINTR	" rumbles slowly toward your home."


	.FUNCT	BRICK-DEATH
	CRLF	
	PRINTI	"Your home collapses in a cloud of dust, and a stray flying brick hits you squarely on the back of the head. You try to think of some suitable last words, but what with the confusion of the moment and the spinning of your head, you are unable to compose anything pithy and expire in silence."
?PRG3:	CRLF	
	CRLF	
	PRINTC	62
	PUTB	P-INBUF,1,0
	READ	P-INBUF,P-LEXV
	INC	'DEAD-COUNTER
	EQUAL?	DEAD-COUNTER,1,2 \?CCL7
	PRINTI	"You keep out of this, you're dead"
	EQUAL?	DEAD-COUNTER,1 \?PRG15
	PRINTI	". An ambulance arrives."
	JUMP	?PRG3
?PRG15:	PRINTI	" and should be concentrating on developing a good firm rigor mortis. You are put in the ambulance, which drives away."
	JUMP	?PRG3
?CCL7:	EQUAL?	DEAD-COUNTER,3 \?PRG3
	PRINTI	"For a dead person you are talking too much. As the ambulance reaches the mortuary"
	ICALL1	MAKE-WAY-FOR
	ICALL1	FINISH
	JUMP	?PRG3


	.FUNCT	BULLDOZER-DRIVER-F
	EQUAL?	PRSA,V?HELLO,V?TELL \FALSE
	PRINTI	"The "
	PRINTD	BULLDOZER-DRIVER
	PRINTI	", perusing a booklet of union rules, ignores you."
	CRLF	
	CALL1	FUCKING-CLEAR
	RSTACK	


	.FUNCT	BULLDOZER-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTI	"It's one of those really big "
	PRINTD	BULLDOZER
	PRINTI	"s that can actually crush other "
	PRINTD	BULLDOZER
	PRINTR	"s, let alone houses."
?CCL3:	EQUAL?	HERE,FRONT-OF-HOUSE /?CCL7
	EQUAL?	PRSA,V?MOVE,V?PUSH,V?RUB /?PRG13
	EQUAL?	PRSA,V?BLOCK,V?KICK,V?TAKE /?PRG13
	EQUAL?	PRSA,V?WALK-AROUND \?CCL7
?PRG13:	PRINTI	"The "
	PRINTD	BULLDOZER
	PRINTR	" isn't here."
?CCL7:	EQUAL?	PRSA,V?LIE-DOWN \?CCL16
	ICALL	PERFORM,V?BLOCK,BULLDOZER
	RTRUE	
?CCL16:	EQUAL?	PRSA,V?BLOCK \?CCL18
	EQUAL?	IDENTITY-FLAG,ARTHUR \?CCL18
	ZERO?	HOUSE-DEMOLISHED /?CCL23
	PRINTR	"Too late now."
?CCL23:	ZERO?	LYING-DOWN /?CCL27
	ICALL	PERFORM,V?LIE-DOWN,GROUND
	RTRUE	
?CCL27:	ZERO?	PROSSER-LYING /?CCL29
	PRINTR	"Prosser's doing that for you."
?CCL29:	SET	'LYING-DOWN,TRUE-VALUE
	SET	'OHERE,FALSE-VALUE
	CALL	QUEUE,I-PROSSER,2
	PUT	STACK,0,1
	PRINTI	"You lie down in the path of the advancing "
	PRINTD	BULLDOZER
	PRINTR	". Prosser yells at you to for crissake move!!!"
?CCL18:	EQUAL?	PRSA,V?WALK-AROUND \?CCL35
	EQUAL?	IDENTITY-FLAG,ARTHUR \?CCL38
	CALL1	V-DIG
	RSTACK	
?CCL38:	ZERO?	TOWEL-OFFERED \?CCL40
	PRINTR	"Didn't you come here for a purpose? Something about a towel?"
?CCL40:	ZERO?	GONE-AROUND /?CCL44
	PRINTR	"You already did. It's not a merry-go-round."
?CCL44:	SET	'GONE-AROUND,TRUE-VALUE
	PRINTI	"You walk around the "
	PRINTD	BULLDOZER
	PRINTR	". Prosser is standing here, looking cross and frustrated. Realising that you are a friend of Arthur's he starts to talk at you. He says that this sort of protest is all very well, but what Mr. Dent must realise is that he's had plenty of time to make a formal protest at the proper time and place, and that spending months going through the appropriate official channels, filling in the appropriate official forms, and going to the appropriate official public hearings is the right way of going about it, and lying around whimsically in the mud is not. He says that he personally hates mud and despises the sort of people who lie in it."
?CCL35:	EQUAL?	PRSA,V?LISTEN \FALSE
	CALL2	RUNNING?,I-PROSSER
	ZERO?	STACK /FALSE
	PRINTR	"""Rumble...rumble..."""


	.FUNCT	I-PROSSER
	ZERO?	LYING-DOWN \?CND1
	CALL2	INT,I-PROSSER
	PUT	STACK,0,0
	ICALL1	I-BULLDOZER
	RTRUE	
?CND1:	CALL	QUEUE,I-PROSSER,-1
	PUT	STACK,0,1
	INC	'PROSSER-COUNTER
	CRLF	
	EQUAL?	PROSSER-COUNTER,1 \?CCL5
	PRINTI	"The "
	PRINTD	BULLDOZER
	PRINTR	" thunders toward you. The ground is shaking beneath you as you lie in the mud."
?CCL5:	EQUAL?	PROSSER-COUNTER,2 \?CCL9
	PRINTI	"The noise of the giant "
	PRINTD	BULLDOZER
	PRINTR	" is now so violently loud that you can't even hear Prosser yelling to warn you that you will be killed if you don't get the hell out of the way. You just see him gesticulating wildly."
?CCL9:	EQUAL?	PROSSER-COUNTER,3 \FALSE
	CALL2	INT,I-PROSSER
	PUT	STACK,0,0
	CALL	QUEUE,I-FORD,-1
	PUT	STACK,0,1
	MOVE	FORD,HERE
	SET	'P-IT-OBJECT,TOWEL
	PRINTI	"With a terrible grinding of gears the "
	PRINTD	BULLDOZER
	PRINTI	" comes to an abrupt halt just in front of you. It shakes, shudders, and emits noxious substances all over your rose bed. Prosser is incoherent with rage.

Moments later, your friend "
	PRINTD	FORD
	PRINTR	" arrives. He hardly seems to notice your predicament, but keeps glancing nervously at the sky. He says, ""Hello, Arthur,"" takes a towel from his battered leather satchel, and offers it to you."


	.FUNCT	PROSSER-DESCFCN,X
	EQUAL?	IDENTITY-FLAG,FORD \?PRG8
	FSET?	PROSSER,TOUCHBIT /?PRG8
	FSET	PROSSER,TOUCHBIT
	PRINTR	"Nearby stands an impatient man. There seems to be a bit of an atmosphere."
?PRG8:	PRINTD	PROSSER
	PRINTI	", from the local council, is "
	ZERO?	PROSSER-LYING /?CCL12
	PRINTI	"lying in front"
	JUMP	?PRG21
?CCL12:	ZERO?	GONE-AROUND /?PRG19
	PRINTI	"standing at the side"
	JUMP	?PRG21
?PRG19:	PRINT	ON-OTHER-SIDE
?PRG21:	PRINTI	" of the "
	PRINTD	BULLDOZER
	PRINTI	". He seems to be wearing a "
	PRINTD	DIGITAL-WATCH
	PRINTC	46
	FSET?	PROSSER,TOUCHBIT /?CND1
	FSET	PROSSER,TOUCHBIT
	PRINTR	" He looks startled to see you emerge, and yells at you to get out of the way."
?CND1:	CRLF	
	RTRUE	


	.FUNCT	PROSSER-F
	EQUAL?	PROSSER,WINNER \?CCL3
	IN?	FLEET,HERE \?CCL6
	PRINTI	"Prosser is too preoccupied with recent events to give your remarks much consideration. He is running off and saying a number of things about his mother in a high voice."
	CRLF	
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL6:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL10
	EQUAL?	PRSO,ME \?CCL10
	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?ASK-ABOUT,PROSSER,PRSI
	SET	'WINNER,PROSSER
	RTRUE	
?CCL10:	EQUAL?	PRSA,V?HELLO \?CCL14
	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?HELLO,PROSSER
	SET	'WINNER,PROSSER
	RTRUE	
?CCL14:	EQUAL?	PRSA,V?WHAT \?CCL16
	EQUAL?	PRSO,OBJECT-OF-GAME \?CCL16
	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?ASK-ABOUT,PROSSER,OBJECT-OF-GAME
	SET	'WINNER,PROSSER
	RTRUE	
?CCL16:	EQUAL?	PRSA,V?WHAT \?PRD22
	EQUAL?	PRSO,TIME /?CTR19
?PRD22:	EQUAL?	PRSA,V?TELL-TIME \?PRD25
	EQUAL?	PRSO,ME \?PRD25
	EQUAL?	PRSI,TIME /?CTR19
?PRD25:	EQUAL?	PRSA,V?WHAT-TIME \?CCL20
	EQUAL?	PRSO,TIME \?CCL20
?CTR19:	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?ASK-FOR,PROSSER,TIME
	SET	'WINNER,PROSSER
	RTRUE	
?CCL20:	EQUAL?	PRSA,V?WHAT \?CCL32
	EQUAL?	PRSO,OBJECT-OF-GAME \?CCL32
	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?ASK-ABOUT,PROSSER,PRSO
	SET	'WINNER,PROSSER
	RTRUE	
?CCL32:	EQUAL?	IDENTITY-FLAG,FORD \?CCL36
	EQUAL?	PRSA,V?LIE-DOWN \?PRD41
	EQUAL?	PRSO,BULLDOZER \?PRD41
	ZERO?	IN-FRONT-FLAG \?CTR38
?PRD41:	EQUAL?	PRSA,V?LIE-DOWN \?PRD45
	EQUAL?	PRSO,ROOMS,GROUND \?PRD45
	ZERO?	HOUSE-DEMOLISHED /?CTR38
?PRD45:	EQUAL?	PRSA,V?REPLACE \?CCL39
	EQUAL?	PRSO,ARTHUR \?CCL39
	ZERO?	HOUSE-DEMOLISHED \?CCL39
?CTR38:	ZERO?	PROSSER-LYING /?CND52
	PRINTR	"He's already lying there!"
?CND52:	SET	'PROSSER-LYING,TRUE-VALUE
	CALL	QUEUE,I-ARTHUR,-1
	PUT	STACK,0,1
	PRINTR	"Prosser blinks in astonishment. ""You mean, go and lie in the mud in his place...?"" You explain that Arthur will only move if someone else takes over for him. Prosser shakes his head in such a manner as to suggest that he is very weary of the world, and you tactfully forebear from mentioning that it won't be troubling him much longer. Reluctantly, he follows you back toward Arthur.

You rapidly conclude the business. Prosser lies in the mud. Arthur, bewildered, nevertheless stands up and appears ready to follow you to the Pub."
?CCL39:	ICALL1	STAND-ASIDE
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL36:	EQUAL?	PRSA,V?WHAT-ABOUT \?CCL59
	EQUAL?	PRSO,HOME,HOUSE \?CCL59
	ZERO?	HOUSE-DEMOLISHED /?CCL59
	PRINTR	"Prosser explains the local planning regulations and says, by way of reassurance, that you will probably be rehoused within a couple of years."
?CCL59:	EQUAL?	PRSA,V?BLOCK \?CCL66
	EQUAL?	PRSO,BULLDOZER \?CCL66
	CALL2	RUNNING?,I-BULLDOZER
	ZERO?	STACK /?CCL66
	CALL1	V-PROTEST
	RSTACK	
?CCL66:	ICALL1	STAND-ASIDE
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL3:	ZERO?	GONE-AROUND \?CCL71
	EQUAL?	IDENTITY-FLAG,FORD \?CCL71
	EQUAL?	PRSA,V?ASK-FOR,V?HELLO,V?TELL /?PRD75
	EQUAL?	PRSA,V?TELL-ABOUT,V?ASK-ABOUT \?CCL71
?PRD75:	EQUAL?	PRSO,PROSSER \?CCL71
	IN?	FLEET,HERE /?CCL71
	PRINTI	"Prosser can't hear you from here."
	CRLF	
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL71:	EQUAL?	PRSA,V?SHOW,V?GIVE \?CCL82
	EQUAL?	PRSO,THING \?CCL85
	PRINTR	"He is much impressed and says, ""You must have the same aunt I have."""
?CCL85:	EQUAL?	PRSO,TOWEL \?CCL89
	SET	'TOWEL-MUDDY,TRUE-VALUE
	PRINTR	"Prosser thanks you, wipes the mud off his boots, and hands it back."
?CCL89:	EQUAL?	PRSO,GUIDE \?CCL93
	PRINTI	"Prosser takes a quick look at "
	PRINTD	GUIDE
	PRINTR	", says he doesn't read that kind of rubbish, and hands it back."
?CCL93:	EQUAL?	PRSO,SATCHEL \FALSE
	PRINTR	"Prosser says he wouldn't be seen dead with that kind of thing slung over his shoulder."
?CCL82:	EQUAL?	PRSA,V?WALK-TO \?CCL101
	EQUAL?	HERE,FRONT-OF-HOUSE \?CCL101
	EQUAL?	IDENTITY-FLAG,FORD \?PRG109
	ZERO?	GONE-AROUND \?PRG109
	ICALL	PERFORM,V?WALK-AROUND,BULLDOZER
	RTRUE	
?PRG109:	PRINTR	"You're already as close as any reasonable person would want to get."
?CCL101:	EQUAL?	PRSA,V?KICK,V?KILL \?CCL112
	ZERO?	LYING-DOWN /?CCL112
	PRINT	WHILE-LYING
	CRLF	
	RTRUE	
?CCL112:	EQUAL?	PRSA,V?KILL \?CCL118
	EQUAL?	PRSO,PROSSER \?CCL118
	ZERO?	HOUSE-DEMOLISHED /?CCL118
	PRINTR	"You muck up all his fancy facial work. This is the last moment of satisfaction you will experience for some time."
?CCL118:	EQUAL?	PRSA,V?KICK,V?KILL \?CCL125
	EQUAL?	PRSO,PROSSER \?CCL125
	PRINTR	"He dodges, insisting that this is incorrect procedure."
?CCL125:	EQUAL?	PRSA,V?THROW \?CCL131
	EQUAL?	PRSI,PROSSER \?CCL131
	MOVE	PRSO,HERE
	ICALL	PERFORM,V?KILL,PROSSER
	RTRUE	
?CCL131:	EQUAL?	PRSA,V?EXAMINE \?CCL135
	CALL1	PROSSER-DESCFCN
	RSTACK	
?CCL135:	EQUAL?	PRSA,V?LISTEN \?CCL137
	FSET?	CONVERSATION,INVISIBLE /?CCL137
	ICALL	PERFORM,V?LISTEN,CONVERSATION
	RTRUE	
?CCL137:	EQUAL?	PRSA,V?ASK-ABOUT \?CCL141
	EQUAL?	PRSI,OBJECT-OF-GAME \?CCL141
	PRINTR	"Prosser pulls a booklet out of his back pocket. ""My game manual says that the goal is getting this here house knocked down."""
?CCL141:	EQUAL?	PRSA,V?ASK-ABOUT \?CCL147
	EQUAL?	PRSI,DIGITAL-WATCH \?CCL147
	ICALL	PERFORM,V?ASK-FOR,PROSSER,TIME
	RTRUE	
?CCL147:	EQUAL?	PRSA,V?ASK-FOR \FALSE
	EQUAL?	PRSI,TIME \FALSE
	PRINTI	"Prosser shakes the "
	PRINTD	DIGITAL-WATCH
	PRINTI	". ""Hasn't worked for months. I keep wearing it only because I think "
	PRINTD	DIGITAL-WATCH
	PRINTR	"es are neat."""


	.FUNCT	STAND-ASIDE
	ZERO?	PROSSER-LYING /?PRG5
	PRINTR	"""Leave me alone,"" Prosser whimpers miserably."
?PRG5:	PRINTI	"""Please step aside as I need to be able to "
	ZERO?	HOUSE-DEMOLISHED /?PRG12
	PRINTI	"clear this "
	PRINTD	RUBBLE
	PRINTR	" away."""
?PRG12:	PRINTI	"knock "
	EQUAL?	IDENTITY-FLAG,ARTHUR \?PRG19
	PRINTI	"your"
	JUMP	?PRG21
?PRG19:	PRINTI	"that"
?PRG21:	PRINTR	" house down."""


	.FUNCT	DIGITAL-WATCH-F
	EQUAL?	PRSA,V?READ,V?TAKE \FALSE
	CALL2	PRIVATE,STR?70
	RSTACK	


	.FUNCT	FORD-DESCFCN,X
	ZERO?	FORD-SLEEPING /?PRG6
	PRINTR	"Ford is in the corner, snoring loudly."
?PRG6:	PRINTD	FORD
	PRINTR	" is here."


	.FUNCT	FORD-F
	EQUAL?	IDENTITY-FLAG,FORD \?CCL3
	EQUAL?	FORD,PRSO \?CCL6
	ICALL	PERFORM,PRSA,ME,PRSI
	RTRUE	
?CCL6:	ICALL	PERFORM,PRSA,PRSO,ME
	RTRUE	
?CCL3:	EQUAL?	FORD,WINNER \?CCL8
	IN?	FLEET,HERE \?CCL11
	PRINT	ABOVE-NOISE
	CRLF	
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL11:	EQUAL?	PRSI,HOUSE /?PRG18
	EQUAL?	PRSO,HOUSE \?CCL15
?PRG18:	PRINTI	"""It's not a house, it's a home."" (Footnote 2)"
	CRLF	
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL15:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL21
	EQUAL?	PRSO,ME \?CCL21
	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?ASK-ABOUT,FORD,PRSI
	SET	'WINNER,FORD
	RTRUE	
?CCL21:	EQUAL?	PRSA,V?HELLO \?CCL25
	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?HELLO,FORD
	SET	'WINNER,FORD
	RTRUE	
?CCL25:	EQUAL?	PRSA,V?WHAT \?CCL27
	EQUAL?	PRSO,OBJECT-OF-GAME \?CCL27
	PRINT	ASK-ABOUT-OBJECT
	CRLF	
	RTRUE	
?CCL27:	EQUAL?	PRSA,V?WHAT-ABOUT \?CCL33
	LESS?	FORD-COUNTER,2 \?CCL33
	EQUAL?	HERE,FRONT-OF-HOUSE \?CCL33
	EQUAL?	PRSO,HOME \?CCL33
	PRINTI	"Ford"
	CALL1	FORD-DECIDES
	RSTACK	
?CCL33:	EQUAL?	PRSA,V?WHAT-ABOUT \?CCL41
	EQUAL?	PRSO,THIRD-PLANET,HOME \?CCL41
	ZERO?	EARTH-DEMOLISHED /?CCL41
	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?ASK-ABOUT,FORD,THIRD-PLANET
	SET	'WINNER,FORD
	RTRUE	
?CCL41:	ZERO?	EARTH-DEMOLISHED \?PRG73
	LESS?	DRUNK-LEVEL,3 \?PRG54
	EQUAL?	HERE,PUB \?PRG54
	PRINTI	"""Shut up and drink your beer. You're going to need it."""
	CRLF	
	JUMP	?CND47
?PRG54:	PRINTI	"Ford, busy "
	EQUAL?	FORD-COUNTER,2 \?PRG61
	PRINTI	"talking to Prosser"
	JUMP	?CND56
?PRG61:	PRINTI	"scanning the sky "
?CND56:	EQUAL?	HERE,PUB \?CCL65
	PRINTI	"through the window"
	JUMP	?PRG71
?CCL65:	EQUAL?	FORD-COUNTER,2 /?PRG71
	PRINTI	"for something"
?PRG71:	PRINTI	", ignores you."
	CRLF	
?CND47:	CALL	QUEUE,I-FORD,2
	PUT	STACK,0,1
	RTRUE	
?PRG73:	PRINTI	"Ford seems deep in thought."
	CRLF	
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL8:	EQUAL?	PRSA,V?HELLO,V?TELL-ABOUT,V?TELL /?PRD78
	EQUAL?	PRSA,V?ASK-ABOUT,V?ASK-FOR \?CCL76
?PRD78:	EQUAL?	PRSO,FORD \?CCL76
	ZERO?	FORD-SLEEPING /?CCL76
	PRINTI	"Ford is sleeping!"
	CRLF	
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL76:	EQUAL?	PRSA,V?GIVE \?CCL85
	EQUAL?	PRSI,FORD \?CCL85
	ZERO?	FORD-SLEEPING /?CCL85
	ICALL	PERFORM,V?HELLO,FORD
	RTRUE	
?CCL85:	EQUAL?	FOLLOW-FLAG,1 \?CCL90
	IN?	FORD,HERE /?CCL90
	EQUAL?	PRSA,V?FOLLOW \?CCL90
	PRINTI	"In a state of anxiety and confusion you follow Ford down the lane..."
	CRLF	
	CRLF	
	LOC	FORD
	CALL2	GOTO,STACK
	RSTACK	
?CCL90:	EQUAL?	FOLLOW-FLAG,3 \?CCL97
	EQUAL?	PRSA,V?FOLLOW \?CCL97
	CALL2	DO-WALK,P?WEST
	RSTACK	
?CCL97:	EQUAL?	PRSA,V?FOLLOW \?CCL101
	EQUAL?	FOLLOW-FLAG,5 \?CCL101
	CALL2	DO-WALK,P?SOUTH
	RSTACK	
?CCL101:	EQUAL?	PRSA,V?SHAKE,V?ALARM \?CCL105
	ZERO?	FORD-SLEEPING /?CCL105
	PRINTR	"Rather like trying to wake the dead."
?CCL105:	EQUAL?	PRSA,V?ASK-ABOUT \?CCL111
	EQUAL?	PRSI,OBJECT-OF-GAME \?CCL111
	PRINT	ASK-ABOUT-OBJECT
	CRLF	
	RTRUE	
?CCL111:	EQUAL?	PRSA,V?ASK-ABOUT \?CCL117
	EQUAL?	PRSI,THIRD-PLANET \?CCL117
	PRINTR	"Ford explains that the Earth has been demolished. To cheer you up, he points out that there are an awful lot of little planets like that around, and the Earth wasn't even a particularly nice one."
?CCL117:	EQUAL?	PRSA,V?GIVE \?CCL123
	EQUAL?	PRSO,THUMB \?CCL123
	IN?	FLEET,HERE \?CCL123
	PRINTR	"You can't reach him in this wind."
?CCL123:	EQUAL?	PRSA,V?LISTEN \?CCL130
	FSET?	CONVERSATION,INVISIBLE /?CCL133
	ICALL	PERFORM,V?LISTEN,CONVERSATION
	RTRUE	
?CCL133:	ZERO?	FORD-SLEEPING /FALSE
	PRINTR	"""Zzzzzzz..."""
?CCL130:	EQUAL?	PRSA,V?EXAMINE \?CCL139
	ZERO?	FORD-SLEEPING /?CCL139
	PRINTR	"He's sleeping."
?CCL139:	EQUAL?	PRSA,V?ASK-FOR \FALSE
	EQUAL?	PRSI,TOWEL \FALSE
	EQUAL?	FORD-COUNTER,0,1 \FALSE
	ICALL	PERFORM,V?TAKE,TOWEL
	RTRUE	


	.FUNCT	FORD-DECIDES
	FCLEAR	CONVERSATION,INVISIBLE
	CALL	QUEUE,I-FORD,2
	PUT	STACK,0,1
	SET	'FORD-COUNTER,2
	PRINTI	" looks startled, then guilty. He starts to say something and stops. He starts to say something else and stops. Suddenly, he seems to see the "
	PRINTD	BULLDOZER
	PRINTI	" for the first time, stops starting to say things and starts.

He seems to come to a momentous decision, says he has something of Earth-shattering importance to tell you, and stresses the importance of a quick drink at the Horse 'n Groom.

"
	ICALL2	BUT-THAT-MAN,STR?71
	PRINTI	" Ford goes off for a quiet word with Prosser. From where you're lying, you cannot hear what's happening, although they seem deeply engrossed in "
	PRINTD	CONVERSATION
	PRINTR	"."


	.FUNCT	I-FORD
	CALL	QUEUE,I-FORD,-1
	PUT	STACK,0,1
	CALL2	IN-HEART?,PROTAGONIST
	ZERO?	STACK /?CCL3
	INC	'HEART-COUNTER
	EQUAL?	HEART-COUNTER,1 \?CCL6
	MOVE	FORD,HERE
	CRLF	
	PRINTI	"""This looks like that incredible new"
	PRINT	IID
	PRINTI	" spaceship, "
	PRINTD	HEART-OF-GOLD
	PRINTI	"!"" says Ford, with growing excitement."
	CRLF	
	CRLF	
	PRINT	ANNOUNCEMENT
	PRINTD	EDDIE
	PRINTI	". We have just picked up two hitchhikers"
	ICALL2	FACTOR,STR?72
	PRINTR	""""
?CCL6:	EQUAL?	HEART-COUNTER,2 \?CCL12
	CRLF	
	PRINTI	"""Come on, let's look for the Bridge."" You follow Ford, and eventually come to the..."
	CRLF	
	CRLF	
	ICALL2	GOTO,BRIDGE
	MOVE	FORD,HERE
	RTRUE	
?CCL12:	EQUAL?	HEART-COUNTER,3 \?CCL16
	EQUAL?	HERE,BRIDGE \FALSE
	CRLF	
	PRINTI	"""Hey, Zaphod, how ya doing?"" says Ford. He's cool. ""Not bad, Ford. Great to see you,"" replies Zaphod. He's cooler. You suddenly realise that the woman is Tricia MacMillan (""Call me "
	PRINTD	TRILLIAN
	PRINTR	"""), whom you were trying to pick up at a party in Islington just a few weeks ago, and that Zaphod is the guy she eventually left the party with! Odd."
?CCL16:	EQUAL?	HEART-COUNTER,4 \FALSE
	MOVE	FORD,LOCAL-GLOBALS
	MOVE	ZAPHOD,LOCAL-GLOBALS
	MOVE	TRILLIAN,LOCAL-GLOBALS
	MOVE	HANDBAG,BRIDGE
	MOVE	SATCHEL,BRIDGE
	FCLEAR	HANDBAG,NDESCBIT
	FCLEAR	HANDBAG,TRYTAKEBIT
	CALL2	INT,I-FORD
	PUT	STACK,0,0
	CALL	QUEUE,I-MARVIN,-1
	PUT	STACK,0,1
	EQUAL?	HERE,BRIDGE \FALSE
	SET	'FOLLOW-FLAG,3
	CALL	QUEUE,I-FOLLOW,2
	PUT	STACK,0,1
	CRLF	
	PRINTI	"""Like my spaceship, Ford?"" Zaphod asks. ""YOUR spaceship?"" says Ford, losing his cool for a second. ""Yeah, I stole it,"" Zaphod admits. ""I'm gonna use it to find"
	PRINT	LOST-PLANET
	PRINTI	". Let's go sit in the sauna while I explain."" Zaphod, Ford, and "
	PRINTD	TRILLIAN
	PRINTR	" all head off to port."
?CCL3:	EQUAL?	HERE,HOLD \?CCL29
	FSET?	CAPTAINS-QUARTERS,TOUCHBIT \?CCL32
	INC	'GUARDS-COUNTER
	EQUAL?	GUARDS-COUNTER,1 \?CCL35
	CRLF	
	PRINTR	"The guard releases you and Ford and begins cycling the air in the airlock. ""Hey, guard!"" shouts Ford, ""do you really enjoy this sort of thing? Shouting, stomping around, shooting people, is it really a fulfilling career?"""
?CCL35:	EQUAL?	GUARDS-COUNTER,6 \?PRG51
	CALL2	INT,I-FORD
	PUT	STACK,0,0
	MOVE	SATCHEL,FORD
	FCLEAR	SATCHEL,NDESCBIT
	SET	'PANEL-BLOCKER,FALSE-VALUE
	FSET	HOLD,REVISITBIT
	CRLF	
	PRINTI	"The guard says, """
	CALL	HELD?,BABEL-FISH,PROTAGONIST
	ZERO?	STACK /?PRG47
	PRINTI	"Well, all things considered, I guess I like being a guard. Especially the shouting. Resistance is useless!"""
	JUMP	?PRG49
?PRG47:	PRINTC	73
	ICALL2	PRODUCE-GIBBERISH,3
?PRG49:	PRINTI	" He throws you and Ford into the airlock and closes the door."
	CRLF	
	CRLF	
	ICALL2	GOTO,AIRLOCK
	MOVE	FORD,AIRLOCK
	RTRUE	
?PRG51:	CRLF	
	PRINTR	"Ford continues trying to talk the guard into a sudden career change."
?CCL32:	MOVE	GUIDE,PROTAGONIST
	CALL2	INT,I-FORD
	PUT	STACK,0,0
	SET	'FORD-SLEEPING,TRUE-VALUE
	IN?	MINERAL-WATER,FORD \?CND53
	MOVE	MINERAL-WATER,SATCHEL
?CND53:	IN?	TOWEL,FORD \?CND55
	MOVE	TOWEL,HERE
?CND55:	MOVE	SATCHEL,HERE
	FCLEAR	SATCHEL,TRYTAKEBIT
	CRLF	
	PRINTI	"Ford yawns. ""Matter transference always tires me out. I'm going to take a nap."" He places something on top of his satchel. ""If you have any questions, here's "
	PRINT	GUIDE-NAME
	PRINTI	""" (Footnote 14). Ford lowers his voice to a whisper. ""I'm not supposed to tell you this, but you'll never be able to finish the game without consulting the Guide about lots of stuff."" As he curls up in a corner and begins snoring, you pick up "
	PRINTD	GUIDE
	PRINTR	"."
?CCL29:	ZERO?	FORD-COUNTER \?CCL60
	SET	'FORD-COUNTER,1
	CRLF	
	PRINTR	"Ford glances uncomfortably at the sky. He offers you the towel again."
?CCL60:	EQUAL?	FORD-COUNTER,1 \?CCL64
	CRLF	
	PRINTI	"Ford seems oblivious to your trouble, so you ask ""Ford, what about my home?"" He"
	CALL1	FORD-DECIDES
	RSTACK	
?CCL64:	EQUAL?	FORD-COUNTER,2 \?CCL68
	SET	'FORD-COUNTER,3
	SET	'LYING-DOWN,FALSE-VALUE
	SET	'PROSSER-LYING,TRUE-VALUE
	CALL	QUEUE,I-FORD,2
	PUT	STACK,0,1
	FSET	CONVERSATION,INVISIBLE
	CRLF	
	PRINTI	"Ford and Prosser stop talking and approach you. Ford says that Prosser has agreed to lie in your place so that the two of you can go off to the Pub. Reluctantly, Prosser steps forward and lies down in front of the "
	PRINTD	BULLDOZER
	PRINTR	". You stand up."
?CCL68:	EQUAL?	FORD-COUNTER,3 \?CCL72
	MOVE	FORD,COUNTRY-LANE
	SET	'FORD-COUNTER,4
	EQUAL?	HERE,FRONT-OF-HOUSE \?CCL75
	SET	'FOLLOW-FLAG,1
	CALL	QUEUE,I-FOLLOW,2
	PUT	STACK,0,1
	CRLF	
	PRINTR	"Ford, urging you to follow, hurries toward the country lane."
?CCL75:	EQUAL?	HERE,COUNTRY-LANE \FALSE
	CRLF	
	PRINTR	"Ford enters from the north."
?CCL72:	EQUAL?	FORD-COUNTER,4 \?CCL83
	EQUAL?	HERE,COUNTRY-LANE \?CCL83
	FSET?	PUB,TOUCHBIT /?CCL83
	SET	'FORD-COUNTER,5
	SET	'FOLLOW-FLAG,1
	CALL	QUEUE,I-FOLLOW,2
	PUT	STACK,0,1
	MOVE	FORD,PUB
	CRLF	
	PRINTR	"""Come along, Arthur,"" says Ford impatiently, and enters the Pub."
?CCL83:	IN?	FORD,HERE /?CCL90
	FSET?	PUB,TOUCHBIT \?CCL90
	MOVE	FORD,HERE
	CRLF	
	PRINTR	"Ford hurries after you."
?CCL90:	LESS?	DRUNK-LEVEL,3 \FALSE
	EQUAL?	PRSO,BEER \?CCL99
	EQUAL?	PRSA,V?ENJOY,V?DRINK /FALSE
?CCL99:	EQUAL?	HERE,PUB \FALSE
	FSET?	BEER,NDESCBIT /FALSE
	CRLF	
	PRINTI	"""Drink the beer,"" urges Ford. ""It will help"
	ICALL1	CUSHION
	PRINTR	""""


	.FUNCT	SATCHEL-DESCFCN,X
	PRINTI	"There is a satchel here"
	EQUAL?	PANEL-BLOCKER,SATCHEL \?PRG7
	PRINTI	", resting in front of the "
	PRINTD	ROBOT-PANEL
?PRG7:	PRINTC	46
	ICALL1	ITEM-ON-SATCHEL-DESCRIPTION
	CRLF	
	RTRUE	


	.FUNCT	ITEM-ON-SATCHEL-DESCRIPTION
	ZERO?	ITEM-ON-SATCHEL /FALSE
	PRINTI	" Sitting on top of it is"
	ICALL2	ARTICLE,ITEM-ON-SATCHEL
	PRINTC	46
	RTRUE	


	.FUNCT	SATCHEL-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	EQUAL?	IDENTITY-FLAG,FORD /?CCL3
	CALL2	PRIVATE,STR?73
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?PUT-ON \?CCL7
	EQUAL?	SATCHEL,PRSI \?CCL7
	CALL2	HELD?,SATCHEL
	ZERO?	STACK /?CCL12
	PRINTR	"Put down the satchel first."
?CCL12:	ZERO?	ITEM-ON-SATCHEL /?CCL16
	PRINTI	"But"
	ICALL	ARTICLE,ITEM-ON-SATCHEL,TRUE-VALUE
	PRINTR	" is already on the satchel."
?CCL16:	SET	'ITEM-ON-SATCHEL,PRSO
	MOVE	PRSO,HERE
	FSET	PRSO,NDESCBIT
	FSET	PRSO,TRYTAKEBIT
	PRINTI	"Okay,"
	ICALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" is now sitting on the satchel."
?CCL7:	EQUAL?	PRSA,V?EXAMINE \?CCL26
	PRINTI	"The satchel, which is "
	FSET?	SATCHEL,OPENBIT \?PRG34
	PRINTI	"open"
	JUMP	?PRG36
?PRG34:	PRINTI	"closed"
?PRG36:	PRINTI	", is fairly bulky."
	ICALL1	ITEM-ON-SATCHEL-DESCRIPTION
	CRLF	
	RTRUE	
?CCL26:	EQUAL?	PRSA,V?TAKE \FALSE
	IN?	SATCHEL,FORD \FALSE
	PRINTI	"Ford says, ""Hey, Arthur, keep "
	PRINTD	HANDS
	PRINTR	"s off my satchel!"""


	.FUNCT	TOWEL-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	FSET?	TOWEL,TRYTAKEBIT \?CCL3
	EQUAL?	HERE,FRONT-OF-HOUSE \?CCL3
	ZERO?	LYING-DOWN /?CCL3
	FCLEAR	TOWEL,TRYTAKEBIT
	MOVE	TOWEL,PROTAGONIST
	MOVE	FORD,LOCAL-GLOBALS
	SET	'FORD-GONE,TRUE-VALUE
	SET	'FOLLOW-FLAG,5
	CALL	QUEUE,I-FOLLOW,2
	PUT	STACK,0,1
	CALL2	INT,I-FORD
	PUT	STACK,0,0
	PRINTI	"As you take it, Ford says, ""Er, look, thanks for lending me the towel... been nice knowing you... got to go now..."" He smiles oddly and walks down the "
	PRINTD	COUNTRY-LANE
	PRINTR	"."
?CCL3:	EQUAL?	PRSA,V?MOVE,V?TAKE \?CCL11
	EQUAL?	PRSO,TOWEL \?CCL11
	FSET?	TOWEL,SURFACEBIT \?CCL11
	FCLEAR	TOWEL,TRYTAKEBIT
	FCLEAR	TOWEL,SURFACEBIT
	ICALL	ROB,TOWEL,HERE
	FCLEAR	TOWEL,CONTBIT
	FCLEAR	TOWEL,OPENBIT
	FCLEAR	TOWEL,NDESCBIT
	EQUAL?	PRSA,V?MOVE \FALSE
	PRINTR	"Okay, it's no longer covering the drain."
?CCL11:	EQUAL?	PRSA,V?TIE,V?PUT-ON \?CCL21
	EQUAL?	PRSI,BEAST \?CCL21
	PRINTR	"The effect is decorative rather than helpful."
?CCL21:	EQUAL?	PRSA,V?TIE,V?PUT-ON \?CCL27
	EQUAL?	PRSI,EYES,HEAD \?CCL27
	FSET?	TOWEL,WORNBIT \?CCL32
	PRINTR	"It already is."
?CCL32:	IN?	BEAST,HERE \?PRG39
	FSET	TOWEL,WORNBIT
	MOVE	TOWEL,PROTAGONIST
	CALL	QUEUE,I-BEAST,11
	PUT	STACK,0,1
	PRINTI	"The "
	PRINTD	BEAST
	PRINTR	" is completely bewildered. It is so dim it thinks that if you can't see it, it can't see you. You have a few seconds before it realises its mistake."
?PRG39:	PRINTI	"There's no need for that. It's not like there's a "
	PRINTD	BEAST
	PRINTR	" around, or something."
?CCL27:	FSET?	TOWEL,WORNBIT \?CCL42
	EQUAL?	PRSA,V?UNTIE,V?REMOVE,V?TAKE-OFF \?CCL42
	FCLEAR	TOWEL,WORNBIT
	PRINTI	"You unwrap the towel from your head."
	FSET?	BEAST,MUNGEDBIT \?CND47
	CRLF	
	CRLF	
	ICALL1	V-LOOK
	RTRUE	
?CND47:	ZERO?	BEARINGS-LOST /?PRG59
	PRINTI	" You see that you have wandered in circles"
	EQUAL?	HERE,OUTER-LAIR \?PRG57
	PRINTI	" and ended right beside the "
	PRINTD	MEMORIAL
?PRG57:	PRINTC	46
?PRG59:	PRINTI	" Unfortunately, the Beast has also caught sight of you again. All this fooling around has made it doubly angry and hungry. "
	ICALL1	BEAST-DEATH
	RTRUE	
?CCL42:	EQUAL?	PRSA,V?EXAMINE \?CCL62
	FSET?	TOWEL,SURFACEBIT \?CCL65
	ICALL	PERFORM,V?EXAMINE,DRAIN
	FIRST?	TOWEL /FALSE
	RTRUE	
?CCL65:	ZERO?	TOWEL-MUDDY /?PRG72
	PRINTR	"It is caked with mud."
?PRG72:	PRINTR	"It's covered with little pink and blue flowers."
?CCL62:	EQUAL?	PRSA,V?LIE-DOWN \FALSE
	FSET?	TOWEL,SURFACEBIT \FALSE
	ICALL	PERFORM,V?STAND-BEFORE,HOOK
	RTRUE	


	.FUNCT	BACK-OF-HOUSE-F,RARG
	EQUAL?	RARG,M-END \?CCL3
	CALL2	RUNNING?,I-VOGONS
	ZERO?	STACK \?CCL3
	ZERO?	HOUSE-DEMOLISHED /?CCL3
	ICALL1	I-VOGONS
	CALL	QUEUE,I-VOGONS,2
	PUT	STACK,0,1
	RTRUE	
?CCL3:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The rear garden is a pleasant place. I"
	PRINT	NICE-DAY
	PRINTR	", and it's a lovely day for a walk. A path leads around the house to the southeast and southwest."


	.FUNCT	TREE-PSEUDO
	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-UP \FALSE
	PRINTR	"You were never very good at that."


	.FUNCT	COUNTRY-LANE-F,RARG
	EQUAL?	RARG,M-ENTER \?CCL3
	ZERO?	PROSSER-LYING \?CCL6
	ZERO?	HOUSE-DEMOLISHED \?CCL6
	FSET?	HOLD,TOUCHBIT /?CCL6
	SET	'BULLDOZER-COUNTER,3
	CALL1	I-BULLDOZER
	RSTACK	
?CCL6:	EQUAL?	IDENTITY-FLAG,FORD \?CCL11
	ZERO?	HOUSE-DEMOLISHED /?CCL11
	CALL	QUEUE,I-DOG,1
	PUT	STACK,0,1
	RFALSE	
?CCL11:	EQUAL?	DRUNK-LEVEL,3 \?CCL15
	EQUAL?	IDENTITY-FLAG,ARTHUR \?CCL15
	CALL	QUEUE,I-DOG,1
	PUT	STACK,0,1
	RFALSE	
?CCL15:	FSET?	HOLD,TOUCHBIT \FALSE
	FSET?	COUNTRY-LANE,NDESCBIT /FALSE
	LOC	SATCHEL
	PUT	FORD-TABLE,0,STACK
	LOC	THUMB
	PUT	FORD-TABLE,1,STACK
	LOC	GUIDE
	PUT	FORD-TABLE,2,STACK
	LOC	TOWEL
	PUT	FORD-TABLE,3,STACK
	LOC	MINERAL-WATER
	PUT	FORD-TABLE,5,STACK
	FSET?	THUMB,MUNGEDBIT \?CND22
	PUT	FORD-TABLE,4,TRUE-VALUE
	FCLEAR	THUMB,MUNGEDBIT
?CND22:	FSET	COUNTRY-LANE,NDESCBIT
	ICALL	ROB,PROTAGONIST,MEMORIAL
	MOVE	SATCHEL,PROTAGONIST
	MOVE	THUMB,SATCHEL
	MOVE	GUIDE,SATCHEL
	MOVE	TOWEL,SATCHEL
	MOVE	MINERAL-WATER,SATCHEL
	MOVE	ARTHUR,FRONT-OF-HOUSE
	SET	'IDENTITY-FLAG,FORD
	MOVE	FORD,GLOBAL-OBJECTS
	MOVE	PEANUTS,PUB
	FSET	PEANUTS,TRYTAKEBIT
	FSET	PEANUTS,NDESCBIT
	SET	'PEANUTS-BOUGHT,FALSE-VALUE
	SET	'DREAMING,TRUE-VALUE
	CALL	QUEUE,I-VOGONS,38
	PUT	STACK,0,1
	PRINTI	"You are hurrying up a country lane. The sky is light and clear, but you keep glancing at it with apprehension because you know that it will shortly be torn apart by Vogon ships, and that the hills and trees around you will just burn up and blow away, and you hope there's time for a quick drink beforehand.

You want to hitch a ride aboard the Vogon fleet, but are anxious because it's so long since you were through a"
	PRINT	BEAM
	PRINTC	46
	CRLF	
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	RARG,M-END \?CCL27
	FSET?	COUNTRY-LANE,REVISITBIT \?CCL27
	SET	'DREAMING,TRUE-VALUE
	CRLF	
	PRINTI	"Suddenly, a shadow passes in front of the sun. You look up. The shadow is a "
	PRINTD	FLEET
	PRINTI	". You fumble for "
	ICALL2	JIGS-UP,STR?74
	RTRUE	
?CCL27:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The road runs from "
	EQUAL?	IDENTITY-FLAG,ARTHUR \?PRG41
	PRINTI	"your"
	JUMP	?PRG43
?PRG41:	PRINTI	"Arthur's"
?PRG43:	PRINTR	" home, to the north, toward the village Pub, to the west."


	.FUNCT	I-DOG
	EQUAL?	HERE,WAR-CHAMBER \?CCL3
	INC	'DOG-COUNTER
	LESS?	DOG-COUNTER,13 \?CND4
	EQUAL?	PRSA,V?WAIT /FALSE
?CND4:	CRLF	
	LESS?	DOG-COUNTER,13 \?CCL10
	PRINTR	"The fleet continues to hurtle sunwards."
?CCL10:	ZERO?	DOG-FED /?PRG17
	SET	'LYING-DOWN,FALSE-VALUE
	PRINTI	"Your simple act of kindness at a moment of great personal anxiety (you fed the dog, remember?) now brings rich rewards. "
	PRINT	FLEET-PLUNGES
	PRINTI	" spots the dog (which appears to them as a gigantic monster) cheerfully tucking into a "
	PRINTD	SANDWICH
	PRINTI	".

The Vl'Hurgs and the G'Gugvunts are moved by this simple picture of happiness, compared with the furious savagery of their own lives. They think back to a day when they used to relax over an odd "
	PRINTD	SANDWICH
	PRINTI	" themselves, often at sunset after a hearty day working in the fields back in Vl'Hurgon and G'Gugvia, and decide to return and rebuild their homes in a new spirit of harmony and cooperation.

Grateful, they offer to drop you at "
	PRINTD	HEART-OF-GOLD
	PRINTI	" on the way home. After a brief 900 parsec trip, you are escorted into the Transporter Chamber of the warship. The transporter glows, and your surroundings change..."
	CRLF	
	CRLF	
	CALL2	GOTO,MAZE
	RSTACK	
?PRG17:	PRINT	FLEET-PLUNGES
	ICALL2	JIGS-UP,STR?75
	RTRUE	
?CCL3:	EQUAL?	IDENTITY-FLAG,FORD \?CCL20
	MOVE	DOG,HERE
	CALL2	INT,I-DOG
	PUT	STACK,0,0
	PRINTI	"You run up the lane after Arthur. You pass a"
	ZERO?	DOG-FED /?PRG28
	PRINTR	" serene dog. Fate cannot harm him, he has dined today."
?PRG28:	PRINTR	"n irritable dog who yaps at you."
?CCL20:	IN?	DOG,HERE /?CCL31
	IN?	FLEET,HERE /?CCL31
	EQUAL?	HERE,COUNTRY-LANE \?CCL31
	MOVE	DOG,HERE
	CALL	QUEUE,I-DOG,2
	PUT	STACK,0,1
	PRINTI	"You see the huge "
	PRINTD	BULLDOZER
	PRINTI	" heaving itself among the cloud of brick dust which is all that remains of "
	PRINTD	HOME
	PRINTR	". As you start up the lane, a small dog runs up to you, yapping."
?CCL31:	ZERO?	DOG-FED \FALSE
	IN?	DOG,HERE \FALSE
	FSET?	DOG,TOUCHBIT /FALSE
	FSET	DOG,TOUCHBIT
	PRINTR	"The dog carries on yapping for a moment and then gulps uncomfortably."


	.FUNCT	DOG-F
	EQUAL?	PRSA,V?THROW,V?GIVE \?CCL3
	EQUAL?	PRSO,SANDWICH \?CCL6
	EQUAL?	IDENTITY-FLAG,FORD \?CCL9
	MOVE	SANDWICH,HERE
	PRINTI	"The dog is in a bad mood and tries to bite "
	PRINTD	HANDS
	PRINTI	". The "
	PRINTD	SANDWICH
	PRINTR	" lies ignored in the roadside dust."
?CCL9:	FSET?	DOG,TOUCHBIT \?CCL13
	PRINTI	"The dog, which seems to have a slight case of indigestion, ignores the "
	PRINTD	SANDWICH
	PRINTR	"."
?CCL13:	MOVE	SANDWICH,LOCAL-GLOBALS
	SET	'DOG-FED,TRUE-VALUE
	PRINTI	"The dog is deeply moved. With powerful sweeps of its tail it indicates that it regards this "
	PRINTD	SANDWICH
	PRINTI	" as one of the great "
	PRINTD	SANDWICH
	PRINTI	"es. Nine out of ten pet owners could happen by at this point expressing any preference they pleased, but this dog would spurn both them and all their tins. This is a dog which has met its main sandwich. It eats"
	PRINT	WITH-PASSION
	CRLF	
	RTRUE	
?CCL6:	EQUAL?	PRSO,PEANUTS \FALSE
	PRINTR	"This is a dog, not an elephant."
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL23
	ZERO?	DOG-FED \?CCL23
	PRINTR	"The mongrel looks hungry."
?CCL23:	EQUAL?	PRSA,V?PUSH,V?KICK,V?RUB \FALSE
	PRINTI	"The dog tries to bite your "
	EQUAL?	PRSA,V?KICK \?PRG37
	PRINTI	"foot"
	JUMP	?PRG39
?PRG37:	PRINTI	"hand"
?PRG39:	PRINTR	"."


	.FUNCT	PUB-OBJECT-F
	EQUAL?	PRSA,V?THROUGH,V?WALK-TO \?CCL3
	EQUAL?	HERE,PUB \?CCL6
	PRINT	LOOK-AROUND
	CRLF	
	RTRUE	
?CCL6:	EQUAL?	HERE,COUNTRY-LANE \?CCL10
	CALL2	DO-WALK,P?WEST
	RSTACK	
?CCL10:	CALL1	V-WALK-AROUND
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?DISEMBARK,V?LEAVE,V?EXIT \FALSE
	EQUAL?	HERE,PUB \?PRG16
	CALL2	DO-WALK,P?EAST
	RSTACK	
?PRG16:	PRINT	LOOK-AROUND
	CRLF	
	RTRUE	


	.FUNCT	PUB-F,RARG
	EQUAL?	RARG,M-ENTER \?CCL3
	ZERO?	TOWEL-OFFERED \?CCL3
	EQUAL?	IDENTITY-FLAG,FORD \?CCL3
	CALL	QUEUE,I-UNEASY,-1
	PUT	STACK,0,1
	RFALSE	
?CCL3:	EQUAL?	RARG,M-LOOK \?CCL8
	PRINTR	"The Pub is pleasant and cheerful and full of pleasant and cheerful people who don't know they've got about twelve minutes to live and are therefore having a spot of lunch. Some music is playing on an old jukebox. The exit is east."
?CCL8:	EQUAL?	RARG,M-END \FALSE
	FSET?	BEER,NDESCBIT \FALSE
	IN?	FORD,HERE \FALSE
	EQUAL?	IDENTITY-FLAG,FORD /FALSE
	FCLEAR	BEER,NDESCBIT
	CALL	QUEUE,I-FORD,2
	PUT	STACK,0,1
	SET	'FORD-COUNTER,5
	CRLF	
	PRINTI	"Ford buys "
	PRINTD	BEER
	PRINTR	" and offers half to you. ""Muscle relaxant..."" he says, impenetrably."


	.FUNCT	BAR-F
	EQUAL?	PRSA,V?LOOK-BEHIND \FALSE
	ICALL	PERFORM,V?EXAMINE,PUB-SHELF
	RTRUE	


	.FUNCT	PUB-SHELF-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET	PUB-SHELF,NDESCBIT
	PRINTI	"On the shelf behind the bar is the usual array of bottles, glasses and soggy beermats"
	ZERO?	PEANUTS-BOUGHT \?CND6
	FSET	PEANUTS,TAKEBIT
	FSET	PEANUTS,TRYTAKEBIT
	ZERO?	SANDWICH-BOUGHT /?PRG13
	PRINTI	", and"
	JUMP	?PRG15
?PRG13:	PRINTC	44
?PRG15:	PRINTI	" some packets of peanuts"
?CND6:	ZERO?	SANDWICH-BOUGHT \?PRG21
	FSET	SANDWICH,TAKEBIT
	FSET	SANDWICH,TRYTAKEBIT
	PRINTI	", and a plate of uninviting "
	PRINTD	SANDWICH
	PRINTI	"es"
?PRG21:	PRINTR	"."


	.FUNCT	MUSIC-F
	EQUAL?	PRSA,V?ENJOY,V?LISTEN \FALSE
	ICALL	PERFORM,V?LISTEN,JUKEBOX
	RTRUE	


	.FUNCT	JUKEBOX-F
	EQUAL?	PRSA,V?LISTEN \?CCL3
	PRINTI	"The song is "
	RANDOM	100
	LESS?	25,STACK /?CCL8
	PRINTR	"a Walker Brothers single, ""The Sun Ain't Gonna Shine Anymore."""
?CCL8:	RANDOM	100
	LESS?	33,STACK /?CCL12
	PRINTR	"""Get Back"" by the Beatles."
?CCL12:	RANDOM	100
	LESS?	50,STACK /?PRG19
	PRINTR	"""Hey Jude"" by the Beatles (Footnote 4). It's a particular favourite, and listening to it calms you down, and cheers you up."
?PRG19:	PRINTI	"""Tie a Yellow Ribbon."""
	EQUAL?	IDENTITY-FLAG,FORD \?CND21
	PRINTR	" You can't stand it, and are pleased to think that this is probably the last time it will ever be heard."
?CND21:	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?LAMP-OFF \FALSE
	CALL2	PRIVATE,STR?77
	RSTACK	


	.FUNCT	BARMAN-F
	EQUAL?	BARMAN,WINNER \?CCL3
	EQUAL?	PRSA,V?TELL-ABOUT \?CCL6
	EQUAL?	PRSO,ME \?CCL6
	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?ASK-ABOUT,BARMAN,PRSI
	SET	'WINNER,BARMAN
	RTRUE	
?CCL6:	EQUAL?	PRSA,V?HELLO \?CCL10
	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?HELLO,BARMAN
	SET	'WINNER,BARMAN
	RTRUE	
?CCL10:	EQUAL?	PRSA,V?GIVE \?PRG16
	EQUAL?	PRSO,ME \?PRG16
	EQUAL?	PRSI,PEANUTS,BEER,SANDWICH \?PRG16
	ICALL	PERFORM,V?BUY,PRSI
	RTRUE	
?PRG16:	PRINTR	"The barman ignores you and keeps polishing the other end of the bar."
?CCL3:	EQUAL?	PRSA,V?ASK-FOR \FALSE
	EQUAL?	PRSI,PEANUTS,BEER,SANDWICH \FALSE
	ICALL	PERFORM,V?BUY,PRSI
	RTRUE	


	.FUNCT	BEER-F
	EQUAL?	PRSA,V?COUNT,V?ENJOY,V?DRINK /?PRD5
	EQUAL?	PRSA,V?TAKE,V?RUB,V?SMELL \?CCL3
?PRD5:	FSET?	BEER,NDESCBIT \?CCL3
	PRINTR	"You'd better buy some first."
?CCL3:	EQUAL?	PRSA,V?COUNT \?CCL11
	PRINTR	"Lots."
?CCL11:	EQUAL?	PRSA,V?TAKE \?CCL15
	PRINTR	"Just drink it!"
?CCL15:	EQUAL?	IDENTITY-FLAG,FORD \?CCL19
	EQUAL?	PRSA,V?BUY \?CCL22
	FSET?	BEER,NDESCBIT /?CND23
	PRINTR	"You already did!"
?CND23:	FCLEAR	BEER,NDESCBIT
	IN?	ARTHUR,HERE \?PRG34
	PRINTI	"You order six pints of bitter -- three for you, three for Arthur. According to "
	PRINTD	GUIDE
	PRINTI	" this should"
	ICALL1	CUSHION
	CRLF	
	CRLF	
	PRINTR	"As you drink the first pint, you mention to Arthur that you are from a different planet, but it makes little impression. This surprises you, because you thought it was the sort of thing that would interest people."
?PRG34:	PRINTI	"You buy yourself three pints, which you calculate you will need to"
	ICALL1	CUSHION
	PRINTI	" This is a tip you picked up from "
	PRINTD	GUIDE
	PRINTR	"."
?CCL22:	EQUAL?	PRSA,V?ENJOY,V?DRINK \FALSE
	INC	'DRUNK-LEVEL
	IN?	ARTHUR,HERE /?CCL42
	PRINT	DOWN-WELL
	CRLF	
	RTRUE	
?CCL42:	EQUAL?	DRUNK-LEVEL,1 \?CCL46
	ADD	SCORE,FORD-POINT >SCORE
	SET	'FORD-POINT,0
	PRINT	DOWN-WELL
	PRINTR	" At least they managed to get something right on this benighted planet. You decide it's time to tell Arthur that the world is about to end. You tell him. Arthur is completely unperturbed. Curious. You wonder what sort of news it would take to disturb him."
?CCL46:	EQUAL?	DRUNK-LEVEL,2 \?PRG53
	PRINT	DOWN-WELL
	CALL1	SCENE-THROUGH-WINDOW
	RSTACK	
?PRG53:	PRINTR	"You've had enough."
?CCL19:	EQUAL?	PRSA,V?ENJOY,V?DRINK \?CCL57
	ADD	SCORE,5 >SCORE
	INC	'DRUNK-LEVEL
	EQUAL?	DRUNK-LEVEL,4 \?CCL60
	PRINTI	"You can hear the muffled noise of your home being demolished, and the taste of the beer sours in your mouth."
	CRLF	
	CRLF	
	ICALL	PERFORM,V?GET-DRUNK,ROOMS
	RTRUE	
?CCL60:	EQUAL?	DRUNK-LEVEL,3 \?CCL64
	CALL	QUEUE,I-FORD,-1
	PUT	STACK,0,1
	SET	'HOUSE-DEMOLISHED,TRUE-VALUE
	SET	'PROSSER-LYING,FALSE-VALUE
	PRINTR	"There is a distant crash which Ford explains is nothing to worry about, probably just your house being knocked down."
?CCL64:	EQUAL?	DRUNK-LEVEL,2 \?CCL68
	PRINTR	"It is really very pleasant stuff, with a very good dry, nutty flavour, some light froth on top, and a deep colour. It is at exactly room temperature. You reflect that the world cannot be all bad when there are such pleasures in it.

Ford mentions that the world is going to end in about twelve minutes."
?CCL68:	EQUAL?	DRUNK-LEVEL,1 \FALSE
	PRINTR	"It's very good beer, brewed by a small local company. You particularly like its flavour, which is why you woke up feeling so wretched this morning. You were at somebody's birthday party here in the Pub last night.

You begin to relax and enjoy yourself, so when Ford mentions that he's from a small planet in the vicinity of Betelgeuse, not from Guildford as he usually claims, you take it in your stride, and say, ""Oh yes, which part?"""
?CCL57:	EQUAL?	PRSA,V?BUY \FALSE
	FSET?	BEER,NDESCBIT \?PRG80
	ICALL	PERFORM,V?BUY,PEANUTS
	RTRUE	
?PRG80:	PRINTD	FORD
	PRINTR	" has already bought an enormous quantity for you!"


	.FUNCT	PEANUTS-F
	EQUAL?	IDENTITY-FLAG,FORD \?CCL3
	EQUAL?	PRSA,V?BUY \?CCL3
	ZERO?	PEANUTS-BOUGHT /?CND6
	PRINTR	"You did!"
?CND6:	SET	'PEANUTS-BOUGHT,TRUE-VALUE
	MOVE	PEANUTS,PROTAGONIST
	FCLEAR	PEANUTS,TRYTAKEBIT
	FCLEAR	PEANUTS,NDESCBIT
	PRINTI	"You buy some peanuts, which you'll need to replace protein loss from the"
	PRINT	BEAM
	PRINTI	", a tip you picked up from "
	PRINTD	GUIDE
	PRINTR	"."
?CCL3:	EQUAL?	PRSA,V?OPEN \?CCL13
	PRINTR	"Just eat 'em."
?CCL13:	EQUAL?	PRSA,V?ENJOY,V?EAT \?CCL17
	ZERO?	EARTH-DEMOLISHED /?CCL17
	ZERO?	GROGGY /?CCL17
	SET	'GROGGY,FALSE-VALUE
	MOVE	PEANUTS,PUB
	FSET	PEANUTS,TRYTAKEBIT
	FSET	PEANUTS,NDESCBIT
	PRINTI	"You feel stronger as the peanuts replace some of the protein you lost in the"
	PRINT	BEAM
	PRINTR	"."
?CCL17:	EQUAL?	PRSA,V?BUY \?CCL24
	EQUAL?	HERE,PUB \?CCL24
	PRINTR	"However much you clear your throat, wave your forefinger, or wiggle your eyebrows, the barman pays no attention, but carries on wiping another part of the bar."
?CCL24:	EQUAL?	PRSA,V?EAT,V?TAKE \FALSE
	FSET?	PEANUTS,TRYTAKEBIT \FALSE
	EQUAL?	HERE,PUB \FALSE
	PRINT	HANDS-OFF
	CRLF	
	RTRUE	


	.FUNCT	SANDWICH-F
	EQUAL?	PRSA,V?BUY \?CCL3
	ZERO?	SANDWICH-BOUGHT \?CCL3
	MOVE	SANDWICH,PROTAGONIST
	FSET	SANDWICH,TAKEBIT
	FCLEAR	SANDWICH,TRYTAKEBIT
	FCLEAR	SANDWICH,NDESCBIT
	SET	'SANDWICH-BOUGHT,TRUE-VALUE
	PRINTI	"The barman gives you a "
	PRINTD	SANDWICH
	PRINTR	". The bread is like the stuff that stereos come packed in, the cheese would be great for rubbing out spelling mistakes, and margarine and pickle have performed an unedifying chemical reaction to produce something that shouldn't be, but is, turquoise. Since it is clearly unfit for human consumption you are grateful to be charged only a pound for it."
?CCL3:	EQUAL?	PRSA,V?BUY \?CCL9
	PRINTR	"You already did."
?CCL9:	EQUAL?	PRSA,V?ENJOY,V?EAT,V?TAKE \?CCL13
	FSET?	SANDWICH,TRYTAKEBIT \?CCL13
	EQUAL?	HERE,PUB \?CCL13
	PRINT	HANDS-OFF
	CRLF	
	RTRUE	
?CCL13:	EQUAL?	PRSA,V?ENJOY,V?EAT \FALSE
	MOVE	SANDWICH,LOCAL-GLOBALS
	SUB	SCORE,30 >SCORE
	EQUAL?	IDENTITY-FLAG,FORD \?PRG26
	PRINTI	"You swallow with revulsion, astonished that life forms which have spent 4.6 billion years evolving cannot produce a better "
	PRINTD	SANDWICH
	PRINTR	" than this."
?PRG26:	PRINTR	"It is one of the least rewarding taste experiences you can recall."


	.FUNCT	I-VOGONS
	CALL	QUEUE,I-VOGONS,-1
	PUT	STACK,0,1
	INC	'VOGON-COUNTER
	EQUAL?	VOGON-COUNTER,1 \?CCL3
	EQUAL?	HERE,PUB \?CND4
	ICALL1	GO-TO-LANE
?CND4:	MOVE	FLEET,HERE
	CRLF	
	EQUAL?	IDENTITY-FLAG,FORD \?PRG11
	MOVE	ARTHUR,HERE
	PRINTI	"Right on schedule (according to the news you picked up last night on your Sub-Etha Sens-O-Matic), a huge "
	PRINTD	FLEET
	PRINTR	" hurtles noisily through the sky. Time is very, very short. Storms break in the wake of the ships, the wind whips at you and makes it difficult to stand. You grab hold of a tree."
?PRG11:	PRINTI	"With a noise like a cross between Led Zeppelin's farewell concert and the eruption of Krakatoa, a huge "
	PRINTD	FLEET
	PRINTI	" flies overhead and announces that the Earth will be demolished to make way for a new hyperspace bypass in ""two of your Earth minutes."""
	CRLF	
	IN?	FORD,HERE \?CND13
	ZERO?	FORD-COUNTER \?CND13
	MOVE	FORD,LOCAL-GLOBALS
	CALL2	INT,I-FORD
	PUT	STACK,0,0
	SET	'FORD-GONE,TRUE-VALUE
	MOVE	TOWEL,HERE
	FCLEAR	TOWEL,TRYTAKEBIT
	CRLF	
	PRINTI	"Ford drops the towel and dashes away."
	CRLF	
?CND13:	CALL2	HELD?,THING
	ZERO?	STACK /FALSE
	MOVE	THING,LOCAL-GLOBALS
	CRLF	
	PRINTI	"In all the turmoil, "
	IN?	THING,GOWN \?PRG29
	PRINTI	"the "
	PRINTD	THING
	PRINTI	" drops out of your pocket and rolls away."
	JUMP	?PRG31
?PRG29:	PRINTI	"you drop the "
	PRINTD	THING
	PRINTI	" and it rolls away."
?PRG31:	PRINTI	" It is the least of your worries. Anyway,"
	PRINT	GET-RID
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	VOGON-COUNTER,2 \?CCL34
	CRLF	
	PRINTI	"The vast yellow ships thunder across the sky, spreading waves of terror and panic in their wake. The voice of the "
	PRINTD	VOGON-CAPTAIN
	PRINTI	" slams across the country, insisting that the planning charts and demolition orders have been available at the local planning office in Alpha Centauri for fifty years and it's too late to start making a fuss about it now."
	CRLF	
	ZERO?	FORD-GONE \TRUE
	CRLF	
	EQUAL?	IDENTITY-FLAG,FORD \?CCL41
	CALL	HELD?,THUMB,PROTAGONIST
	ZERO?	STACK /?PRG54
	IN?	THUMB,PROTAGONIST \?PRG50
	PRINTI	"The "
	PRINTD	THUMB
	PRINTI	" in "
	PRINTD	HANDS
	PRINTI	" begins to whine."
	JUMP	?PRG52
?PRG50:	PRINTI	"You remove the "
	PRINTD	THUMB
	PRINTI	" from your satchel."
?PRG52:	PRINTI	" Lights pulsate across its surface. "
	PRINT	THUMB-FUMBLE
	MOVE	THUMB,HERE
	SET	'P-IT-OBJECT,THUMB
	JUMP	?PRG56
?PRG54:	PRINTI	"You wish you were holding your "
	PRINTD	THUMB
	PRINTC	46
?PRG56:	PRINTR	" Arthur is struggling desperately towards you. The end of this planet is now only seconds away."
?CCL41:	MOVE	THUMB,HERE
	SET	'P-IT-OBJECT,THUMB
	PRINTR	"Throughout the noise, Ford is shouting at you. He removes a small black device from his satchel, but accidentally drops it at your feet."
?CCL34:	EQUAL?	VOGON-COUNTER,3 \?CCL61
	CRLF	
	PRINTI	"Fierce gales whip across the land, and thunder bangs continuously through the air in the wake of the giant ships. "
	EQUAL?	IDENTITY-FLAG,ARTHUR \?CCL66
	ZERO?	FORD-GONE \?CCL66
	PRINTI	"Ford fights to reach you, but the wind is too fierce. Further announcements from the "
	PRINTD	VOGON-CAPTAIN
	PRINTR	" make it clear that demolition will begin in just a few seconds.

Through the blinding rain, you see lights flickering on the small device."
?CCL66:	EQUAL?	IDENTITY-FLAG,FORD \?CCL72
	IN?	THUMB,HERE \?CCL72
	ZERO?	FLUFF-TO-GOWN /?PRG77
	FSET	COUNTRY-LANE,REVISITBIT
?PRG77:	PRINT	DRIVEN-BACK
	PRINTI	" Fortunately, at this point, Arthur picks up the Thumb, and somehow manages to push the right button"
	FSET?	THUMB,MUNGEDBIT \?PRG88
	PRINTI	". Unfortunately, the"
	PRINT	THUMB-CLICKS
	SET	'VOGON-COUNTER,4
	PRINTC	32
	ICALL1	I-VOGONS
	RTRUE	
?PRG88:	PRINTC	46
	CRLF	
	CRLF	
	ICALL2	JIGS-UP,STR?79
	RTRUE	
?CCL72:	CRLF	
	RTRUE	
?CCL61:	EQUAL?	VOGON-COUNTER,5 \FALSE
	PRINTI	"The Earth is destroyed by the "
	PRINTD	FLEET
	ZERO?	FLUFF-TO-GOWN /?CND94
	FSET	COUNTRY-LANE,REVISITBIT
?CND94:	ICALL2	JIGS-UP,STR?36
	RTRUE	


	.FUNCT	GO-TO-LANE
	SET	'LYING-DOWN,FALSE-VALUE
	CRLF	
	PRINTI	"You hear sounds of panic from the street. You "
	EQUAL?	IDENTITY-FLAG,FORD \?CCL5
	IN?	ARTHUR,HERE /?CCL5
	PRINTI	"leave the Pub and run into Arthur..."
	CRLF	
	CRLF	
	JUMP	?CND3
?CCL5:	EQUAL?	IDENTITY-FLAG,FORD \?PRG15
	PRINTI	"and Arthur"
	JUMP	?PRG17
?PRG15:	PRINTI	"and Ford"
?PRG17:	PRINTI	" rush outside..."
	CRLF	
	CRLF	
?CND3:	ICALL2	GOTO,COUNTRY-LANE
	EQUAL?	IDENTITY-FLAG,FORD \?CCL21
	MOVE	ARTHUR,COUNTRY-LANE
	RTRUE	
?CCL21:	MOVE	FORD,COUNTRY-LANE
	RTRUE	


	.FUNCT	FLEET-F
	EQUAL?	PRSA,V?ENJOY \?CCL3
	PRINT	ZEN
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?THROUGH,V?WALK-TO \?CCL7
	SET	'AWAITING-REPLY,11
	CALL	QUEUE,I-REPLY,2
	PUT	STACK,0,1
	PRINTR	"From here?"
?CCL7:	EQUAL?	PRSA,V?EXAMINE \FALSE
	EQUAL?	HERE,HOLD,AIRLOCK,CAPTAINS-QUARTERS /FALSE
	PRINTR	"The fleet consists of terrifying numbers of huge, ugly, yellow ships, all scarred with the results of many such past demolition jobs. Chicago's John Hancock tower, knocked about a bit and painted yellow, is what they each look like. That is, knocked about a bit, painted yellow, and flying."


	.FUNCT	LEAVE-EARTH
	CALL2	INT,I-HOUSEWRECK
	PUT	STACK,0,0
	CALL2	INT,I-BULLDOZER
	PUT	STACK,0,0
	CALL2	INT,I-PROSSER
	PUT	STACK,0,0
	CALL2	INT,I-FORD
	PUT	STACK,0,0
	CALL2	INT,I-VOGONS
	PUT	STACK,0,0
	SET	'HEADACHE,FALSE-VALUE
	SET	'BULLDOZER-COUNTER,0
	SET	'PROSSER-COUNTER,0
	SET	'PROSSER-LYING,FALSE-VALUE
	SET	'FORD-COUNTER,0
	SET	'DRUNK-LEVEL,0
	SET	'HOUSE-DEMOLISHED,FALSE-VALUE
	SET	'VOGON-COUNTER,0
	SET	'EARTH-DEMOLISHED,TRUE-VALUE
	SET	'IDENTITY-FLAG,ARTHUR
	MOVE	ARTHUR,GLOBAL-OBJECTS
	MOVE	DOG,LOCAL-GLOBALS
	MOVE	FLEET,LOCAL-GLOBALS
	MOVE	FORD,LOCAL-GLOBALS
	CALL2	HELD?,SANDWICH
	ZERO?	STACK \?CND1
	ZERO?	SANDWICH-BOUGHT /?CND1
	MOVE	SANDWICH,LOCAL-GLOBALS
?CND1:	FSET	BEER,NDESCBIT
	FCLEAR	PROSSER,TOUCHBIT
	FCLEAR	FRONT-OF-HOUSE,NDESCBIT
	FCLEAR	FRONT-OF-HOUSE,TOUCHBIT
	FCLEAR	COUNTRY-LANE,TOUCHBIT
	RTRUE	


	.FUNCT	ARTHUR-F
	EQUAL?	IDENTITY-FLAG,ARTHUR \?CCL3
	EQUAL?	ARTHUR,PRSO \?CCL6
	ICALL	PERFORM,PRSA,ME,PRSI
	RTRUE	
?CCL6:	ICALL	PERFORM,PRSA,PRSO,ME
	RTRUE	
?CCL3:	EQUAL?	ARTHUR,WINNER \?CCL8
	IN?	FLEET,HERE \?CCL11
	PRINT	ABOVE-NOISE
	CRLF	
	JUMP	?CND9
?CCL11:	EQUAL?	PRSA,V?FOLLOW \?CCL15
	EQUAL?	HERE,FRONT-OF-HOUSE \?CCL15
	EQUAL?	PRSO,ME \?CCL15
	ZERO?	PROSSER-LYING /?CCL21
	PRINTI	"Arthur seems willing to do so."
	CRLF	
	JUMP	?CND9
?CCL21:	ICALL2	BUT-THAT-MAN,STR?81
	CRLF	
	JUMP	?CND9
?CCL15:	EQUAL?	PRSA,V?DRINK \?PRG33
	EQUAL?	PRSO,BEER \?PRG33
	FSET?	BEER,NDESCBIT \?PRG31
	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?DRINK,BEER
	SET	'WINNER,ARTHUR
	RTRUE	
?PRG31:	PRINTI	"Arthur seems to be waiting to follow your lead."
	CRLF	
	JUMP	?CND9
?PRG33:	PRINTI	"Arthur looks too confused to respond."
	CRLF	
?CND9:	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL8:	EQUAL?	PRSA,V?ASK-FOR,V?TELL,V?HELLO /?PRD38
	EQUAL?	PRSA,V?TELL-ABOUT,V?ASK-ABOUT \?CCL36
?PRD38:	EQUAL?	IDENTITY-FLAG,TRILLIAN \?CCL36
	EQUAL?	PRSO,ARTHUR \?CCL36
	ZERO?	FLUFF-REMOVED /?PRG45
	FSET	ARTHUR,RLANDBIT
	ICALL1	I-ARTHUR
	JUMP	?CND42
?PRG45:	PRINTI	"You approach Arthur. He seems to find your tone a little cool, smiles unhappily, and wanders to the other end of the room."
	CRLF	
?CND42:	CALL	QUEUE,I-ARTHUR,2
	PUT	STACK,0,1
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL36:	EQUAL?	PRSA,V?ASK-FOR,V?ASK-ABOUT,V?TELL-ABOUT \?CCL48
	EQUAL?	PRSO,ARTHUR \?CCL48
	EQUAL?	IDENTITY-FLAG,TRILLIAN \?CCL48
	ICALL	PERFORM,V?HELLO,ARTHUR
	RTRUE	
?CCL48:	EQUAL?	PRSA,V?CARVE \?CCL53
	EQUAL?	PRSI,MEMORIAL \?CCL53
	ICALL	PERFORM,V?CARVE,YOUR-NAME,MEMORIAL
	RTRUE	
?CCL53:	EQUAL?	PRSA,V?GIVE \?CCL57
	EQUAL?	PRSO,TOWEL \?CCL57
	EQUAL?	HERE,FRONT-OF-HOUSE \?CCL57
	ZERO?	TOWEL-OFFERED \?CCL57
	SET	'TOWEL-OFFERED,TRUE-VALUE
	PRINTI	"Inexplicably, Arthur takes no notice of the towel which, magnificently, you are trying to return to him. Instead, he says, ""Ford, what about my home?""

You start guiltily. Does he actually KNOW that the Earth is about to be destroyed? You start to ask him, then stop. If he knows, what the Zark is he doing lying here in the mud in front of...

You look around. You notice the "
	PRINTD	BULLDOZER
	PRINTI	" properly for the first time. You notice Arthur's house. You notice the workmen. The penny drops. His HOUSE is about to be demolished. You feel like a complete...what's the word?"
	CALL1	IDIOT?
	ZERO?	STACK /?PRG69
	PRINTI	"Thank you. An idiot is exactly what you feel like."
	JUMP	?PRG71
?PRG69:	PRINTI	"No, actually, ""idiot"" was the word I was looking for."
?PRG71:	CRLF	
	CRLF	
	PRINTI	"In a reckless moment you go completely mad and decide that you ought to take Arthur with you. You try to tell Arthur about the importance of getting a drink, but he's rambling on about a man called Prosser."
	CRLF	
	RETURN	2
?CCL57:	EQUAL?	PRSO,SANDWICH \?CCL76
	EQUAL?	PRSA,V?GIVE \?CCL76
	MOVE	SANDWICH,ARTHUR
	PRINTR	"Arthur takes it, sniffs it suspiciously, and wisely decides that it's safer in his pocket than in his stomach."
?CCL76:	EQUAL?	PRSA,V?GIVE \?CCL82
	EQUAL?	PRSO,SATCHEL-FLUFF \?CCL82
	ZERO?	HOUSE-DEMOLISHED /?PRG90
	MOVE	SATCHEL-FLUFF,LOCAL-GLOBALS
	SET	'FLUFF-TO-GOWN,TRUE-VALUE
	PRINTR	"Arthur hiccups, takes the fluff, and sticks it in his pocket."
?PRG90:	PRINTR	"Arthur blinks several times, but doesn't take the fluff. Perhaps if he had a few drinks in him..."
?CCL82:	EQUAL?	PRSA,V?EXAMINE \?CCL93
	EQUAL?	IDENTITY-FLAG,TRILLIAN \?CCL93
	PRINTI	"Arthur seems nice and well meaning, but also terribly shy."
	ZERO?	FLUFF-REMOVED \?CND98
	MOVE	JACKET-FLUFF,HERE
	CALL	QUEUE,I-ARTHUR,-1
	PUT	STACK,0,1
	PRINTI	" He has tried to start a "
	PRINTD	CONVERSATION
	PRINTR	" with you several times, but still hasn't gotten past ""Hello."" He has an enormous, unsightly ball of fluff on his jacket."
?CND98:	CRLF	
	RTRUE	
?CCL93:	EQUAL?	PRSA,V?FOLLOW \?CCL103
	EQUAL?	FOLLOW-FLAG,4 \?CCL103
	CALL2	DO-WALK,P?EAST
	RSTACK	
?CCL103:	EQUAL?	PRSA,V?PICK-UP \?CCL107
	EQUAL?	IDENTITY-FLAG,TRILLIAN \?CCL107
	ICALL	PERFORM,V?PICK-UP,ZAPHOD
	RTRUE	
?CCL107:	EQUAL?	PRSA,V?LISTEN \FALSE
	EQUAL?	IDENTITY-FLAG,TRILLIAN \FALSE
	ZERO?	FLUFF-REMOVED /FALSE
	PRINTR	"Unfortunately, you seem to have no choice."


	.FUNCT	IDIOT?
	CRLF	
	CRLF	
	PRINTC	62
	PUTB	P-INBUF,1,0
	READ	P-INBUF,P-LEXV
	GET	P-LEXV,1
	EQUAL?	STACK,W?IDIOT /TRUE
	RFALSE	


	.FUNCT	I-UNEASY
	INC	'UNEASY-COUNTER
	EQUAL?	HERE,PUB /?CND1
	CALL2	INT,I-UNEASY
	PUT	STACK,0,0
	RFALSE	
?CND1:	CRLF	
	EQUAL?	UNEASY-COUNTER,1 \?CCL5
	PRINTR	"You feel uneasy about something."
?CCL5:	EQUAL?	UNEASY-COUNTER,2,3,4 \?PRG12
	PRINTR	"You still feel uneasy."
?PRG12:	PRINTI	"The sense of uneasiness you've been so busy ignoring now utterly engulfs you, as you realise that you've broken the fundamental rule of time travel: ""Do as you would have done by."" The rational foundation of the Universe crashes and within a few seconds the whole of creation ceases ever to have exis"
	CRLF	
	CRLF	
	CRLF	
	QUIT	
	RTRUE	


	.FUNCT	I-ARTHUR
	CALL	QUEUE,I-ARTHUR,-1
	PUT	STACK,0,1
	EQUAL?	IDENTITY-FLAG,TRILLIAN \?CCL3
	ZERO?	FLUFF-REMOVED /?CCL6
	FSET?	ARTHUR,RLANDBIT /?CND7
	CRLF	
?CND7:	FCLEAR	ARTHUR,RLANDBIT
	IN?	ARTHUR,HERE /?PRG14
	MOVE	ARTHUR,HERE
	PRINTR	"Arthur follows you like an eager puppy."
?PRG14:	PRINTI	"Arthur tries, unsuccessfully, to interest you by talking about "
	CALL2	PICK-ONE,BORES
	PRINT	STACK
	CRLF	
	RTRUE	
?CCL6:	RANDOM	100
	LESS?	20,STACK /FALSE
	MOVE	ARTHUR,HERE
	MOVE	JACKET-FLUFF,HERE
	CRLF	
	PRINTR	"Arthur walks up and says, ""Hello, again."" He looks shy, embarrassed and stuck for anything else to say, and quickly walks to the other end of the room."
?CCL3:	IN?	ARTHUR,HERE /FALSE
	MOVE	ARTHUR,HERE
	PRINTR	"Arthur follows you."


	.FUNCT	SCENE-THROUGH-WINDOW
	MOVE	ARTHUR,FRONT-OF-HOUSE
	CALL2	INT,I-ARTHUR
	PUT	STACK,0,0
	SET	'HOUSE-DEMOLISHED,TRUE-VALUE
	SET	'PROSSER-LYING,FALSE-VALUE
	SET	'FOLLOW-FLAG,4
	CALL	QUEUE,I-FOLLOW,2
	PUT	STACK,0,1
	PRINTI	" You hear a muffled crash. It's probably Arthur's little house getting knocked down, which you tell him. This DOES upset him, and he tears out the door.

Through the window, you see him running up the lane. A small dog chases after him, yapping, "
	ZERO?	DOG-FED \?CTR4
	IN?	SANDWICH,ARTHUR \?PRG10
?CTR4:	SET	'DOG-FED,TRUE-VALUE
	PRINTI	"and he throws it a "
	PRINTD	SANDWICH
	PRINTI	". The dog devours the sandwich"
	PRINT	WITH-PASSION
	CRLF	
	RTRUE	
?PRG10:	PRINTR	"but he ignores it. The dog gulps uncomfortably."

	.ENDI
