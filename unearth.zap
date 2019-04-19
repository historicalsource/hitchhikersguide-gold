

	.FUNCT	LAIR-OBJECT-F
	EQUAL?	PRSA,V?DISEMBARK,V?EXIT,V?LEAVE /?CCL3
	EQUAL?	PRSA,V?WALK-TO,V?BOARD,V?THROUGH \FALSE
?CCL3:	CALL1	V-WALK-AROUND
	RSTACK	


	.FUNCT	INNER-LAIR-ENTER-F
	FSET?	BEAST,MUNGEDBIT \?PRG4
	RETURN	INNER-LAIR
?PRG4:	PRINTI	"The Beast blocks the exit."
	CRLF	
	RFALSE	


	.FUNCT	LAIR-F,RARG
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"This is the lair of the "
	PRINTD	BEAST
	PRINTR	". There are exits east and southwest."
?CCL3:	EQUAL?	RARG,M-END \FALSE
	FSET?	LAIR,NDESCBIT /FALSE
	SET	'DREAMING,TRUE-VALUE
	FSET	LAIR,NDESCBIT
	FCLEAR	SARCASTIC-NAME,INVISIBLE
	FCLEAR	BEAST-NAME,INVISIBLE
	CALL	QUEUE,I-BEAST,2
	PUT	STACK,0,1
	CRLF	
	PRINTI	"The Beast whips its evil-smelling tail away from your nose and bellows a brain-shattering roar. By suddenly popping out of nowhere you have disturbed its train of thought. However, "
	FSET?	LAIR,REVISITBIT \?PRG17
	PRINTI	"the Beast is beginning to get used to this sort of thing, shrugs it off, and sinks ten or so of"
	PRINT	CLAWS
	ICALL2	JIGS-UP,STR?140
	RTRUE	
?PRG17:	PRINTI	"since its train of thought was the usual one, and in fact the only one it knows, which goes like this ""hungry ... hungry ... hungry ... hungry ... bad-tempered ... hungry ..."", it soon starts to chug along again."
	CRLF	
	CRLF	
	PRINT	BEAST-DESC
	PRINTR	" It advances on you, and roars out a demand that you say your name."


	.FUNCT	OUTER-LAIR-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a large walled courtyard. Strewn about are a profusion of gnawed bones bleaching in the sun. In case the significance of these fails to strike you, there is also a "
	PRINTD	MEMORIAL
	PRINTI	" in the middle of the courtyard, on which the Beast has roughly carved the names of all its victims."
	IN?	STONE,HERE \?CND6
	CRLF	
	PRINTI	"Some "
	PRINTD	STONE
	PRINTR	"s lie near the exit to the west."
?CND6:	CRLF	
	RTRUE	


	.FUNCT	MEMORIAL-F
	EQUAL?	PRSA,V?CARVE \?CCL3
	EQUAL?	MEMORIAL,PRSI \?CCL3
	FSET?	BEAST,MUNGEDBIT \?CCL8
	CALL1	V-DIG
	RSTACK	
?CCL8:	EQUAL?	PRSO,NAME \?CCL10
	PRINTI	"Whose name? The "
	PRINTD	BEAST-NAME
	PRINTR	"? Your aunt's name? One of the Infinite Unknowable names of Buddha? How about the name of Fred who runs (or rather ran) your local chip shop? At least that's a short name -- you might have time to write it before the Beast eats you."
?CCL10:	EQUAL?	PRSO,SARCASTIC-NAME \?CCL14
	PRINTR	"Concentrate. Learn to distinguish between genuinely helpful suggestions and mere sarcasm."
?CCL14:	FSET?	TOWEL,WORNBIT /?CCL18
	CALL	QUEUE,I-BEAST,2
	PUT	STACK,0,1
	PRINTI	"Before you even chip the first letter, the Beast sees you and hurls you spinning away with a bellow of rage."
	PRINT	GETTING-CLOSE
	CRLF	
	RTRUE	
?CCL18:	ZERO?	BEARINGS-LOST /?CCL22
	PRINTR	"You cannot see and have lost your bearings. You stumble hopelessly and begin to arouse the Beast's suspicions. It's stupid but not THAT stupid."
?CCL22:	EQUAL?	PRSO,ME,ARTHUR,YOUR-NAME \?PRG40
	FSET?	BEAST,MUNGEDBIT \?PRG31
	PRINTR	"You already did that!"
?PRG31:	PRINTI	"You chip away with the stone. It's not your best writing, what with your mounting sense of panic and a towel wrapped around your head. However, it suffices..."
	CRLF	
	CRLF	
	PRINT	JUST-AS
	ZERO?	NAME-TOLD /?PRG38
	FSET	BEAST,MUNGEDBIT
	CALL	QUEUE,I-BEAST,9
	PUT	STACK,0,1
	PRINTR	"suddenly sees your name freshly carved on its memorial of remembrance. Mystery solved. It realises it must have already eaten you in a fit of absentmindedness. (Its mind is very very small and quite frequently absent.) It decides to give up the rest of its afternoon to the twin arts of digestion and contemplation. It settles down for a snooze."
?PRG38:	PRINTI	"sees """
	PRINTD	ARTHUR
	PRINTI	""" freshly carved on the "
	PRINTD	MEMORIAL
	PRINTR	". This doesn't ring any bells with the Beast. It roars with fury, and eyes the thing it can't see because it's got a towel on its head (i.e. you) with deepening suspicion."
?PRG40:	PRINT	JUST-AS
	PRINTI	"suddenly sees "
	EQUAL?	PRSO,BEAST-NAME,BEAST \?PRG47
	PRINTI	"its own name"
	JUMP	?PRG49
?PRG47:	PRINTC	34
	PRINTD	PRSO
	PRINTC	34
?PRG49:	PRINTI	" freshly carved on the "
	PRINTD	MEMORIAL
	PRINTI	". This disconcerts it, as it has no recollection of eating "
	EQUAL?	PRSO,BEAST-NAME,BEAST \?PRG56
	PRINTI	"itself"
	JUMP	?PRG58
?PRG56:	PRINTI	"anyone by that name"
?PRG58:	PRINTC	46
	PRINT	SLOWLY-DAWNS
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?READ \?CCL61
	PRINTI	"Gleb Snardfitz, Bibs Trench, Zeke Fitzberry, Elmo Smith, "
	FSET?	BEAST,MUNGEDBIT \?PRG68
	PRINTD	ARTHUR
	PRINTI	", "
?PRG68:	PRINTR	"Brian ""Spike"" Berkowitz, Clybert Quackentotter..."
?CCL61:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"There are countless names carved on the "
	PRINTD	MEMORIAL
	PRINTC	58
	CRLF	
	ICALL	PERFORM,V?READ,MEMORIAL
	RTRUE	


	.FUNCT	STONE-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	FSET?	STONE,TRYTAKEBIT \?CCL3
	FCLEAR	STONE,NDESCBIT
	FCLEAR	STONE,TRYTAKEBIT
	RFALSE	
?CCL3:	EQUAL?	PRSA,V?DROP \?CCL7
	EQUAL?	HERE,OUTER-LAIR \?CCL7
	FSET	STONE,NDESCBIT
	FSET	STONE,TRYTAKEBIT
	RFALSE	
?CCL7:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"It's hard as a rock."


	.FUNCT	BEAST-DESCFCN,X
	FSET?	BEAST,MUNGEDBIT \?PRG6
	PRINTR	"The Beast is in the corner, sleeping peacefully (Footnote 5)."
?PRG6:	PRINTI	"The "
	PRINTD	BEAST
	PRINTR	" is here, looking particularly nasty and hungry."


	.FUNCT	BEAST-F
	EQUAL?	BEAST,WINNER \?CCL3
	FSET?	TOWEL,WORNBIT \?CCL6
	CALL1	V-SAY
	RSTACK	
?CCL6:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL8
	EQUAL?	PRSO,ME \?CCL8
	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?ASK-ABOUT,BEAST,PRSI
	SET	'WINNER,BEAST
	RTRUE	
?CCL8:	EQUAL?	PRSA,V?HELLO \?CCL12
	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?HELLO,BEAST
	SET	'WINNER,BEAST
	RTRUE	
?CCL12:	EQUAL?	PRSA,V?WHAT \?CCL14
	EQUAL?	PRSO,OBJECT-OF-GAME \?CCL14
	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?ASK-ABOUT,BEAST,OBJECT-OF-GAME
	SET	'WINNER,BEAST
	RTRUE	
?CCL14:	ZERO?	NAME-TOLD \?CCL18
	EQUAL?	PRSA,V?MY-NAME \?CCL18
	EQUAL?	PRSO,NAME \?CCL18
	EQUAL?	PRSI,ARTHUR \?CCL24
	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?SAY-NAME,YOUR-NAME
	SET	'WINNER,BEAST
	RTRUE	
?CCL24:	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?SAY-NAME,BEAST-NAME
	SET	'WINNER,BEAST
	RTRUE	
?CCL18:	ZERO?	NAME-TOLD \?PRG32
	EQUAL?	PRSA,V?I-AM \?PRG32
	EQUAL?	PRSO,ARTHUR \?CCL31
	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?SAY-NAME,YOUR-NAME
	SET	'WINNER,BEAST
	RTRUE	
?CCL31:	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?SAY-NAME,BEAST-NAME
	SET	'WINNER,BEAST
	RTRUE	
?PRG32:	PRINTI	"The Beast just roars at you."
	CRLF	
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?ASK-ABOUT,V?HELLO,V?TELL /?PRD37
	EQUAL?	PRSA,V?TELL-ABOUT,V?ASK-FOR \?CCL35
?PRD37:	EQUAL?	PRSO,BEAST \?CCL35
	FSET?	BEAST,MUNGEDBIT \?CCL42
	PRINTI	"The Beast is sleeping!"
	CRLF	
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL42:	FSET?	TOWEL,WORNBIT \FALSE
	ICALL1	SAID-WITH-TOWEL
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL35:	EQUAL?	PRSA,V?TELL-TIME \?CCL48
	EQUAL?	PRSI,YOUR-NAME \?CCL48
	ICALL	PERFORM,V?SAY-NAME,YOUR-NAME
	RTRUE	
?CCL48:	EQUAL?	PRSA,V?TELL-NAME \?CCL52
	EQUAL?	PRSO,YOUR-NAME \?CCL52
	ICALL	PERFORM,V?SAY-NAME,YOUR-NAME
	RTRUE	
?CCL52:	EQUAL?	PRSA,V?GIVE,V?SHOW \?CCL56
	EQUAL?	THING,PRSO \?CCL56
	CALL	QUEUE,I-BEAST,2
	PUT	STACK,0,1
	PRINTR	"The Beast stops in its tracks, deeply impressed, and compliments you on the quality of your aunts, and complains that all its aunts are complete horrors. It then continues its dreadful attack."
?CCL56:	EQUAL?	PRSA,V?THROW \?CCL62
	EQUAL?	PRSI,BEAST \?CCL62
	CALL1	IDROP
	ZERO?	STACK \?CCL62
	MOVE	PRSO,HERE
	ICALL	PERFORM,V?KILL,BEAST
	RTRUE	
?CCL62:	EQUAL?	PRSA,V?KILL \?CCL67
	EQUAL?	PRSO,BEAST \?CCL67
	FSET?	BEAST,MUNGEDBIT \?CND70
	ICALL	PERFORM,V?ALARM,BEAST
	RTRUE	
?CND70:	CALL	QUEUE,I-BEAST,2
	PUT	STACK,0,1
	PRINTR	"A footling effort. The shock waves of the Beast's laughter push you back."
?CCL67:	EQUAL?	PRSA,V?ALARM \?CCL75
	FSET?	BEAST,MUNGEDBIT \?CCL75
	PRINTI	"The Beast casually brushes you away with one of"
	PRINT	CLAWS
	ICALL2	JIGS-UP,STR?36
	RTRUE	
?CCL75:	EQUAL?	PRSA,V?ASK-ABOUT \?CCL81
	EQUAL?	PRSI,OBJECT-OF-GAME \?CCL81
	PRINTR	"""Eat. Carve name on memorial. Sleep. Eat more. Roar a lot. Stuff like that."""
?CCL81:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINT	BEAST-DESC
	CRLF	
	RTRUE	


	.FUNCT	I-BEAST
	CALL	QUEUE,I-BEAST,-1
	PUT	STACK,0,1
	CRLF	
	FSET?	BEAST,MUNGEDBIT \?CCL3
	MOVE	CHIPPER,PROTAGONIST
	FCLEAR	LAIR,NDESCBIT
	FSET	LAIR,REVISITBIT
	ICALL2	JIGS-UP,STR?141
	RTRUE	
?CCL3:	FSET?	TOWEL,WORNBIT \?CCL5
	PRINTI	"The Beast still thinks it can't see you, but it's so irritated at having an invisible object stumble around its lair that it swipes out angrily with one of"
	PRINT	CLAWS
	ICALL2	JIGS-UP,STR?142
	RTRUE	
?CCL5:	IN?	BEAST,HERE /?CCL9
	MOVE	BEAST,HERE
	MOVE	NAME,HERE
	SET	'BEAST-COUNTER,0
	PRINTR	"Bellowing with rage, the Beast charges after you."
?CCL9:	INC	'BEAST-COUNTER
	EQUAL?	BEAST-COUNTER,1 \?CCL14
	PRINTI	"With a head-splitting roar, the "
	PRINTD	BEAST
	PRINTR	" charges towards you."
?CCL14:	EQUAL?	BEAST-COUNTER,2 \?CCL18
	ZERO?	NAME-TOLD \?CCL18
	PRINTI	"The Beast, sharpening"
	PRINT	CLAWS
	PRINTR	", demands again that you say your name."
?CCL18:	GRTR?	BEAST-COUNTER,4 \?PRG25
	CALL1	BEAST-DEATH
	RSTACK	
?PRG25:	PRINTR	"The Beast is nearly upon you."


	.FUNCT	BEAST-DEATH
	PRINTI	"With a vast savage roar, the Beast tears you limb from limb with"
	PRINT	CLAWS
	ICALL2	JIGS-UP,STR?143
	RTRUE	


	.FUNCT	YOUR-NAME-F
	EQUAL?	PRSA,V?WHAT \?CCL3
	ICALL	PERFORM,V?WHO,ME
	RTRUE	
?CCL3:	EQUAL?	HERE,OUTER-LAIR \?CCL5
	FSET?	BEAST,MUNGEDBIT /FALSE
?CCL5:	EQUAL?	PRSA,V?MOVE,V?RUB,V?EXAMINE \FALSE
	PRINTR	"Huh?"


	.FUNCT	NUT-COM-INTERFACE-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	FSET?	NUT-COM-INTERFACE,TRYTAKEBIT \?CCL3
	FCLEAR	NUT-COM-INTERFACE,TRYTAKEBIT
	FCLEAR	NUT-COM-INTERFACE,NDESCBIT
	FSET	SKELETON,TOUCHBIT
	ADD	SCORE,25 >SCORE
	RFALSE	
?CCL3:	EQUAL?	PRSA,V?TAKE \?CCL7
	CALL2	RUNNING?,I-TEA
	ZERO?	STACK /?CCL7
	PRINTR	"You get a powerful electric shock."
?CCL7:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"The "
	PRINTD	PRSO
	PRINTI	" is square, about ten inches on each side."
	ICALL1	FINE-PRODUCT
	CRLF	
	RTRUE	


	.FUNCT	I-CARELESS-WORDS
	CRLF	
	SET	'FLEET-PROB,60
	PRINTI	"It is of course well known that careless talk costs lives, but the full scale of the problem is not always appreciated. For instance, at the exact moment you said """
	ICALL2	RESTORE-INPUT,FIRST-BUFFER
	PRINTI	""" a freak wormhole opened in the fabric of the space-time continuum and carried your words far far back in time across almost infinite reaches of space to a distant galaxy where strange and warlike beings were poised on the brink of frightful interstellar battle.

The two opposing leaders were meeting for the last time. A dreadful silence fell across the conference table as the commander of the Vl'Hurgs, resplendent in his"
	PRINT	BATTLE-SHORTS
	PRINTI	"gazed levelly at the "
	PRINTD	GGUGVUNT
	PRINTI	" squatting opposite him"
	PRINT	CLOUD-OF-STEAM
	PRINTI	"As a million sleek and horribly beweaponed star cruisers poised to unleash electric death at his single word of command, the Vl'Hurg challenged his vile enemy to take back what it had said about his mother.

The creature stirred in its sickly broiling vapour, and at that very moment the words """
	ICALL2	RESTORE-INPUT,FIRST-BUFFER
	PRINTR	""" drifted across the conference table. Unfortunately, in the Vl'Hurg tongue this was the most dreadful insult imaginable, and there was nothing for it but to wage terrible war for centuries. Eventually the error was detected, but over two hundred and fifty thousand worlds, their peoples and cultures perished in the holocaust.

You have destroyed most of a small galaxy. Please pick your words with greater care."


	.FUNCT	MICROSCOPIC-FLEET-F
	EQUAL?	PRSA,V?THROUGH \FALSE
	PRINT	LOOK-AROUND
	CRLF	
	RTRUE	


	.FUNCT	CANOPY-F
	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINTI	"Through the "
	PRINTD	CANOPY
	PRINTI	" of the ship you can see a vast "
	PRINTD	MICROSCOPIC-FLEET
	PRINTR	" flying in formation behind you through the black, glittering emptiness of space. Ahead is a star system towards which you are hurtling at a terrifying speed."


	.FUNCT	WAR-CHAMBER-F,RARG
	EQUAL?	RARG,M-ENTER \?CCL3
	FCLEAR	CONVERSATION,INVISIBLE
	MOVE	THIRD-PLANET,HERE
	SET	'DREAMING,TRUE-VALUE
	CALL	QUEUE,I-DOG,-1
	PUT	STACK,0,1
	RFALSE	
?CCL3:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"Spread before you, astonishingly enough, is the "
	PRINTD	WAR-CHAMBER
	PRINTI	" of a star battle cruiser. "
	ICALL	PERFORM,V?LOOK-INSIDE,CANOPY
	RTRUE	


	.FUNCT	VLHURG-DESCFCN,X
	CRLF	
	PRINTI	"Standing near you are two creatures who are gazing at the star system with terrible hatred in their eyes. One is wearing"
	PRINT	BATTLE-SHORTS
	PRINTI	"and the other is wreathed"
	PRINT	CLOUD-OF-STEAM
	PRINTI	"They are engaged in "
	PRINTD	CONVERSATION
	PRINTR	"."


	.FUNCT	VLHURG-F
	EQUAL?	PRSA,V?TELL \?CCL3
	PRINTI	"You are clearly the worst diplomat that ever lived, and are about to become the worst one that ever died. That is an even worse insult in the G'Gugvunt tongue than """
	ICALL2	RESTORE-INPUT,FIRST-BUFFER
	PRINTI	""" is in the Vl'Hurg tongue."
	CRLF	
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL9
	PRINTI	"The "
	PRINTD	VLHURG
	PRINTR	" looks typically Vl'Hurgish."
?CCL9:	EQUAL?	PRSA,V?LISTEN \FALSE
	FSET?	VLHURG,MUNGEDBIT \?CCL16
	PRINTR	"The creatures are speculating about who you are and what to do with you."
?CCL16:	FSET	VLHURG,MUNGEDBIT
	PRINTI	"  ""Hated planet!"" snarls the Vl'Hurg.
  ""Home of he that dared to say '"
	ICALL2	RESTORE-INPUT,FIRST-BUFFER
	PRINTI	"'"" rasps the G'Gugvunt.
  ""Detested words! Even now it sticks my soul to hear them uttered,"" barks the Vl'Hurg, ""even though ten thousand years have passed...""
  ""And as many senseless megadeaths! Worlds destroyed! My race and yours laid to waste! All because of he that dared shape the words '"
	ICALL2	RESTORE-INPUT,FIRST-BUFFER
	PRINTI	"'.""
  ""Torture to my Vl'Hurgish warrior heart to hear it spoken! Yet, even now, the hot breath of our vengeance blows hard upon this little world...""
  ""Vengeance on him who said '"
	ICALL2	RESTORE-INPUT,FIRST-BUFFER
	PRINTI	"'.""
  ""Yes, there's no need to keep repeating it,"" growls the Vl'Hurg.
  ""One happy thought,"" adds the G'Gugvunt. ""After millenia of bloody and perpetual conflict, our races have been brought together by this Quest for the Source of the Offending Remark. Perhaps, after our vengeance has been exacted on him who said '"
	ICALL2	RESTORE-INPUT,FIRST-BUFFER
	PRINTR	"'...""
  ""Will you stop saying it?""
  ""...perhaps we will continue to live in peace and harmony and...""
  ""We will talk about that AFTER we ... who's this?""

The two creatures turn and stare at you."


	.FUNCT	GGUGVUNT-F
	EQUAL?	PRSA,V?TELL \?CCL3
	ICALL	PERFORM,V?TELL,VLHURG
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL5
	PRINTI	"The "
	PRINTD	GGUGVUNT
	PRINTR	" is looking typically G'Gugvuntish."
?CCL5:	EQUAL?	PRSA,V?LISTEN \FALSE
	ICALL	PERFORM,V?LISTEN,VLHURG
	RTRUE	


	.FUNCT	THIRD-PLANET-F
	ZERO?	EARTH-DEMOLISHED \?CCL3
	EQUAL?	PRSO,THIRD-PLANET \?CCL6
	ICALL	PERFORM,PRSA,GROUND,PRSI
	RTRUE	
?CCL6:	CALL	PERFORM,PRSA,PRSO,GROUND
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?DISEMBARK,V?LEAVE \?CCL8
	PRINTR	"You did!"
?CCL8:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"It is an utterly insignificant little blue-green planet, of the sort where they probably still wear "
	PRINTD	DIGITAL-WATCH
	PRINTR	"es."


	.FUNCT	MAZE-EXIT-F
	RANDOM	100
	LESS?	40,STACK /?CCL3
	PRINTI	"An electrical impulse across a synapse gap temporarily blocks your way."
	CRLF	
	RFALSE	
?CCL3:	INC	'MAZE-COUNTER
	EQUAL?	MAZE-COUNTER,3,17,36 \?CCL8
	MOVE	PARTICLE,HERE
	JUMP	?CND6
?CCL8:	MOVE	PARTICLE,LOCAL-GLOBALS
?CND6:	ICALL1	V-LOOK
	RFALSE	


	.FUNCT	PARTICLE-F
	EQUAL?	PRSA,V?MOVE,V?TAKE \?CCL3
	MOVE	PARTICLE,LOCAL-GLOBALS
	FSET	PARTICLE,MUNGEDBIT
	ADD	SCORE,25 >SCORE
	FSET	WAR-CHAMBER,REVISITBIT
	PRINTI	"As you remove the "
	PRINTD	PARTICLE
	ICALL2	JIGS-UP,STR?148
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	PRINTI	"As you look closer you see, inscribed in tiny letters on the "
	PRINTD	PARTICLE
	PRINTR	":

  Sense, Common for:
     Dent, Arthur
   (for replacement,
  order part #31-541)"


	.FUNCT	APARTMENT-F
	EQUAL?	PRSA,V?EXIT,V?LEAVE \?CCL3
	EQUAL?	HERE,LIVING-ROOM \?CCL6
	CALL2	DO-WALK,P?SOUTH
	RSTACK	
?CCL6:	CALL1	V-WALK-AROUND
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?THROUGH \FALSE
	PRINT	LOOK-AROUND
	CRLF	
	RTRUE	


	.FUNCT	PARTY-DESC,ROOM
	PRINTI	"You are in a large "
	PRINTD	ROOM
	PRINTI	". There is a party going on. Other rooms lie to the "
	RTRUE	


	.FUNCT	PARTY-EXIT-F
	FSET?	APARTMENT-DOOR,OPENBIT \?PRG6
	PRINTI	"What! Leave a fun party like this?"
	CRLF	
	SET	'AWAITING-REPLY,3
	CALL	QUEUE,I-REPLY,2
	PUT	STACK,0,1
	RFALSE	
?PRG6:	PRINTI	"The door is closed."
	CRLF	
	SET	'P-IT-OBJECT,APARTMENT-DOOR
	RFALSE	


	.FUNCT	LIVING-ROOM-F,RARG
	EQUAL?	RARG,M-ENTER \?CCL3
	EQUAL?	IDENTITY-FLAG,TRILLIAN /?CCL3
	LOC	HANDBAG
	PUT	PARTY-TABLE,0,STACK
	LOC	TWEEZERS
	PUT	PARTY-TABLE,1,STACK
	FSET?	HANDBAG,OPENBIT \?CCL8
	PUT	PARTY-TABLE,2,TRUE-VALUE
	JUMP	?CND6
?CCL8:	PUT	PARTY-TABLE,2,FALSE-VALUE
?CND6:	SET	'IDENTITY-FLAG,TRILLIAN
	MOVE	TRILLIAN,GLOBAL-OBJECTS
	SET	'DREAMING,TRUE-VALUE
	ICALL	ROB,PROTAGONIST,MEMORIAL
	ICALL	ROB,HANDBAG,RAMP
	FCLEAR	HANDBAG,OPENBIT
	MOVE	HANDBAG,PROTAGONIST
	MOVE	TWEEZERS,HANDBAG
	MOVE	WINE,PROTAGONIST
	MOVE	APPETIZERS,PROTAGONIST
	MOVE	ARTHUR,HERE
	MOVE	PHIL,HERE
	MOVE	CAGE,HERE
	PRINTI	"You're at a party being given by a distant and incredibly boring acquaintance. Among the people you've been introduced to are a shy, mousy fellow from the West Country named Arthur, and a flamboyant guy named Phil. You've had too many drinks already, and the room is beginning to buzz..."
	CRLF	
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	RARG,M-END \?CCL12
	FSET?	LIVING-ROOM,REVISITBIT \?CCL12
	CRLF	
	ICALL2	JIGS-UP,STR?149
	RTRUE	
?CCL12:	EQUAL?	RARG,M-LOOK \FALSE
	ICALL2	PARTY-DESC,LIVING-ROOM
	PRINTI	"west and southwest, and the "
	PRINTD	APARTMENT
	PRINTR	"'s front door is south of here."


	.FUNCT	APARTMENT-DOOR-F
	EQUAL?	PRSA,V?THROUGH \FALSE
	CALL2	DO-WALK,P?SOUTH
	RSTACK	


	.FUNCT	DINING-ROOM-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	ICALL2	PARTY-DESC,DINING-ROOM
	PRINTR	"south and east."


	.FUNCT	KITCHEN-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	ICALL2	PARTY-DESC,KITCHEN
	PRINTR	"north and northeast."


	.FUNCT	WINE-F
	EQUAL?	PRSA,V?ENJOY,V?DRINK \?CCL3
	PRINTR	"You take a sip, and the room spins a little faster."
?CCL3:	EQUAL?	PRSA,V?POUR,V?THROW \?CCL7
	CALL1	SHRIEK
	RSTACK	
?CCL7:	EQUAL?	PRSA,V?DROP \FALSE
	CALL1	DROP-AT-PARTY
	RSTACK	


	.FUNCT	APPETIZERS-F
	EQUAL?	PRSA,V?ENJOY,V?EAT \?CCL3
	PRINTI	"You nibble at one of the hors d'oeuvres. It tastes "
	RANDOM	100
	LESS?	40,STACK /?CCL8
	PRINTR	"okay."
?CCL8:	RANDOM	100
	LESS?	50,STACK /?PRG15
	PRINTR	"delicious."
?PRG15:	PRINTR	"terrible."
?CCL3:	EQUAL?	PRSA,V?THROW \?CCL18
	CALL1	SHRIEK
	RSTACK	
?CCL18:	EQUAL?	PRSA,V?COUNT \?CCL20
	PRINTR	"More than three, which is as high as you can count in your condition."
?CCL20:	EQUAL?	PRSA,V?DROP \FALSE
	CALL1	DROP-AT-PARTY
	RSTACK	


	.FUNCT	DROP-AT-PARTY
	ZERO?	ITEM-DROPPED-AT-PARTY \?CND1
	SET	'ITEM-DROPPED-AT-PARTY,PRSO
	FSET	HOSTESS,NDESCBIT
	CALL	QUEUE,I-HOSTESS,3
	PUT	STACK,0,1
?CND1:	MOVE	PRSO,HERE
	EQUAL?	PRSA,V?DROP \?PRG8
	PRINTR	"Dropped."
?PRG8:	PRINTR	"Thrown."


	.FUNCT	SHRIEK
	PRINTI	"The hostess lets out a blood-chilling shriek. ""My new carpet!"" "
	EQUAL?	PRSA,V?THROW \?PRG8
	PRINTI	"Grabbing a shard from your broken "
	PRINTD	PRSO
	PRINTI	", s"
	JUMP	?CND3
?PRG8:	PRINTC	83
?CND3:	ICALL2	JIGS-UP,STR?150
	RTRUE	


	.FUNCT	HOSTESS-F
	EQUAL?	HOSTESS,WINNER \?CCL3
	EQUAL?	PRSA,V?YES \?CCL6
	EQUAL?	AWAITING-REPLY,4 \?CCL6
	SET	'WINNER,PROTAGONIST
	ICALL1	V-YES
	SET	'WINNER,HOSTESS
	RETURN	WINNER
?CCL6:	EQUAL?	PRSA,V?NO \?CCL10
	EQUAL?	AWAITING-REPLY,4 \?CCL10
	SET	'WINNER,PROTAGONIST
	ICALL1	V-NO
	SET	'WINNER,HOSTESS
	RETURN	WINNER
?CCL10:	SET	'WINNER,PROTAGONIST
	ICALL	PERFORM,V?HELLO,HOSTESS
	CALL1	FUCKING-CLEAR
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?TELL-ABOUT,V?ASK-ABOUT,V?HELLO \FALSE
	EQUAL?	PRSO,HOSTESS \FALSE
	PRINTI	"The hostess is delighted to engage in "
	PRINTD	CONVERSATION
	ICALL2	JIGS-UP,STR?152
	RTRUE	


	.FUNCT	I-HOSTESS
	CALL	QUEUE,I-HOSTESS,-1
	PUT	STACK,0,1
	ZERO?	ITEM-DROPPED-AT-PARTY \?CND1
	FCLEAR	HOSTESS,TOUCHBIT
	CALL2	INT,I-HOSTESS
	PUT	STACK,0,0
	RFALSE	
?CND1:	MOVE	HOSTESS,HERE
	MOVE	ITEM-DROPPED-AT-PARTY,HERE
	CRLF	
	FSET?	HOSTESS,TOUCHBIT \?CCL5
	SET	'AWAITING-REPLY,4
	CALL	QUEUE,I-REPLY,2
	PUT	STACK,0,1
	PRINTI	"""Tricia dear,"" says the hostess insistently, ""don't you want your "
	PRINTD	ITEM-DROPPED-AT-PARTY
	PRINTR	"?"""
?CCL5:	FSET	HOSTESS,TOUCHBIT
	SET	'P-IT-OBJECT,ITEM-DROPPED-AT-PARTY
	FSET	ITEM-DROPPED-AT-PARTY,NDESCBIT
	PRINTI	"The hostess, whom you've been avoiding all evening, scurries up with your "
	PRINTD	ITEM-DROPPED-AT-PARTY
	PRINTR	". ""Oh, hello Tricia, how lovely to see you, I think you dropped this, dear."""


	.FUNCT	SPEEDBOAT-F,RARG
	EQUAL?	RARG,M-ENTER \?CCL3
	SET	'DREAMING,TRUE-VALUE
	SET	'IDENTITY-FLAG,ZAPHOD
	MOVE	ZAPHOD,GLOBAL-OBJECTS
	MOVE	WRENCH,TOOLBOX
	MOVE	MAGNIFYING-GLASS,TOOLBOX
	FCLEAR	TOOLBOX,OPENBIT
	ICALL	ROB,PROTAGONIST,MEMORIAL
	MOVE	PROTAGONIST,PILOT-SEAT
	SET	'OHERE,FALSE-VALUE
	SET	'DESTINATION,CHANNEL
	CALL	QUEUE,I-SPEEDBOAT,2
	PUT	STACK,0,1
	PRINTI	"The pain at the back of your eyes is from partying until very late last night, and both your heads are suffering the worst hangover you've ever experienced. You remember formulating a plan to steal "
	PRINTD	HEART-OF-GOLD
	PRINTI	", but you can't for the life of you remember any details."
	CRLF	
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	RARG,M-LOOK \FALSE
	ZERO?	BOAT-DOCKED /?PRG13
	PRINTI	"The boat is resting atop a plume of water. The dais for the dedication ceremonies for "
	PRINTD	HEART-OF-GOLD
	PRINTR	" lies immediately north."
?PRG13:	PRINTI	"You are piloting the "
	PRINTD	BOAT-OBJECT
	PRINTI	", which features very simple controls, toward the island of France (Footnote 3), where the dedication ceremonies for "
	PRINTD	HEART-OF-GOLD
	PRINTI	" will occur. You are currently steering the boat toward"
	EQUAL?	DESTINATION,CHANNEL \?CCL17
	PRINTI	" a "
	PRINTD	CHANNEL
	PRINTI	" between "
	PRINTD	CLIFF
	PRINTI	" and a "
	PRINTD	SPIRE
	PRINTR	"."
?CCL17:	ICALL2	ARTICLE,DESTINATION
	PRINTR	"."


	.FUNCT	I-SPEEDBOAT
	INC	'BOAT-COUNTER
	CALL	QUEUE,I-SPEEDBOAT,-1
	PUT	STACK,0,1
	EQUAL?	DESTINATION,CLIFF,SPIRE \?CND1
	INC	'CRASH-COUNTER
	EQUAL?	CRASH-COUNTER,4 \?CND1
	SET	'BOAT-DOCKED,TRUE-VALUE
	CALL2	INT,I-SPEEDBOAT
	PUT	STACK,0,0
	CRLF	
	PRINTI	"Suddenly, the autopilot leaps to life, steering the boat away from the "
	PRINTD	DESTINATION
	PRINTI	". The crowd gathered for the dedication oohs and aahs as the boat swerves through the "
	PRINTD	CHANNEL
	PRINTI	". As it reaches the base of the "
	PRINTD	CLIFF
	PRINTR	" a plume of water forms under it, sending it higher and higher. The crowd bursts into applause as the boat reaches the top of the cliff, just south of the ceremonial dais."
?CND1:	EQUAL?	PRSA,V?POINT,V?STEER /FALSE
	CRLF	
	LESS?	BOAT-COUNTER,7 \?CCL11
	PRINTI	"You continue to steer toward the "
	PRINTD	DESTINATION
	PRINTR	"."
?CCL11:	CALL2	INT,I-SPEEDBOAT
	PUT	STACK,0,0
	PRINTI	"You almost make it through the "
	PRINTD	CHANNEL
	PRINTI	" but the turbulent waters push the boat toward the rocks. The "
	PRINTD	AUTOPILOT-BUTTON
	PRINTI	" lights up and an "
	PRINT	EYE-STALK
	ICALL2	JIGS-UP,STR?153
	RTRUE	


	.FUNCT	BOAT-OBJECT-F
	EQUAL?	PRSA,V?STEER \?CCL3
	EQUAL?	PRSO,BOAT-OBJECT \?CCL3
	ZERO?	BOAT-DOCKED /?CCL8
	PRINTR	"You've already reached your destination!"
?CCL8:	EQUAL?	PRSI,DESTINATION \?CCL12
	PRINTI	"You already ARE steering the boat toward the "
	PRINTD	DESTINATION
	PRINTR	"."
?CCL12:	EQUAL?	PRSI,CHANNEL,SPIRE,CLIFF /?CCL16
	PRINTI	"You can't steer the boat toward"
	ICALL	ARTICLE,PRSI,TRUE-VALUE
	PRINTR	"!"
?CCL16:	SET	'DESTINATION,PRSI
	GRTR?	BOAT-COUNTER,3 \?PRG23
	SET	'BOAT-COUNTER,3
?PRG23:	PRINTI	"The boat is now heading straight at the "
	PRINTD	DESTINATION
	PRINTR	"."
?CCL3:	EQUAL?	PRSA,V?DISEMBARK,V?LEAVE,V?EXIT /?CCL26
	EQUAL?	PRSA,V?THROUGH \FALSE
?CCL26:	ZERO?	BOAT-DOCKED /?PRG32
	CALL2	DO-WALK,P?NORTH
	RSTACK	
?PRG32:	PRINT	DONT-MIX
	CRLF	
	RTRUE	


	.FUNCT	WATER-PSEUDO
	EQUAL?	PRSA,V?BOARD,V?THROUGH \?CCL3
	PRINT	DONT-MIX
	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?THROW,V?PUT \FALSE
	EQUAL?	PRSI,WATER \FALSE
	MOVE	PRSO,LOCAL-GLOBALS
	PRINTR	"Glub..."


	.FUNCT	PILOT-SEAT-F,RARG
	EQUAL?	RARG,M-BEG \?CCL3
	EQUAL?	PRSA,V?WALK \FALSE
	CALL2	OUT-OF-FIRST,PILOT-SEAT
	RSTACK	
?CCL3:	ZERO?	RARG \FALSE
	EQUAL?	PRSA,V?SEARCH,V?RAISE,V?LOOK-UNDER /?PRD12
	EQUAL?	PRSA,V?TAKE \?CCL10
?PRD12:	IN?	KEY,LOCAL-GLOBALS \?CCL10
	MOVE	CUSHION-FLUFF,PROTAGONIST
	MOVE	KEY,PROTAGONIST
	PRINTR	"You discover and pick up a small key and a piece of fluff under the seat cushion."
?CCL10:	EQUAL?	PRSA,V?EXAMINE \?CCL18
	PRINTR	"The chair is very comfortable, with a thick plush cushion."
?CCL18:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	EQUAL?	PRSO,PILOT-SEAT \FALSE
	CALL1	TELL-ME-HOW
	RSTACK	


	.FUNCT	KEY-F
	EQUAL?	PRSA,V?WHERE \FALSE
	EQUAL?	HERE,SPEEDBOAT \FALSE
	IN?	KEY,LOCAL-GLOBALS \FALSE
	PRINTR	"It's probably around the boat somewhere."


	.FUNCT	TOOLBOX-F
	EQUAL?	PRSA,V?OPEN \?CCL3
	ZERO?	PRSI \?CCL3
	FSET?	TOOLBOX,OPENBIT /?CCL3
	PRINTR	"It's locked."
?CCL3:	EQUAL?	PRSA,V?LOCK \?CCL10
	FSET?	TOOLBOX,OPENBIT \?PRG14
	ICALL	PERFORM,V?CLOSE,TOOLBOX
	RTRUE	
?PRG14:	PRINTR	"It is."
?CCL10:	EQUAL?	PRSA,V?UNLOCK,V?OPEN \FALSE
	FSET?	TOOLBOX,OPENBIT \?CND18
	PRINT	ALREADY-OPEN
	CRLF	
	RTRUE	
?CND18:	ZERO?	PRSI \?CND22
	CALL2	HELD?,KEY
	ZERO?	STACK /?CND22
	SET	'PRSI,KEY
	PRINTI	"(with the key)"
	CRLF	
?CND22:	EQUAL?	PRSI,KEY \?PRG39
	FSET	TOOLBOX,OPENBIT
	PRINTI	"The tool box opens"
	FIRST?	TOOLBOX \?PRG37
	PRINTI	" revealing"
	ICALL2	PRINT-CONTENTS,TOOLBOX
?PRG37:	PRINTR	"."
?PRG39:	PRINTI	"You can't unlock it with"
	ZERO?	PRSI /?PRG44
	ICALL2	ARTICLE,PRSI
	JUMP	?PRG46
?PRG44:	PRINTC	32
	PRINTD	HANDS
?PRG46:	PRINTR	"!"


	.FUNCT	MAGNIFYING-GLASS-F
	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINTR	"You see your environs upside-down and slightly distorted."


	.FUNCT	AUTOPILOT-BUTTON-F
	EQUAL?	PRSA,V?LAMP-ON,V?PUSH \FALSE
	INC	'AUTOPILOT-COUNTER
	PRINTI	"The button glows. An "
	PRINT	EYE-STALK
	PRINTI	"looks around, and withdraws. The light fades."
	EQUAL?	AUTOPILOT-COUNTER,3 \?CND6
	PRINTR	" (Footnote 13)"
?CND6:	CRLF	
	RTRUE	


	.FUNCT	DESTINATION-F
	EQUAL?	PRSA,V?WALK-TO \FALSE
	EQUAL?	HERE,SPEEDBOAT \FALSE
	ZERO?	BOAT-DOCKED \FALSE
	ICALL	PERFORM,V?STEER,BOAT-OBJECT,PRSO
	RTRUE	


	.FUNCT	DAIS-EXIT-F
	IN?	GUARDS,HERE /?CCL3
	SET	'AWAITING-REPLY,5
	CALL	QUEUE,I-REPLY,2
	PUT	STACK,0,1
	PRINTI	"Don't you think it would be a bad idea to leave the ceremonies?"
	CRLF	
	RFALSE	
?CCL3:	IN?	RIFLES,HERE /?PRG10
	IN?	RIFLES,GUARDS \?CCL7
?PRG10:	PRINTI	"You and "
	PRINTD	TRILLIAN
	PRINTI	" break for "
	PRINTD	HEART-OF-GOLD
	PRINTI	". "
	FSET?	BLASTER,TRYTAKEBIT \?PRG17
	PRINT	GUARDS-REALIZE
	PRINTI	"They"
	JUMP	?CND12
?PRG17:	PRINTI	"The guards"
?CND12:	ICALL1	GUARD-DEATH
	RFALSE	
?CCL7:	ADD	SCORE,25 >SCORE
	FSET	SPEEDBOAT,REVISITBIT
	MOVE	BLASTER,LOCAL-GLOBALS
	ICALL	ROB,PROTAGONIST,HATCHWAY
	PRINTI	"You and "
	PRINTD	TRILLIAN
	PRINTI	" enter "
	PRINTD	HEART-OF-GOLD
	PRINTI	", that beautiful bauble you've been coveting ever since your decision to run for"
	PRINT	PRESIDENT
	ICALL2	JIGS-UP,STR?155
	RFALSE	


	.FUNCT	DAIS-F,RARG
	EQUAL?	RARG,M-END \?CCL3
	FSET?	SPEEDBOAT,REVISITBIT \?CCL3
	SET	'DREAMING,TRUE-VALUE
	ICALL2	JIGS-UP,STR?156
	RTRUE	
?CCL3:	EQUAL?	RARG,M-ENTER \?CCL7
	FSET?	SPEEDBOAT,REVISITBIT /?CCL7
	PUTP	PROTAGONIST,P?ACTION,DAIS-FUNCTION
	PRINTI	"As you step out of the boat, the plume of water lowers it away. The crowd, unaware of the autopilot, bursts into a round of admiring applause."
	CRLF	
	CRLF	
	RTRUE	
?CCL7:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a platform surrounded by a crowd. "
	IN?	BANNER,HERE \?PRG20
	PRINTI	"Several members of the crowd are holding a huge banner. "
?PRG20:	PRINTI	"Just to the east is "
	PRINTD	HEART-OF-GOLD
	IN?	RIFLES,GUARDS \?CCL24
	PRINTI	". A semicircle of guards are aiming photon rifles at you and "
	PRINTD	TRILLIAN
	JUMP	?CND22
?CCL24:	IN?	GUARDS,HERE \?CND22
	PRINTI	". Many disarmed guards are nervously eyeing you and "
	PRINTD	TRILLIAN
?CND22:	IN?	BLASTER,TRILLIAN \?PRG34
	PRINTI	", who is pointing a blaster at your head"
?PRG34:	PRINTR	"."


	.FUNCT	DAIS-FUNCTION
	EQUAL?	PRSA,V?RESTORE,V?RESTART,V?QUIT /FALSE
	EQUAL?	PRSA,V?SAVE,V?VERSION,V?SCORE /FALSE
	EQUAL?	PRSA,V?BRIEF,V?VERBOSE,V?WALK /FALSE
	EQUAL?	PRSA,V?UNSCRIPT,V?SCRIPT,V?SUPERBRIEF /FALSE
	EQUAL?	PRSA,V?INVENTORY,V?LOOK,V?FOOTNOTE /FALSE
	EQUAL?	PRSA,V?WHAT,V?WHO,V?HINTS /FALSE
	EQUAL?	PRSA,V?YES,V?WHY,V?WHERE /FALSE
	EQUAL?	PRSA,V?THROUGH,V?NO /FALSE
	EQUAL?	PRSO,CROWD,BANNER \?CCL13
	EQUAL?	PRSA,V?THROUGH,V?EXAMINE,V?COUNT /FALSE
	EQUAL?	PRSA,V?READ /FALSE
?CCL13:	INC	'DAIS-COUNTER
	PRINT	CROWD-CHEERS
	EQUAL?	DAIS-COUNTER,4 \?CND20
	PUTP	PROTAGONIST,P?ACTION,PROTAGONIST-F
	MOVE	TRILLIAN,HERE
	MOVE	BLASTER,TRILLIAN
	MOVE	GUARDS,HERE
	MOVE	RIFLES,GUARDS
	CALL	QUEUE,I-GUARDS,8
	PUT	STACK,0,1
	PRINTI	" Suddenly, "
	PRINTD	TRILLIAN
	PRINTI	" leaps out of the crowd, grabs you by the necks, and points a blaster at your left head. Guards rush up, photon rifles poised to shoot. ""Stay back!"" shouts "
	PRINTD	TRILLIAN
	PRINTI	". ""One more step and the"
	PRINT	PRESIDENT
	PRINTI	" is fried meat!"" The guards seem unsure, and look at you for instructions."
?CND20:	ICALL1	FUCKING-CLEAR
	CRLF	
	RTRUE	


	.FUNCT	CROWD-PSEUDO
	EQUAL?	PRSA,V?EXAMINE,V?COUNT \?CCL3
	PRINTR	"It's big."
?CCL3:	EQUAL?	PRSA,V?SHOOT \?CCL7
	CALL1	BLASTER-HOLD
	ZERO?	STACK \TRUE
	PRINTR	"You may be a scoundrel, but you're not a mass murderer."
?CCL7:	EQUAL?	PRSA,V?THROUGH \?CCL13
	PRINTR	"You'd be crushed by the enthusiasm of your admirers."
?CCL13:	EQUAL?	PRSA,V?WAVE-AT,V?TELL \FALSE
	PRINT	CROWD-CHEERS
	CRLF	
	ICALL1	FUCKING-CLEAR
	RTRUE	


	.FUNCT	PLATFORM-F
	EQUAL?	HERE,SPEEDBOAT \?CCL3
	ZERO?	BOAT-DOCKED \?CCL3
	CALL2	CANT-SEE,PLATFORM
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?WALK-TO,V?THROUGH \?CCL7
	EQUAL?	HERE,DAIS \?CCL10
	PRINT	LOOK-AROUND
	CRLF	
	RTRUE	
?CCL10:	CALL2	DO-WALK,P?NORTH
	RSTACK	
?CCL7:	EQUAL?	PRSA,V?DISEMBARK,V?LEAVE \FALSE
	EQUAL?	HERE,DAIS \?PRG18
	CALL2	DO-WALK,P?EAST
	RSTACK	
?PRG18:	PRINT	LOOK-AROUND
	CRLF	
	RTRUE	


	.FUNCT	BLASTER-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	FSET?	BLASTER,TRYTAKEBIT \?CCL3
	PRINT	GUARDS-REALIZE
	PRINTI	"They"
	IN?	RIFLES,GUARDS \?CCL10
	CALL1	GUARD-DEATH
	RSTACK	
?CCL10:	FCLEAR	BLASTER,TRYTAKEBIT
	FCLEAR	BLASTER,NDESCBIT
	MOVE	BLASTER,PROTAGONIST
	CALL	QUEUE,I-GUARDS,5
	PUT	STACK,0,1
	PRINTR	" are disarmed, though, and unable to do anything as you take the blaster."
?CCL3:	EQUAL?	PRSA,V?SHOOT \FALSE
	EQUAL?	PRSI,BLASTER \FALSE
	EQUAL?	PRSO,BLASTER \?CCL19
	CALL1	V-COUNT
	RSTACK	
?CCL19:	EQUAL?	PRSO,GROUND \?CCL21
	CALL1	V-DIG
	RSTACK	
?CCL21:	FSET?	PRSO,TAKEBIT /?CTR22
	EQUAL?	PRSO,BANNER \?CCL23
?CTR22:	MOVE	PRSO,LOCAL-GLOBALS
	PRINTI	"With a cloud of sparks"
	EQUAL?	PRSO,RIFLES \?CCL30
	PRINTI	" the "
	PRINTD	RIFLES
	JUMP	?PRG33
?CCL30:	ICALL	ARTICLE,PRSO,TRUE-VALUE
?PRG33:	PRINTI	" disintegrates. "
	PRINT	CROWD-CHEERS
	CRLF	
	RTRUE	
?CCL23:	EQUAL?	PRSO,HEART-OF-GOLD \FALSE
	PRINTR	"You're too far."


	.FUNCT	BLASTER-HOLD
	CALL2	HELD?,BLASTER
	ZERO?	STACK \FALSE
	PRINT	NOT-HOLDING
	PRINTI	" the "
	PRINTD	BLASTER
	PRINTR	"."


	.FUNCT	RIFLES-F
	EQUAL?	PRSA,V?SHOOT \?CCL3
	CALL1	BLASTER-HOLD
	ZERO?	STACK \TRUE
	IN?	RIFLES,GUARDS \?CCL8
	ICALL	PERFORM,V?SHOOT,GUARDS
	RTRUE	
?CCL8:	MOVE	RIFLES,LOCAL-GLOBALS
	PRINTI	"The rifles explode in a flashy display of sparks and shrapnel. "
	PRINT	CROWD-CHEERS
	PRINTR	" The guards begin to look a bit concerned."
?CCL3:	EQUAL?	PRSA,V?TAKE \FALSE
	FSET?	RIFLES,TRYTAKEBIT \FALSE
	PRINT	GUARDS-REALIZE
	ICALL2	JIGS-UP,STR?158
	RTRUE	


	.FUNCT	GUARD-DEATH
	CALL2	VISIBLE?,RIFLES
	ZERO?	STACK \?CCL3
	PRINTI	" grab the blaster and"
	JUMP	?CND1
?CCL3:	IN?	RIFLES,GUARDS /?CND1
	PRINTI	" pick up their rifles and"
?CND1:	CALL2	JIGS-UP,STR?159
	RSTACK	


	.FUNCT	INSIDE-WHALE-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	CALL	QUEUE,I-WHALE,11
	PUT	STACK,0,1
	SET	'DREAMING,TRUE-VALUE
	RFALSE	


	.FUNCT	I-WHALE
	EQUAL?	HERE,INSIDE-WHALE \FALSE
	CRLF	
	ICALL2	JIGS-UP,STR?161
	RTRUE	


	.FUNCT	WHALE-OBJECT-F
	EQUAL?	PRSA,V?DISEMBARK,V?LEAVE,V?EXIT \FALSE
	CALL1	V-WALK-AROUND
	RSTACK	

	.ENDI
