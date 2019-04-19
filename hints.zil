"HINTS for HITCHHIKERS GUIDE TO THE GALAXY
(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<FILE-FLAGS CLEAN-STACK?>

<GLOBAL HINT-WARNING <>>

<GLOBAL HINTS-OFF <>>

<ROUTINE V-HINTS-NO ()
	<COND (<NOT <PRSO? ,ROOMS>>
	       <TELL "I don't understand what you mean." CR>)
	      (T
	       <SETG HINTS-OFF T>
	       <TELL "[Hints have been disallowed for this session.]" CR>)>
	<RFATAL>>

<ROUTINE V-HINTS ("AUX" CHR MAXC (C <>) Q WHO)
	<COND (,HINTS-OFF
	       <PERFORM ,V?HINTS-NO ,ROOMS>
	       <RFATAL>)
	      (<NOT ,HINT-WARNING>
	       <SETG HINT-WARNING T>
	       <TELL
"[Warning: It is recognized that the temptation for help may at times be so
exceedingly strong that you might fetch hints prematurely. Therefore, you may
at any time during the story type HINTS OFF, and this will disallow the
seeking out of help for the present session of the story. If you still want a
hint now, indicate HINT.]" CR>
	       <RFATAL>)>
       	<SET MAXC <GET ,HINTS 0>>
	<INIT-HINT-SCREEN>
	<CURSET 5 1>
	<PUT-UP-CHAPTERS>
	<SETG CUR-POS <- ,CHAPT-NUM 1>>
	<NEW-CURSOR>
	<REPEAT ()
		<SET CHR <INPUT 1>>
		<COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q>>
		       <SET Q T>
		       <RETURN>)
		      (<EQUAL? .CHR %<ASCII !\N> %<ASCII !\n>>
		       <ERASE-CURSOR>
		       <COND (<EQUAL? ,CHAPT-NUM .MAXC>
			      <SETG CUR-POS 0>
			      <SETG CHAPT-NUM 1>
			      <SETG QUEST-NUM 1>)
			     (T 
			      <SETG CUR-POS <+ ,CUR-POS 1>>
			      <SETG CHAPT-NUM <+ ,CHAPT-NUM 1>>
			      <SETG QUEST-NUM 1>)>
		       <NEW-CURSOR>)
		      (<EQUAL? .CHR %<ASCII !\P> %<ASCII !\p>>
		       <ERASE-CURSOR>
		       <COND (<EQUAL? ,CHAPT-NUM 1>
			      <SETG CHAPT-NUM .MAXC>
			      <SETG CUR-POS <- ,CHAPT-NUM 1>>
			      <SETG QUEST-NUM 1>)
			     (T
			      <SETG CUR-POS <- ,CUR-POS 1>>
			      <SETG CHAPT-NUM <- ,CHAPT-NUM 1>>
			      <SETG QUEST-NUM 1>)>
		       <NEW-CURSOR>)
		      (<EQUAL? .CHR 13 10>
		       <PICK-QUESTION>
		       <RETURN>)>>
	<COND (<NOT .Q>
	       <AGAIN>	;"AGAIN does whole routine?")>
	<CLEAR -1>
	<INIT-STATUS-LINE>
	<TELL CR "Back to the story..." CR>
	<RFATAL>>


<ROUTINE PICK-QUESTION ("AUX" CHR MAXQ (Q <>))
	<INIT-HINT-SCREEN <>>
	<LEFT-LINE 3 " RETURN = See hint">
	<RIGHT-LINE 3 "Q = Main menu" %<LENGTH "Q = Main menu">>
	<SET MAXQ <- <GET <GET ,HINTS ,CHAPT-NUM> 0> 1>>
	<CURSET 5 1>
	<PUT-UP-QUESTIONS>
	<SETG CUR-POS <- ,QUEST-NUM 1>>
	<NEW-CURSOR>
	<REPEAT ()
		<SET CHR <INPUT 1>>
		<COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q>>
		       <SET Q T>
		       <RETURN>)
		      (<EQUAL? .CHR %<ASCII !\N> %<ASCII !\n>>
		       <ERASE-CURSOR>
		       <COND (<EQUAL? ,QUEST-NUM .MAXQ>
			      <SETG CUR-POS 0>
			      <SETG QUEST-NUM 1>)
			     (T
			      <SETG CUR-POS <+ ,CUR-POS 1>>
			      <SETG QUEST-NUM <+ ,QUEST-NUM 1>>)>
		       <NEW-CURSOR>)
		      (<EQUAL? .CHR %<ASCII !\P> %<ASCII !\p>>
		       <ERASE-CURSOR>
		       <COND (<EQUAL? ,QUEST-NUM 1>
			      <SETG QUEST-NUM .MAXQ>
			      <SETG CUR-POS <- ,QUEST-NUM 1>>)
			     (T
			      <SETG CUR-POS <- ,CUR-POS 1>> 
			      <SETG QUEST-NUM <- ,QUEST-NUM 1>>)>
		       <NEW-CURSOR>)
		      (<EQUAL? .CHR 13 10>
		       <DISPLAY-HINT>
		       <RETURN>)>>
	<COND (<NOT .Q>
	       <AGAIN>)>>

;"zeroth (first) element is 5"
<GLOBAL LINE-TABLE
	<PTABLE
	  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22>>

;"zeroth (first) element is 4"
<GLOBAL COLUMN-TABLE
	<PTABLE
	  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4>>

<GLOBAL CUR-POS 0>	;"determines where to place the highlight cursor
			  Can go up to 17 Questions"

<GLOBAL QUEST-NUM 1>	;"shows in HINT-TBL ltable which QUESTION it's on"

<GLOBAL CHAPT-NUM 1>	;"shows in HINT-TBL ltable which CHAPTER it's on"

<ROUTINE ERASE-CURSOR ()
	<CURSET <GET ,LINE-TABLE ,CUR-POS>
		<- <GET ,COLUMN-TABLE ,CUR-POS> 2 ;1>>
	<TELL " ">	;"erase previous highlight cursor">

;"go back 2 spaces from question text, print cursor and flash is between
the cursor and text"

<ROUTINE NEW-CURSOR ()
	<CURSET <GET ,LINE-TABLE ,CUR-POS>
		<- <GET ,COLUMN-TABLE ,CUR-POS> 2 ;1>>
	<TELL ">">	;"print the new cursor">

<ROUTINE INVERSE-LINE ("AUX" (CENTER-HALF <>)) 
	<HLIGHT ,H-INVERSE>
	<PRINT-SPACES <LOWCORE SCRH>>
	<HLIGHT ,H-NORMAL>>

;"cnt (3) is where in table answers begin. (2) in table is # of hints-seen"
<ROUTINE DISPLAY-HINT ("AUX" H MX MXC (CNT 2) CHR (FLG T) N)
	;<SPLIT 0>
	<CLEAR -1>
	<SPLIT 3>
	<SCREEN ,S-WINDOW>
	<CURSET 1 1>
	<INVERSE-LINE>
	<CENTER-LINE 1 "INVISICLUES (tm)" %<LENGTH "INVISICLUES (tm)">>
	<CURSET 3 1>
	<INVERSE-LINE>
	<LEFT-LINE 3 " RETURN = See hint">
	<RIGHT-LINE 3 "Q = See hint menu" %<LENGTH "Q = See hint menu">>
	<CURSET 2 1>
	<INVERSE-LINE>
	<HLIGHT ,H-BOLD>
	<SET H <GET <GET ,HINTS ,CHAPT-NUM> <+ ,QUEST-NUM 1>>>
	<CENTER-LINE 2 <GET .H 2>>
	<HLIGHT ,H-NORMAL>
	<SET MX <GET .H 0>>
	<SET MXC <GET ,HINTS 0>> 
	<SCREEN ,S-TEXT>
	<CRLF>
	<REPEAT ()
	       <COND (<EQUAL? .CNT <GET .H 1>>
		      <RETURN>)
		     (T
		      <TELL <GET .H .CNT> CR ;CR>
		      <SET CNT <+ .CNT 1>>)>>
	<REPEAT ()
	      <COND (<AND .FLG <G? .CNT .MX>>
		     <SET FLG <>>
		     <TELL "[That's all.]" CR>)
		    (.FLG
		     <SET N <+ <- .MX .CNT> 1>> ;"added +1 - Jeff"
		     <COND (<NOT <EQUAL? ,CHAPT-NUM .MXC>> ;"add cond-GARY" 
		            <TELL N .N " hint">
		            <COND (<NOT <EQUAL? .N 1>>
			           <TELL "s">)>
		            <TELL " left " ;CR ;CR>)> ;"removed CRs - GARY"
		     <TELL "-> ">
		     <SET FLG <>>)>
	      <SET CHR <INPUT 1>>
	      <COND (<EQUAL? .CHR %<ASCII !\Q> %<ASCII !\q>>
		     <PUT .H 1 .CNT>
		     <RETURN>)
		    (<EQUAL? .CHR 13 10>
		     <COND (<NOT <G? .CNT .MX>>
			    <SET FLG T>	;".cnt starts as 3" 
			    <TELL <GET .H .CNT>>
			    ;<CRLF> ;"extra CRLF removed by GARY"
			    <CRLF>
			    <SET CNT <+ .CNT 1>>
			    <COND (<G? .CNT .MX>
				   <SET FLG <>>
				   <TELL "[That's all.]" CR>)>)>)>>>

<ROUTINE PUT-UP-QUESTIONS ("AUX" (ST 1) MXQ MXL)
	<SET MXQ <- <GET <GET ,HINTS ,CHAPT-NUM> 0> 1>>
	<SET MXL <- <LOWCORE SCRV> 1>>
	<REPEAT ()
		<COND (<G? .ST .MXQ>
		       <RETURN>)
		      (T                        ;"zeroth"
		       <CURSET <GET ,LINE-TABLE <- .ST 1>>
			       <- <GET ,COLUMN-TABLE <- .ST 1>> 1>>)>
		<TELL " " <GET <GET <GET ,HINTS ,CHAPT-NUM> <+ .ST 1>> 2>>
		<SET ST <+ .ST 1>>>>

<ROUTINE PUT-UP-CHAPTERS ("AUX" (ST 1) MXC MXL)
	<SET MXC <GET ,HINTS 0>>
	<SET MXL <- <LOWCORE SCRV> 1>>
	<REPEAT ()
		<COND (<G? .ST .MXC>
		       <RETURN>)
		      (T                        ;"zeroth"
		       <CURSET <GET ,LINE-TABLE <- .ST 1>>
			       <- <GET ,COLUMN-TABLE <- .ST 1>> 1>>)>
		<TELL " " <GET <GET ,HINTS .ST> 1>>
		<SET ST <+ .ST 1>>>>

<ROUTINE INIT-HINT-SCREEN ("OPTIONAL" (THIRD T))
	;<SPLIT 0>
	<CLEAR -1>
	<SPLIT <- <GETB 0 32> 1>>
	<SCREEN ,S-WINDOW>
	<CURSET 1 1>
	<INVERSE-LINE>
	<CURSET 2 1>
	<INVERSE-LINE>
	<CURSET 3 1>
	<INVERSE-LINE>
	<CENTER-LINE 1 "INVISICLUES (tm)" %<LENGTH "INVISICLUES (tm)">>
	<LEFT-LINE 2 " N = Next">
	<RIGHT-LINE 2 "P = Previous" %<LENGTH "P = Previous">>
	<COND (<T? .THIRD>
	      <LEFT-LINE 3 " RETURN = See topics">
	      <RIGHT-LINE 3 "Q = Resume story" %<LENGTH "Q = Resume story">>)>>

<ROUTINE CENTER-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
	<COND (<ZERO? .LEN>
	       <DIROUT ,D-TABLE-ON ,DIROUT-TBL>
	       <TELL .STR>
	       <DIROUT ,D-TABLE-OFF>
	       <SET LEN <GET ,DIROUT-TBL 0>>)>
	<CURSET .LN <+ </ <- <LOWCORE SCRH> .LEN> 2> 1>>
	<COND (.INV
	       <HLIGHT ,H-INVERSE>)>
	<TELL .STR>
	<COND (.INV
	       <HLIGHT ,H-NORMAL>)>>

<ROUTINE LEFT-LINE (LN STR "OPTIONAL" (INV T))
	<CURSET .LN 1>
	<COND (.INV
	       <HLIGHT ,H-INVERSE>)>
	<TELL .STR>
	<COND (.INV
	       <HLIGHT ,H-NORMAL>)>>

<ROUTINE RIGHT-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
	<COND (<ZERO? .LEN>
	       <DIROUT 3 ,DIROUT-TBL>
	       <TELL .STR>
	       <DIROUT -3>
	       <SET LEN <GET ,DIROUT-TBL 0>>)>
	<CURSET .LN <- <LOWCORE SCRH> .LEN>>
	<COND (.INV
	       <HLIGHT ,H-INVERSE>)>
	<TELL .STR>
	<COND (.INV
	       <HLIGHT ,H-NORMAL>)>>

<GLOBAL DIROUT-TBL
	<TABLE 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 >>

;"longest hint topic can be 17 questions long, longest question 36 characters"

<GLOBAL HINTS
   <PLTABLE
    ;"Table of chapters."
      <PLTABLE 
       "ON THE EARTH"
         <LTABLE 3
	  "How do I get out of the dark?"
      	  "TURN ON THE LIGHT.">
	 <LTABLE 3
       	  "Why can't I pick things up?"
	  "Are you out of the bed with the light on?"
	  "The room is spinning because you have a hangover."
	  "There is ONE thing you can pick up."
	  "It's the gown.">
	 <LTABLE 3
	  "How can I get out of the bedroom?"
	  "You bounce off the doorframe because the room is spinning from your hangover."
	  "You'll have to get rid of it."
	  "See the previous question."
	  "There's an aspirin in the pocket of the gown."
	  "TAKE GOWN. PUT IT ON. OPEN THE POCKET. TAKE THE ANALGESIC.">
	 <LTABLE 3
	  "Is the pile of mail important?"
	  "Have you read the mail?"
	  "Now you know what's going on outside."
	  "Take it along, it might prove useful later.">
	 <LTABLE 3
	  "What's that bulldozer doing outside?"
	  "Have you read the pile of mail on your Front Porch?"
	  "It's there to knock down your house to make way for a new highway bypass.">
	 <LTABLE 3
	  "How do I stop the bulldozer?"
	  "There's a tried and true method for stopping bulldozers."
	  "Have you tried phoning the police?"
	  "Have you tried to PROTEST or asked PROSSER, STOP THE BULLDOZER?"
	  "Have you tried to STAND IN FRONT OF THE BULLDOZER?"
	  "In case you haven't figured it out from these subtle clues, you want to LIE DOWN IN FRONT OF THE BULLDOZER."
	  "BLOCK THE BULLDOZER, STOP THE BULLDOZER, or LIE DOWN also work."
	  "You'll have to wait a few turns after you lie down before the bulldozer finally grinds to a halt.">
	 <LTABLE 3
	  "What should I do with Ford Prefect?"
	  "If you take the towel he's trying to give you, he'll walk away."
	  "Standing up to follow him is fatal."
	  "Without Ford you'll never survive the upcoming destruction of the Earth."
	  "Ford is oblivious to your problem. If you wait, he'll notice the bulldozer, and help you out."
	  "Or you can say FORD, WHAT ABOUT MY HOME? as soon as he arrives.">
	 <LTABLE 3
	  "Should I go with Ford to the Pub?"
	  "Don't stand up until Prosser is lying down in your place."
	  "This will happen if you wait a few turns after Ford shows up."
	  "At this point, listen to Ford and follow him to the Pub.">
	 <LTABLE 3
	  "What should I do in the Pub?"
	  "You came here because of Ford, right?"
	  "Why not do as he says?"
	  "Drink some beer."
	  "Also, have you noticed the shelf of items behind the bar?">
	 <LTABLE 3
	  "How much beer should I drink?"
	  "Ford will keep urging you to drink beer until you've had enough."
	  "If you have fewer than three beers, the shock of the matter transference beam will kill you."
	  "If you have more than three beers, you'll get drunk and end up partying through the end of the world."
	  "Drink the beer three times.">
	 <LTABLE 3
	  "How can I buy beer?"
	  "You can't."
	  "But so what? Ford buys some for you.">
	 <LTABLE 3
	  "How can I buy a packet of peanuts?"
	  "You can't."
	  "At least, not when you're Arthur.">
	 <LTABLE 3
	  "How can I buy a cheese sandwich?"
	  "How about BUY A CHEESE SANDWICH."
	  "Or BARTENDER, GIVE ME A CHEESE SANDWICH."
	  "Perhaps ASK BARTENDER FOR A SANDWICH is more up your alley.">
	 <LTABLE 3
	  "My home's being wrecked. What now?"
	  "There's not much you can do about it."
	  "You might return to survey the rubble, or to have it out with Prosser.">
	 <LTABLE 3
	  "What should I do about the dog?"
	  "Have you examined the dog?"
	  "If you haven't figured it out, you'll find out more later.">
	 <LTABLE 3
	  "How do I survive Earth's demolition?"
	  "DON'T PANIC."
	  "Read everything carefully."
	  "Remember Ford's reason for drinking all that beer?"
	  "It has to do with that small black device that Ford drops after the fleet arrives."
	  "Have you tried picking it up?"
	  "Have you tried examining it?"
	  "You want to hitch a ride aboard one of the Vogon ships."
	  "PUSH THE GREEN BUTTON.">
	 <LTABLE 3
	  "Why do I die during transference?"
	  "You didn't drink enough beer."
	  "See the question about how much beer to drink.">>
      <PLTABLE
       "IN THE DARK"
         <LTABLE 3
	  "Help! I'm stuck in the Dark!"
	  "If this \"Dark\" is at the very beginning of the game, you're in the wrong place. Look at the very first question."
	  "You've been through a matter transference beam, and still haven't recovered from the shock of it."
	  "Recovery takes time..."
	  "...but in this case, you'll have to do more than just wait.">
	 <LTABLE 3
	  "How do I get out of this Dark?"
	  "Have patience."
	  "Read carefully."
	  "If you've waited enough you'll begin to get some clues."
	  "Read each response to WAITing in the Dark very carefully."
	  "There's an important difference between the third and fourth responses."
	  "You are no longer told that you can't smell anything."
	  "Try SMELL THE DARKNESS or SMELL NOTHING or even just SMELL.">
	 <LTABLE 3
	  "What's this shadow I see?"
	  "That's your way out of Dark."
	  "EXAMINE THE SHADOW.">
	 <LTABLE 3
	  "Help! I'm in the blasted Dark AGAIN!"
	  "Unless you've been to the Vogon Hold, you're at the wrong question."
	  "You've been through Dark at least once before, so you know what's going on."
	  "This time, though, it isn't smell that goes away on the fourth description."
	  "It's hearing."
	  "Try HEAR NOTHING or LISTEN TO DARKNESS."
	  "There is an exit to port. Try going that way."
	  "Be persistent. Try going PORT a few more times."
	  "Perhaps AFT would be more productive, come to think of it.">
	 <LTABLE 3
	  "Exactly how does Dark work?"
	  "You enter Dark when Earth is destroyed, and other times throughout the game."
	  "At the fourth turn in Dark, one of your five senses will disappear."
	  "You should type the sense that no longer appears, such as SMELL or SEE."
	  "The first time, smell will go away. See the first question in this section."
	  "The second time, hearing will go away. See the third question in this section."
	  "On subsequent visits to Dark, the sense that disappears will be fairly random. See the following question for more details.">
	 <LTABLE 3
	  "Can I control my exit from Darkness?"
	  "Not usually."
	  "Don't continue until you have a cup of tea."
	  "Don't continue until you have real tea, not merely Advanced Tea Substitute."
	  "Have you ever examined the cup of tea?"
	  "Tea is a better source of Brownian Motion for the Improbability Drive than the Advanced Tea Substitute (ATS). Try it."
	  "Notice anything different about Dark when you use tea instead of ATS?"
	  "For one thing, a sense is missing right away, rather than after three WAITs."
	  "More importantly, with tea, a different sense will be missing each time you WAIT. Thus, you can \"control Dark.\""
	  "There are eight exits from Dark (taste never goes away), so there are two Dark exits for each missing sense."
	  "There is a way to differentiate between each pair."
	  "For example, when smell disappears, type SMELL DARK. If the object is \"being waved,\" then the exit leads to the Vogon Hold. If the object is \"waving,\" the exit is the Lair of the Ravenous Bugblatter Beast of Traal."
	  "When hearing is missing: If the sound is \"far above you,\" then your exit is Entry Bay Number Two of the Heart of Gold. If it's \"far below you,\" then it's the War Chamber of the battle fleet."
	  "If seeing is the missing sense: When the light stabs at the \"front\" of your eyes, then your exit is the Country Lane. When it's at the \"back\" of your eyes, then you go onto the Presidential Speedboat."
	  "When feel is missing: If it feels \"cold\" and wet and squishy, the exit is to the Living Room party. When it's \"warm,\" your exit is into the sperm whale."
	  "When you are controlling dark and have determined your current exit, but you don't want to go there, simply WAIT and you will get a new missing sense. NOTE: You will never get the whale exit unless you are using real tea for your Brownian Motion source.">>
      <PLTABLE
       "THE VOGON SHIP"
         <LTABLE 3
	  "Where the heck am I?"
	  "As your status line says, you are in the Vogon Hold."
	  "ASK FORD ABOUT THE EARTH."
	  "The Earth has been destroyed by the Vogon fleet. You and Ford have hitched a ride aboard one of the ships of the Vogon Fleet by using the electronic Sub-Etha signaling device, also known as a Thumb.">
	 <LTABLE 3
	  "Why do I get groggy and die?"
	  "This is caused by your protein loss during the matter transference beams."
	  "Do you have anything with a lot of protein in it?"
	  "It's something that Ford just gave you."
	  "It's frequently found on shelves behind bars in Pubs."
	  "EAT THE PEANUTS.">
	 <LTABLE 3
	  "What's this Guide Ford gives me?"
	  "That's the Hitchhiker's Guide to the Galaxy."
	  "It's the single most useful thing an intergalactic hitchhiker (or Infocom game player) can have."
	  "See the Hitchhiker's Guide question in the General Questions section for more information.">
	 <LTABLE 3
	  "How can I wake Ford?"
	  "Have you tried WAKE FORD?"
	  "You can't wake Ford."
	  "You'll have to get the babel fish on your own.">
	 <LTABLE 3
	  "How do I open the case?"
	  "There's a switch and a keyboard attached to the case."
	  "SAVE first, then try typing on the keyboard. For example, TYPE \"HELLO.\""
	  "Well, perhaps that wasn't such a great idea. Try flipping the switch."
	  "If the recording was gibberish, you'll have to find a way to translate it."
	  "See the question about the babel fish."
	  "Once you have the babel fish, flip the switch again."
	  "Now you know what to type. Just wait around to hear the captain's poetry reading and see the question about what's going on in the Captain's Quarters.">
	 <LTABLE 3
	  "What is the tall dispensing machine?"
	  "Examine it.">
	 <LTABLE 3
	  "Why does the machine go \"click\"?"
	  "It's out of fish. Time to RESTORE.">
	 <LTABLE 3
	  "What is a babel fish?"
	  "Consult the Guide.">
	 <LTABLE 3
	  "How can I get a babel fish?"
	  "Have you pressed the dispenser button?"
	  "You need to block the small hole."
	  "Use the hook above the hole."
	  "Hang something on the hook."
	  "Examine the gown."
	  "Hang the gown on the hook, then press the button again."
	  "You'll have to block the drain."
	  "There's only one thing large enough to completely cover the drain."
	  "Cover the drain with the towel, then push the button again."
	  "You have to block the tiny robot panel."
	  "Standing or lying in front of the panel won't work."
	  "You have to put some object in front of the panel."
	  "If it isn't bulky enough, the cleaning robot dashes around it."
	  "The satchel is bulky. Put it in front of the panel, then push the button again."
	  "At this point, brave men have been known to break down and cry."
	  "Read, very carefully, the paragraph when Ford goes to sleep."
	  "When you placed the satchel in front of the panel, the satchel is now LYING ON ITS SIDE in front of the panel."
	  "You can put an object on top of the satchel."
	  "Put something on the satchel, then push the button again."
	  "The upper-half-of-the-room cleaning robot just manages to catch the second item."
	  "If there were several items on the satchel, they would all fly into the air and confuse the flying robot."
	  "Unfortunately, there's only room for one object on the satchel."
	  "Is there an object that when flung into the air might act as many items?"
	  "When the upper-half-of-the-room cleaning robot grabbed the babel fish the first time it said that the fish was \"the only flying junk\" that the robot found."
	  "Put the junk mail on the satchel, then press the button one last time.">
	 <LTABLE 3
	  "What's the gibberish I hear?"
	  "It's an announcement in Vogonese."
	  "If you want to understand the announcement, you'll have to discover a way to translate it."
	  "See the questions about the babel fish."
	  "The announcement will begin 18 turns after you enter the Vogon Hold, or 3 turns after you obtain the babel fish.">
	 <LTABLE 3
	  "Why are the guards dragging me away?"
	  "See the question about the gibberish from the intercom."
	  "The guards will arrive 36 turns after you arrive in the Vogon Hold, or 5 turns after you obtain a babel fish.">
	 <LTABLE 3
	  "What happens in Captain's Quarters?"
	  "Don't go on unless you've translated the garbled announcement."
	  "Don't go on until you've figured out what's going on with the glass case and switch and keyboard."
	  "You are at a Vogon Poetry Appreciation Session. The Vogon Captain is about to read you his favourite poem. The Guide's entry on Vogon Poetry makes clear that this is extremely nasty."
	  "You should now know that you have to listen to the second verse (not line) of the poem in order to get the atomic vector plotter."
	  "This poetry is painfully awful. Have you tried to STOP THE POETRY or COVER MY EARS or DON'T LISTEN TO THE VOGON POETRY."
	  "When he finishes the first verse the Captain says, \"You didn't look like you enjoyed my poetry at all!\" and then has you thrown into space."
	  "Why not relax and enjoy it?"
	  "ENJOY THE POETRY while the Captain reads the first verse. He will continue on and read the second verse."
	  "Now that you've heard the glass case's recording AND the second verse of the poem, you know what to type on the keyboard to get the atomic vector plotter. (When the guards drag you back into the Vogon Hold, of course.)"
	  "For example, if the recording asked you to type the second word from the second verse, and the word was \"lyshus,\" you should type TYPE \"LYSHUS\" when you get back to the Vogon Hold. NOTE: Each time you play the game, the lines of the second verse come in different orders. Similarly, the glass case's recording asks for a different number word each time you play.">
	 <LTABLE 3
	  "Can I stop being put in the airlock?"
	  "There's no way to prevent this."
	  "However, you should make sure that you've accomplished everything that needs to be accomplished aboard the Vogon ship before this occurs."
	  "You should have gotten the atomic vector plotter.">
	 <LTABLE 3
	  "Can I survive in outer space?"
	  "Yes. In fact, there's no way to NOT survive it."
	  "If you wait, you'll find yourself in the Dark again."
	  "Examine the Thumb while in the Airlock."
	  "Apparently, there's another spaceship nearby. Try hitchhiking by pressing the green button."
	  "This sends you through a matter transference beam, and you find yourself in the Dark again."
	  "Both methods of surviving the Airlock are equivalent.">>
      <PLTABLE
       "THE HEART OF GOLD"
         <LTABLE 3
	  "Who picked us up hitchhiking?"
	  "Listen to Ford."
	  "Read the sales brochure that's in the Entry Bay."
	  "You've just been picked up by a fantastic new spaceship powered by something called an Infinite Improbability Drive. Find out more about the drive."
	  "To find out who owns the ship, stick around on the bridge and pay attention to what everyone is saying."
	  "The woman is Tricia MacMillan, known as Trillian. She's an Earthwoman whom you met at a party in Islington not too long ago, at which time you totally failed to impress her. She eventually left the party with a guy named Phil...who is, you realize, the two-headed man standing next to her."
	  "The man is Zaphod Beeblebrox, current President of the Galaxy, who has stolen this revolutionary new Infinite Improbability Drive-powered spaceship in order to locate the legendary lost planet of Magrathea. Zaphod and Ford know each other."
	  "That you should be picked up in the vast emptiness of space by a ship inhabited by an acquaintance from your now destroyed native planet as well as your travelling companion's semi-cousin, can only be considered highly improbable. But then, with Infinite Improbability Drives at work, the infinitely improbable is not only possible but quite likely.">
	 <LTABLE 3
	  "How can I enter the sauna?"
	  "From the Bridge, walk to port."
	  "There is no way to actually STAY in the sauna."
	  "Therefore, once Ford, Zaphod, and Trillian enter the sauna, they will be effectively inaccessible to you for the remainder of the game.">
	 <LTABLE 3
	  "Is Eddie, the ship computer, of use?"
	  "Without Eddie, who would make all those fun announcements?"
	  "Eddie is the only one who can turn on the main drive."
	  "But he won't obey your order to do that, only Zaphod's."
	  "Eddie's help is indirectly necessary to obtain a cup of tea."
	  "But in terms of solving puzzles, you can basically ignore Eddie.">
	 <LTABLE 3
	  "Are the Bridge controls useful?"
	  "Have you examined them?"
	  "The large receptacle is important."
	  "Don't go on until you've figured out how to set up and use the spare Improbability Drive."
	  "The large plug from the spare Drive can be plugged into the large receptacle."
	  "But that isn't necessarily the right thing to do."
	  "In fact, when you plug in the spare Drive at the wrong time, Eddie warns you that it's only for emergencies."
	  "When you use the drive while it's plugged into the large receptacle, both the large receptacle and the large plug are destroyed."
	  "You can only use the drive while connected to the controls ONCE during the course of the game."
	  "See the question about the missile attack at the end of this section.">
	 <LTABLE 3
	  "How does the Nutrimat work?"
	  "All you have to do is touch the touch-sensitive pad."
	  "The Nutrimat does all the rest, and in seconds you'll have your very own cup of incredibly delicious Advanced Tea Substitute (ATS)."
	  "Well, maybe not so delicious. But at least useful."
	  "Actually, there is a way to get something else from the Nutrimat."
	  "It's a cup of tea (REAL tea, not ATS)."
	  "But first, you'll need something that isn't in the Galley."
	  "In fact, it isn't even in the Heart of Gold."
	  "Don't go on unless you have the Nutrimat/Computer Interface (not to be confused with the shipping carton for the interface)."
	  "Use the interface."
	  "Open the service panel and remove the circuit board. Now, put the interface inside the Nutrimat. Finally, touch the pad!"
	  "Still having trouble getting tea? See the question about the missile attack. It's the last question in this section.">
	 <LTABLE 3
	  "What is the Advanced Tea Substitute?"
	  "ATS is useful, although drinking it is a bad idea."
	  "Have you ever examined it?"
	  "Have you discovered a need for a source of Brownian Motion?"
	  "See the question about the spare Improbability Drive.">
	 <LTABLE 3
	  "Is the cup of tea important?"
	  "Don't go on unless you actually have the cup of tea."
	  "Don't go on unless this cup of tea is REAL tea, not just Advanced Tea Substitute (ATS)."
	  "Have you ever examined the tea?"
	  "Because it has even more Brownian Motion than the ATS, it will make a better source of it for the spare Improbability Drive. Try it."
	  "See the question about controlling where you go when you leave Dark, in the section called \"In the Dark\".">
	 <LTABLE 3
	  "How do I adjust the circuit board?"
	  "You can remove it from the Nutrimat."
	  "Have you examined it?"
	  "You can flip any of the eight dipswitches."
	  "You can even flip them while the circuit board is still in the Nutrimat."
	  "Have you noticed the message in tiny letters on the board?"
	  "There IS a way to read that message."
	  "Don't go on until you've been on Damogran."
	  "Don't go on until you've opened the toolbox."
	  "READ THE MESSAGE THROUGH THE MAGNIFYING GLASS.">
	 <LTABLE 3
	  "Is the shipping carton important?"
	  "Try examining or reading it."
	  "Have you opened the carton?"
	  "The Sirius Cybernetics Corporation has apparently screwed up (a common occurrence) and put the wrong item inside the shipping carton."
	  "You'll be able to find the Nutrimat/Computer Interface elsewhere in the game.">
	 <LTABLE 3
	  "Is the strange gun important?"
	  "Have you examined or read it?"
	  "Don't go on unless you've been in the Lair."
	  "Have you tried shooting the gun at the Beast?"
	  "Have you tried it several times?"
	  "The gun is completely worthless, useless, and unimportant.">
	 <LTABLE 3
	  "Can I go aft from Corridor, Aft End?"
	  "Yes, but not without a fight."
	  "You'll have to argue with the game for a few turns."
	  "Usually, YES or NO responses are sufficient."
	  "The proper sequence, from the Corridor, Aft End is AFT. YES. YES. AFT. NO.">
	 <LTABLE 3
	  "Is anything in the Engine Room?"
	  "Have you gotten into the Engine Room? If not, you should do so before looking at the next hint."
	  "The game claims that there's nothing interesting there."
	  "However, after losing that argument with you, the game is probably a bit peeved and is acting petulant."
	  "You'll have to be persistent if you want to find out what's in the Engine Room."
	  "Type LOOK three times. The game will then give in and describe the room and the stuff there.">
	 <LTABLE 3
	  "Is the spare Drive important?"
	  "Read the Guide entry on Improbability Physics."
	  "You'll need the atomic vector plotter from the Vogon Hold. If you never got it while you were aboard the Vogon ship, you'll have to start the game over or go back to a saved position."
	  "You'll also need a good source of Brownian Motion."
	  "Consult the Hitchhiker's Guide about Brownian Motion."
	  "Have you seen any hot liquids?"
	  "You'll need the cup of Advanced Tea Substitute (ATS), which you can get from the Nutrimat in the Galley."
	  "Now that you have all three items (spare Drive, plotter, and cup of ATS), you should be able to figure out how to hook them together."
	  "Examine all three items."
	  "You want to plug the small plug (from the drive) into the small receptacle (in the atomic vector plotter). Put the plotter's long dangly bit into the cup of ATS."
	  "That still leaves the drive's large plug unattached. See the question about the controls on the Bridge.">
	 <LTABLE 3
	  "How can I open the screening door?"
	  "This is a very difficult problem."
	  "Furthermore, you won't be able to tackle it until you're pretty far into the game. Don't let it worry you until you get up around 200 points."
	  "Don't develop any further unless you've gotten the cup of tea (real tea, not Advanced Tea Substitute)."
	  "Presumably you've tried OPEN THE DOOR."
	  "You have to show an example of your intelligence to the screening door."
	  "Read the Guide entry on INTELLIGENCE."
	  "Can you think of anything contradictory that you could have or do?"
	  "To show your intelligence, there are two specific items that you must be holding at the same time."
	  "Have you noticed what happens when you take or drop the (real) tea?"
	  "To prove your intelligence to the door, you must be holding TEA and NO TEA at the same time."
	  "Try going back to the beginning of the game and taking or dropping NO TEA."
	  "Does the response to that ring any bells?"
	  "Have you ever read or examined the black particle in the Maze?"
	  "Do you know where you are when you are in the Maze? If not, see the questions on the Maze."
	  "The Maze is your own brain, and the particle is your common sense. Once you have removed the particle, you will no longer be fettered by common sense and can take NO TEA."
	  "Spelling it out step by step: First, acquire a cup of tea. Then get rid of the common sense particle in the Maze. TAKE TEA THEN TAKE NO TEA. Finally, SHOW THE TEA AND THE NO TEA TO THE SCREENING DOOR."
	  "Did you die upon passing through the screening door? It's because Marvin lives in the room beyond the door, and his awesome depression pervades the place."
	  "You'll have to make yourself very happy before entering."
	  "Have you ever done anything that made you very happy and contented?"
	  "Drink the cup of tea before you enter.">
	 <LTABLE 3
	  "Is Marvin important?"
	  "Yes, but not right away."
	  "Until a point, he won't do anything you tell him to do."
	  "After that point, he'll grudgingly consent to ONE task."
	  "Have you ever followed Marvin when he appears around the Heart of Gold?"
	  "He always disappears through a certain door."
	  "Before Marvin will perform his one task, you must get past the screening door near the aft end of the corridor."
	  "Don't go on until you've been in Marvin's Pantry."
	  "Congratulations. You've now impressed Marvin enough for him to listen to one request from you. Do you have any idea what order to give him?"
	  "What puzzles or obstacles still remain that he might help with?"
	  "Try examining the mechanism in the Access Space."
	  "If you've ever seen the fruit, eating it would provide a big hint."
	  "You want to order Marvin to open the hatch (as in MARVIN, OPEN THE HATCH). See the question about opening the hatch for more information.">
	 <LTABLE 3
	  "How can I open the hatch?"
	  "Have you tried OPEN THE HATCH?"
	  "If sirens and lights went off when you tried to open the hatch, then the ship is still in space. Wait until the ship has landed."
	  "Do you remember an announcement when the Heart of Gold landed on Magrathea?"
	  "Eddie (the shipboard computer) jammed the hatch to prevent anyone from leaving the ship until he's checked to make sure the environment is safe."
	  "If you wait the 14.9 years such a check will take, you'll probably die of boredom."
	  "You'll have to figure out how to override Eddie's wishes by fixing the hatchway mechanism in the Access Space."
	  "You don't have the necessary intelligence for the task."
	  "Someone else does."
	  "Marvin. See the question about Marvin to figure out how to get him to open the hatch."
          "Once Marvin has agreed to open the hatch, he tells you to meet him in the Access Space in twelve turns. Make sure you're on hand for that meeting. (Hell hath no depression like a paranoid android scorned.)"
	  "Marvin will ask you for the tool he needs to fix the mechanism."
	  "You must give him the proper tool or you've blown your one chance to get the hatchway open."
	  "There are a total of ten tools scattered throughout the game. For a complete list of them, see the quesion about the tools in the General Questions section."
	  "Even if you've collected all ten tools, you can only carry one at a time into the Access Space..."
	  "...and you don't have time to go out and get a different one before Marvin gives up and leaves..."
	  "...and Marvin will NEVER ask for the tool you happen to be holding."
	  "There's a way to figure out in advance what tool Marvin will ask you for."
	  "See the question about the fluff."
	  "Don't go on until you've seen the fruit."
	  "Eat the fruit."
	  "The glimpse of the future provided by the fruit tells you what tool to bring into the Access Space."
	  "If you meet Marvin there and give him that tool when he asks for it, he will fix the mechanism and open the hatch."
	  "You're now awesomely close to the end of the game."
	  "Go down through the hatch."
	  "Start waiting for the next exciting Hitchhiker's game.">
	 <LTABLE 3
	  "How do I stop the missile attack?"
	  "This is a good point for a SAVE."
	  "The computer is helpless because you've tied it up with the Nutrimat interface."
	  "You'll have to save the ship yourself."
	  "The computer is tied up, so it can't turn on the main Drive during this emergency."
	  "There's a spare Drive for use during emergencies."
	  "Turn on the spare Drive."
	  "That didn't work? Have you examined the spare Drive and the control console on the Bridge?"
	  "If there are fused spots where the large plug and large receptacle used to be, you plugged the drive in at the wrong time."
	  "Note that when the spare Drive is NOT connected to the control console and you turn it on, the effect is always directed at you personally. When the spare Drive IS connected to the console, activating it has an effect on the entire ship."
	  "Turning on the spare Drive while it's plugged into the control console destroys the large plug and large receptacle, so you can only do it once during the game. The one time you want to activate the drive while plugged into the control console is during the missile attack.">>
      <PLTABLE
       "ON TRAAL"
         <LTABLE 3
	  "How do I go southwest from the Lair?"
	  "Figuring out how to subdue the Beast would help.">
	 <LTABLE 3
	  "Can I stop the Beast from eating me?"
	  "The Beast will devour you about five turns after you pop up in its Lair."
	  "Leaving the room (EAST) will buy you some time."
	  "Have you read the Guide entry on the Ravenous Bugblatter Beast of Traal?"
	  "You must find a way to prevent yourself from seeing the Beast. The Beast will then decide that since you can't see it, it can't see you!"
	  "Closing your eyes isn't obvious enough for the Beast to notice."
	  "You have to cover your head with something."
	  "It's something important, which no interstellar hitchhiker should ever be without."
	  "The towel. COVER MY HEAD WITH THE TOWEL or PUT THE TOWEL OVER MY EYES or WRAP THE TOWEL AROUND MY HEAD."
	  "Unfortunately, you can't move around very well with a towel over your eyes. Furthermore, as you may have already noticed, this method is also only temporarily effective.">
	 <LTABLE 3
	  "Why does the beast ask me my name?"
	  "A good question. Have you tried figuring out the answer yourself?"
	  "Have you been in the Beast's Outer Lair?"
	  "Have you ever tried saying your name as the Beast demands?"
	  "There are at least a dozen ways to say your name: SAY MY NAME or SAY \"ARTHUR DENT\" or SAY \"MY NAME IS ARTHUR DENT\" are some."
	  "You have to give your correct name to the Beast, or (in a rare moment of Bugblatter Beast perceptivity) it will be able to tell that you're lying. In addition, you can't tell the Beast your name if the Beast thinks it can't see you."
	  "The Beast's response when you told it your name should provide an additional hint toward why the Beast wants to know your name and how to solve this entire Traal puzzle."
	  "Still stuck? Go on to the next question.">
	 <LTABLE 3
	  "What use is the sandstone memorial?"
	  "Have you figured out why the Beast wants to know your name?"
	  "The Beast wants to carve your name in this, his memorial of remembrance, after he has devoured you."
	  "Have you figured out how to stop the Beast from attacking you, at least on a temporary basis?"
	  "Don't go on until you have figured out how to convince the Beast that it can't see you."
	  "There's a way to confuse the Beast into thinking that it has already eaten you."
	  "You want to carve your name in the memorial, as in CARVE MY NAME ON THE SANDSTONE MEMORIAL."
	  "Of course, you'll need something to carve with."
	  "It's not any of the tools."
	  "It's something found on Traal."
	  "Use one of the sharp stones that are lying on the ground."
	  "First you have to tell the Beast your name and cover your head with the towel."
	  "It is now safe to remove the towel from your head, and to go southwest from the Lair.">
	 <LTABLE 3
	  "Are the tall walls important?"
	  "If you could climb them, you might be able to escape the Beast."
	  "If you could collapse them onto the Beast, that just might do it in."
	  "If you could transmute them into steaming mounds of Qurmeesian Mega-Rhino flank steaks, the Beast might start in on those and ignore your few measly pounds of stringy flesh."
	  "Unfortunately, you can't do any of the above.">
	 <LTABLE 3
	  "Are the bleached bones important?"
	  "Don't go on until you've found the black paint."
	  "Have you tried painting the bones with the paint?"
	  "Where does the Beast go when he sees the black bones?"
	  "Black paint? There's no black paint. You're looking at answers you shouldn't be.">
	 <LTABLE 3
	  "Are the sharp stones important?"
	  "Have you examined them?"
	  "See the question about the sandstone memorial.">
	 <LTABLE 3
	  "What's the point of the Traal scene?"
	  "First you'll have to figure out how to \"neutralize\" the Beast."
	  "Don't go on until the Beast is sleeping."
	  "Have you been in the Inner Lair?"
	  "Go southwest from the Lair."
	  "The entire point of this scene is to get that Nutrimat/Computer Interface."
	  "You have a limited number of moves to get the interface, after the Beast falls asleep and before the Fronurbdian Beasthunters arrive.">>
      <PLTABLE
       "ON DAMOGRAN"
         <LTABLE 3
	  "Who am I?"
	  "Ask the game! (Type WHO AM I?)">
	 <LTABLE 3
	  "Where am I?"
	  "You're on Damogran. If you'd like to know more about it, consult the Hitchhiker's Guide.">
	 <LTABLE 3
	  "How can I open the toolbox?"
	  "Since it's locked, you'll need to find a key."
	  "Try typing WHERE IS THE KEY while on the speedboat."
	  "There aren't a lot of hiding places around the boat."
	  "SEARCH THE PILOT SEAT or LOOK UNDER THE CUSHION.">
	 <LTABLE 3
	  "Can I stop the boat from crashing?"
	  "EXAMINE THE CONTROLS."
	  "PUSH THE AUTOPILOT BUTTON."
	  "The autopilot doesn't seem concerned about your situation, since it just takes a look around and then shuts itself off."
	  "You need to give the autopilot some impetus to go to work."
	  "Instead of steering toward the channel, try steering toward the cliff or the rocky spire."
	  "After three turns of heading toward an obstacle, the autopilot will kick on and navigate you safely to your destination.">
	 <LTABLE 3
	  "What do I do when the boat docks?"
	  "Leave the boat. Type NORTH or LEAVE THE BOAT.">
	 <LTABLE 3
	  "What do I do when I reach the Dais?"
	  "You're here for the dedication ceremonies of the Heart of Gold. You obviously have the crowd eating out of your hands."
	  "You might try smiling, or waving, or making a speech."
	  "Mainly, though, you just need to wait until Trillian shows up.">
	 <LTABLE 3
	  "What do I do about the Guards?"
	  "Don't go on unless you're on the Dais and Trillian is there."
	  "Trillian isn't really attacking you. It's just part of your plan to steal the Heart of Gold."
	  "The guards don't know that you're planning to steal the Heart of Gold, so they're on your side."
	  "You're President of the Galaxy! The guards will probably listen to your orders."
	  "You should say GUARDS, DON'T SHOOT or GUARDS, DROP THE PHOTON RIFLES."
	  "If you're still having troubles with the guards, see the next question.">
	 <LTABLE 3
	  "How can I enter the Heart of Gold?"
	  "Until Trillian shows up, the game won't even let you try."
	  "After Trillian shows up, attempting to enter the Heart of Gold is deadly."
	  "Don't go on unless you've disarmed the guards (see the previous question)."
	  "This isn't helpful all by itself, since the guards pick up their rifles and still shoot you if you break for the ship."
	  "You have to figure out a way to get rid of the guards or the rifles permanently."
	  "The guards will NOT leave the scene, no matter what you do."
	  "Trying to shoot the guards doesn't work either."
	  "There is, however, a way to dispose of the rifles."
	  "Take the blaster from Trillian and shoot the rifles. Alternatively you can just ASK TRILLIAN TO SHOOT THE PILE OF RIFLES."
	  "Once you've destroyed the rifles, it's safe to enter the ship.">
	 <LTABLE 3
	  "What's the point of Damogran?"
	  "Don't go on until you ended the scene by successfully entering the Heart of Gold. (If you were killed by the guards, you were NOT successful.)"
	  "Have you opened the toolbox?"
	  "If you've opened the toolbox, then you've certainly found both the seat cushion fluff and the laser-assisted monkey wrench. Getting these two items are the ultimate goal of the Damogran scene.">>
      <PLTABLE
       "AT THE PARTY"
         <LTABLE 3
	  "Who am I?"
	  "Ask the game. (Type WHO AM I?)">
	 <LTABLE 3
	  "Where am I?"
	  "Remember what happened when you first reached the Bridge of the Heart of Gold?"
	  "This is the Party where Arthur Dent tried to pick up Tricia MacMillan (but, you'll recall, failed completely)."
	  "Thanks to the wild vagaries of Improbability Physics, you have not only travelled back in time, you have changed your identity as well.">
	 <LTABLE 3
	  "What should I do about Phil?"
	  "If you try to talk to Phil, he doesn't notice, and invariably leaves the room."
	  "Have you examined him?"
	  "The draped cage on his shoulder does NOT contain a bird."
	  "The cage is hiding Phil's second head."
	  "Phil is actually Zaphod Beeblebrox in disguise. He has undoubtedly dropped by this Islington party as part of some interstellar party-crashing hop."
	  "If you recall from the events on the Bridge of the Heart of Gold, you (Trillian) eventually left ... er, will leave ... the party with Zaphod/Phil."
	  "But that won't happen until you do something else. See the question about the point of the party scene.">
	 <LTABLE 3
	  "What should I do about Arthur?"
	  "Arthur keeps trying to start a conversation with you, but he's too shy and embarrassed. If you try to talk to him, he finds your tone rather cool, and moves away."
	  "Have you examined him?"
	  "Notice the fluff?"
	  "If you take the fluff from his jacket, it will \"break the ice\" and Arthur will begin jabbering."
	  "Did you notice that you can't take the fluff until you drop one of the other things you're carrying (handbag, wine, hors d'oeuvres)? You can't hold more than three things while you're at the party.">
	 <LTABLE 3
	  "What should I do about the hostess?"
	  "You're usually able to avoid her."
	  "If you try to talk to her, you'll learn the meaning of the phrase \"bored to death.\""
	  "If you drop your glass of wine, your handbag, or your plate of hors d'oeuvres, the hostess will come over and pester you about it. She won't leave you alone until you take the item that you dropped.">
	 <LTABLE 3
	  "How can I leave the apartment?"
	  "Try going south from the Living Room."
	  "Dying will get you back to Dark, but that's probably not what you had in mind."
	  "There is a way to leave the apartment, but you'll have to solve a puzzle first. See the next question.">
	 <LTABLE 3
	  "What's the point of the party scene?"
	  "There's an item at the party that you have to get back to the Heart of Gold."
	  "That item is the unsightly piece of jacket fluff."
	  "See the previous questions in this section of the hint booklet."
	  "You want to get \"picked up\" by Phil. However, he won't take any notice of you until you take the fluff and get Arthur talking to you."
	  "In order to take the fluff, though, you'll have to drop something. This will cause the hostess to start hovering around you. Phil is much too smart to approach you when you're with the hostess."
	  "So, to get Phil to come over, you'll have to take the item that the hostess keeps offering you. To do so, you'll have to drop something, and the piece of fluff is the only thing you have that you can drop without setting off the hostess again."
	  "There IS a way to stop holding the fluff WITHOUT dropping it."
	  "Look at what you're carrying again."
	  "You can put the fluff in your handbag."
	  "Naturally, the fluff is still in the handbag when you eventually get back to the Heart of Gold. You need only go to the Bridge or wherever you left the handbag, open it, and take the jacket fluff."
	  "If you're still confused, one sequence of moves that will \"solve\" the party scene is:  EXAMINE ARTHUR. DROP THE WINE. TAKE THE JACKET FLUFF. OPEN THE HANDBAG. PUT THE FLUFF IN THE HANDBAG. TAKE THE WINE. Then just WAIT until Phil comes up and escorts you away. You will end up in Dark.">>
      <PLTABLE
       "EARTH, REVISITED"
         <LTABLE 3
	  "Who am I?"
	  "Ask the game. (Type WHO AM I?)">
	 <LTABLE 3
	  "Where should I go?"
	  "You are reliving the last few minutes before the destruction of the Earth."
	  "But this time as Ford Prefect rather than Arthur Dent."
	  "The Improbability Drive has sent you back in time and has also changed your identity."
	  "You want to do what Ford did when you were Arthur."
	  "Go north to Front of House.">
	 <LTABLE 3
	  "How can I lose my uneasy feeling?"
	  "Have you tried waiting a few turns?"
	  "Obviously, you're doing the wrong thing."
	  "You shouldn't be in the Pub at this point."
	  "See the previous question.">
	 <LTABLE 3
	  "What should I do about Arthur?"
	  "According to the introductory text for this scene, why did you come here?"
	  "What did Ford do at this point when you were Arthur?"
	  "Try to give the towel to Arthur."
	  "The towel is inside your satchel.">
	 <LTABLE 3
	  "What should I do about Prosser?"
	  "Don't go on until you've done the step called for by the previous question."
	  "You want Arthur to come with you to the Pub."
	  "If you recall from when you were Arthur, it would mean the destruction of Arthur's house if he stood up at this point."
	  "He won't stand up until you've safeguarded his house."
	  "You have to talk to Prosser."
	  "But he can't hear you from here."
	  "So you have to APPROACH PROSSER or WALK AROUND THE BULLDOZER. Now you can talk to him."
	  "You want him to lie down in front of the bulldozer."
	  "Try PROSSER, LIE DOWN IN FRONT OF THE BULLDOZER."
	  "Arthur is now willing to follow you to the Pub.">
	 <LTABLE 3
	  "What should I do in the Pub?"
	  "Unless Arthur is with you, you are here prematurely."
	  "Once again, think back to what Ford did when you were Arthur."
	  "The first thing to do is BUY SOME BEER."
	  "Then DRINK THE BEER. Arthur will follow your example. You need to do this twice."
	  "You can BUY SOME PEANUTS, but it isn't necessary to do so."
	  "When Arthur's house is destroyed, he will rush out of the Pub. It would be a good idea to stay with him.">
	 <LTABLE 3
	  "What should I do about the dog?"
          "There's not much you can do about the dog at this point."
	  "You may find out more about the dog later.">
	 <LTABLE 3
	  "What's the point of this scene?"
	  "You learn a lot about Ford's motivations, thus making for a more cohesive, internally consistent story line."
	  "Oh, right. You're more interested in puzzle solutions. The entire point of this scene is acquiring one particular item for use on the Heart of Gold."
	  "It's in the satchel."
	  "It's the satchel fluff."
	  "There's a way to transfer it to something, other than the satchel, so that it will be accessible when you get back to the Heart of Gold."
	  "That something is Arthur Dent."
	  "Give the fluff to Arthur."
	  "This is a rather weird action, and Arthur won't accept the fluff until he's had enough beer."
	  "After Arthur runs back to his house (now rubble), follow him and give him the fluff. He'll accept it at this point and put it in his pocket. Then just wait for events to run their course, and you'll soon find yourself back in Dark. When you get back to the Heart of Gold, the satchel fluff should be in the pocket of your gown.">>
      <PLTABLE
       "WAR CHAMBER/MAZE"
         <LTABLE 3
	  "What's going on in the War Chamber?"
	  "Have you tried listening to the conversation?"
	  "Have you examined the approaching star system?"
	  "Do you remember the long piece of text that appeared when your careless words set off an interstellar war?"
	  "Those two warring races have now set off on a quest for vengeance against the world (Earth) that spawned the person (you) whose remark set off their war.">
	 <LTABLE 3
	  "How can I get the awl?"
	  "Just TAKE AWL!"
	  "Then solve the puzzle involving the giant dog.">
	 <LTABLE 3
	  "How do I not get eaten by the dog?"
	  "The dog really isn't a giant dog."
	  "It's a normal-sized dog. The spaceship you're aboard is microscopic."
	  "Have you seen a dog anywhere else?"
	  "This is the very same dog you ran into in the Country Lane back at the beginning of the game."
	  "The dog swallows the space fleet for one particular reason."
	  "If you examine the dog at the beginning of the game, you'll notice that it's very hungry."
	  "You need to feed the dog back at the beginning of the game."
	  "If you want to avoid starting over from the beginning, there's another way to feed the dog."
	  "You must become Ford Prefect first."
	  "During the scene where you're Ford, buy a sandwich, then give the sandwich to Arthur. When Arthur dashes out of the Pub, he'll feed the sandwich to the dog."
	  "Once the dog has been fed, you can survive the War Chamber scene and go on to the Maze.">
	 <LTABLE 3
	  "Where is this Maze?"
	  "Synapses? Gray Matter?"
	  "Remember you were just teleported over from a microscopic space fleet..."
	  "...so you must be microscopic-sized yourself."
	  "You're inside a brain."
	  "Ah, but whose brain?"
	  "Remember, the Vl'Hurgs and G'Gugvunts were teleporting you back to the Heart of Gold."
	  "You are, improbably enough, inside your own brain!">
	 <LTABLE 3
	  "Can the Maze be mapped?"
	  "No. The Maze is totally unmappable."
          "In fact, the directions in the Maze are totally random, so it makes no difference which direction you move in."
	  "The third time you successfully move to a new Maze room (as opposed to being blocked by a synaptic discharge), you'll run across the black particle."
	  "If you ignore the particle, you'll run across it again later.">
	 <LTABLE 3
	  "What is this black particle for?"
	  "Have you read the markings on the particle?"
	  "The particle is your own common sense!"
	  "You have an opportunity here to remove your own common sense."
	  "Does that ring a bell?"
	  "See the question about no tea in the General Questions section."
	  "Taking the particle also has the beneficial side effect of getting you out of the Maze.">
	 <LTABLE 3
	  "Where did the black particle go?"
	  "Particle physicists have two theories on what happened to the particle."
 	  "The first theory states that the particle is too small to see when you recover from being microscopic."
	  "The second theory states that the particle was destroyed in the electrical impulse that resulted when you reopened the synapse."
	  "Take your pick.">
	 <LTABLE 3
	  "What's the point of this section?"
	  "You should be able to figure it out for yourself."
	  "Do you know the answers to all the other questions in this section?"
	  "There are two goals for the War Chamber/Maze scene."
	  "The first goal is to get the awl."
	  "The second goal is to remove your particle of common sense.">>
      <PLTABLE
       "INSIDE THE WHALE"
         <LTABLE 3
	  "Who am I?"
	  "You're still Arthur in this scene.">
	 <LTABLE 3
	  "Where am I?"
	  "You're inside a sperm whale, obviously."
	  "Note the sound of rushing air."
	  "The Improbability Drive, in one of its nastier coincidences, has transported you inside the very same whale you created when you used the Drive to save the ship during the missile attack."
	  "If you recall, the missiles were turned into a sperm whale, which was last seen plummeting through the atmosphere of Magrathea. This explains why, after a few turns, the whale invariably splats (and you along with it).">
	 <LTABLE 3
	  "How can I get out of the whale?"
	  "There are no exits in any direction."
	  "If you wait long enough, you'll splat and return to Dark."
	  "There's one other way to get out of the whale."
	  "It's a method you've used before."
	  "It will also leave you in Dark."
	  "Hitchhike using the Thumb."
	  "The Thumb is probably broken, though. You'll have to get it fixed by an Engineer robot.">
	 <LTABLE 3
	  "Can I stop the whale from splatting?"
	  "You can't."
	  "No matter what you do, you've only got ten moves in the whale before it splats.">
	 <LTABLE 3
	  "How do I get the pot from the whale?"
	  "There are two ways to do this."
	  "One way involves the Thumb."
	  "The other method involves the thing your aunt gave you which you don't know what it is."
	  "To obtain the flowerpot using the thumb, just pick up the pot and hitchhike."
	  "For more details, see the question on getting out of the whale."
	  "To obtain the flowerpot using the aunt's gift: the aunt's gift has an unusual property you may not have discovered. See the question about the aunt's gift."
	  "Just put the flowerpot inside the aunt's gift and then wait until the whale splats. Within a few turns after leaving Dark, the aunt's gift should reappear, containing the pot.">
	 <LTABLE 3
	  "What's the point of the whale?"
	  "Isn't it obvious?"
	  "There really isn't much here."
	  "The only point of this scene is to get the flowerpot.">>
      <PLTABLE
       "GENERAL QUESTIONS"
	 <LTABLE 3
	  "Is there a significance to \"no tea\"?"
	  "Yes."
	  "It's a hint that at some point, getting tea will be important."
	  "Also, see the question about the screening door in the HEART OF GOLD section.">
	 <LTABLE 3
	  "What is the thing my aunt gave me?"
	  "Have you tried examining it?"
	  "Have you tried getting rid of it?"
	  "You've probably noticed that it keeps turning up."
	  "If you leave it behind, it will pop up about a dozen moves later, sometimes on the ground where you are, sometimes in your inventory, and sometimes in your gown pocket. (The thing will only \"follow\" you when you are Arthur.)"
	  "There's something else that you probably haven't noticed about the thing your aunt gave you."
	  "You can put things in it. In fact, you can put almost every takeable item into the thing at the same time."
	  "This is useful for transporting more objects than you can carry, but it isn't ever necessary to do so."
	  "Because of these two properties (auto-return and containment) the thing your aunt gave you provides an alternate solution of one of the puzzles in the game."
	  "It's a puzzle toward the very end of the game."
	  "It's the puzzle of getting the flowerpot out of the whale.">
	 <LTABLE 3
	  "Is the Hitchhiker's Guide important?"
	  "Well, the game IS named after it..."
	  "The various entries in the Guide contain all sorts of useful information and hints that you'll need to solve the puzzles in the game."
	  "The proper syntax for reading a particular Guide entry is CONSULT GUIDE ABOUT (item). For example, you could type CONSULT GUIDE ABOUT MUSHROOMS."
	  "Once you know the solutions to all the puzzles, you could play to the end of the game without ever using the Guide."
	  "There are 39 Guide entries in the game. A complete list of the topics appears in the MISCELLANEOUS section.">
	 <LTABLE 3
	  "How does the Thumb work?"
	  "The Thumb is an electronic Sub-Etha Auto-Hitching Device. If used properly, it will allow you to hitch rides aboard passing spaceships."
	  "You should read the Guide entry on the Thumb."
	  "You can examine the Thumb to determine whether a spaceship is within range. (If the lights are flashing, a ship is nearby.)"
	  "If a ship is within range, you can transport yourself to the ship (via a matter transference beam) by pushing the green button."
	  "If you press the green button when there is no ship around, you'll break the Thumb."
	  "Also, the Thumb will break down on its own over the course of the game."
	  "If the Thumb is broken, you will not be transported when you press the green button, even if a ship is nearby."
	  "A broken Thumb can be mended."
	  "To do so, push the red button to summon a repair robot. See the following question for further details on repairing the Thumb."
	  "There are three points in the game when you can use the Thumb."
	  "The first is near the beginning of the game, when you use it to get to the Vogon ship."
	  "The second is in the Airlock of the Vogon ship. It isn't necessary to use the Thumb here, because simply waiting a few turns has the same result."
	  "The third is Inside the Sperm Whale. Once again, there's an alternative to using the Thumb, but in this case it's not as simple as just waiting. See the INSIDE THE WHALE section for more information.">
	 <LTABLE 3
	  "How do I fix the thumb?"
	  "You can't. Only the Engineer robot can fix the Thumb."
	  "Once you've summoned the Engineer robot, SHOW (or GIVE) THE THUMB TO THE ENGINEER ROBOT."
	  "If the robot claims that there's nothing wrong with the Thumb, then it wasn't broken."
	  "If the Thumb is broken, the Engineer robot won't agree to fix it unless you also SHOW THE GUARANTEE TO THE ENGINEER ROBOT."
	  "Actually, you can shortcut by showing the guarantee first.">
	 <LTABLE 3
	  "What's this nonsense about fluff?"
	  "There does seem to be a lot of it scattered throughout the game."
	  "Have you consulted the Guide about fluff?"
	  "The ancient legend is of particular interest."
	  "There are a total of four pieces of fluff in the game. You'll have to find and obtain all four."
	  "Try finding them yourself. When you're stumped, return to this question."
	  "Hint: You have four different roles over the course of the game: Arthur, Ford, Trillian, and Zaphod."
	  "You can obtain one piece of fluff during each role."
	  "A list of all four fluff, and their locations, follows. You shouldn't look at this list unless you're completely stumped, because it will give away a lot."
	  "Pocket fluff: in the pocket of your gown at the start of the game. Satchel fluff: inside Ford's satchel (see EARTH, REVISITED). Jacket fluff: on Arthur's jacket (see AT THE PARTY). Seat cushion fluff: under the pilot seat of the speedboat (see ON DAMOGRAN)."
	  "Now that you have all four pieces of fluff, any idea what to do with them?"
	  "Don't continue until you have the flowerpot."
	  "You should plant each piece of fluff in the flowerpot."
	  "Now wait."
	  "A tiny plant will sprout around ten moves later."
	  "For more information, see the next question.">
	 <LTABLE 3
	  "What do I do about the plant?"
	  "Left to itself, the tiny sprout will never grow any further."
	  "You have nothing to water the plant with."
	  "Read the Guide entry on fluff again."
	  "Notice that this rare plant once grew on a tropical world."
	  "Can you think of anything around that's similar to a tropical environment?"
	  "Carry the plant into the sauna."
	  "Now examine the plant."
	  "Now see the question about opening the hatch in the Heart of Gold section.">
	 <LTABLE 3
	  "What are all these tools for?"
	  "Have you examined them?"
	  "Many of them are rather excitingly high-tech, aren't they?"
	  "They don't really have much use..."
	  "...until the very end of the game."
	  "See the question about opening the hatch in the Heart of Gold section."
	  "Marvin will ask for one of ten different tools."
	  "A list of all ten, and their locations, follows. You shouldn't look at this list unless you're completely stumped, because it will give away a lot."
	  "Flathead screwdriver: in your Bedroom. Toothbrush: in your Bedroom. Tweezers: inside Trillian's handbag. Molecular hyperwave pincer: on the Bridge. Ionic diffusion rasp: in the Engine Room. Hypersonic pliers: in the Engine Room. Thermo-fusion chisel: in Marvin's Pantry. Laser-assisted monkey wrench: inside the toolbox on the speedboat. Ultra-plasmic vacuum awl: in the War Chamber. Number twelve asteroid paint chipper: you're holding it when you return from your adventure at the end of the Traal scene.">
	 <LTABLE 3
	  "What is the goal of the game?"
	  "Have you tried asking some of the other characters in the story?"
	  "Have fun, be happy."
	  "Solve all the puzzles, reach the end."
	  "The ultimate goal of the game is to step out onto the surface of Magrathea."
	  "Knowing this fact is of virtually no help in getting through the game.">
	 <LTABLE 3
	  "How can I read the footnotes?"
	  "You obviously didn't read your manual very carefully. That's explained in the section entitled Important Commands.">>
      <PLTABLE
       "MISCELLANEOUS"
         <LTABLE 3
	  "HOW ALL THE POINTS ARE SCORED"
	  "This section should only be used as a last resort, or for your own interest after you've completed the game."
	  "SCORE  ACTION"
	  "   10  Take the buffered analgesic"
	  "    5  Drinking the beer (1st time)"
	  "    5  Drinking the beer (2nd time)"
	  "    5  Drinking the beer (3rd time)"
	  "    8   Arriving at the Vogon Hold"
	  "   12   Getting the babel fish"
	  "   15   Enjoying the Vogon poetry"
	  "   25   Opening the glass case"
	  "   25   Entering the Engine Room"
	  "   25   Getting the Interface"
	  "   15   Drinking the beer (as Ford)"
	  "   25   Leaving the party with Phil"
	  "   25   Stealing the Heart of Gold"
	  "   25   Taking the black particle"
	  "  100   Drinking the tea"
	  "   25   Entering Marvin's Pantry"
	  "   25   Blooming the plant"
	  "   25   Get Marvin to open the hatch"
	  "  400   TOTAL POINTS"
	  "NOTE: You LOSE 30 points each for eating the cheese sandwich, drinking the Advanced Tea Substitute, or turning on the spare Drive while plugged into the large receptacle before the missile attack begins.">
	 <LTABLE 3
	  "FOR YOUR AMUSEMENT"
	  "You shouldn't develop anything in this section until you've finished the game. Things in the section will invariably give away the answers to puzzles in the game."
	  "Have you tried..."
          "looking under your bed?"
	  "enjoying the mud while you're lying in front of the bulldozer?"
	  "to PHONE HOME from your bedroom?"
	  "asking Prosser for the time?"
	  "to GET DRUNK in the pub?"
	  "buying peanuts (as Arthur)?"
	  "listening to the jukebox music (several times, then again when you're Ford)?"
	  "petting or kicking the dog?"
	  "feeding peanuts to the dog? (You can only do this as Ford, of course.)"
	  "hitting Prosser (before and after your house is demolished)?"
	  "enjoying your house after it's been demolished?"
	  "asking PROSSER, WHAT ABOUT MY HOME after it's been demolished?"
	  "giving the towel, the thing your aunt gave you, or the satchel to Prosser? (You can only do the last one when you're Ford, of course.)"
	  "talking to Prosser after the Vogon fleet has arrived?"
	  "eating the cheese sandwich when you're Ford?"
	  "going straight to the Pub when you're Ford, instead of giving Arthur the towel, and then waiting a few turns?"
	  "yelling in the Dark?"
	  "waiting about 60 turns in Dark to see the hints you get?"
	  "not eating the peanuts in the Vogon Hold?"
	  "drinking the Santraginean Mineral Water?"
	  "asking FORD, WHAT ABOUT THE EARTH once it's been destroyed?"
	  "enjoying the Vogon poetry without the babel fish?"
	  "opening the hatch in the Heart of Gold before landing on Magrathea?"
	  "kicking the screening door, then entering Marvin's Pantry?"
	  "closing the screening door once you've opened it?"
	  "reading the tiny message on the circuit board with the magnifying glass?"
	  "smashing the circuit board?"
	  "turning on the spare Drive, plugged into the control panel, before the missile attack begins?"
	  "turning on the spare Drive during the missile attack, without first plugging it into the control panel?"
	  "asking Eddie to open the hatch after the ship has landed?"
	  "not going to the Access Space after asking Marvin to fix the hatch?"
	  "saying something other than your name when the Beast asks for it?"
	  "saying your name with the towel over your eyes?"
	  "to CARVE NAME ON MEMORIAL (rather than CARVE MY NAME ON MEMORIAL)?"
	  "carving one of the names suggested by the previous item?"
	  "carving the Beast's name on the memorial?"
	  "reading the memorial (both before and after carving your name)?"
	  "showing the thing your aunt gave you to the Beast?"
	  "waking the sleeping Beast?"
	  "drinking the wine at the party?"
	  "eating one of the hors d'oeuvres? (Try several times.)"
	  "throwing the glass of wine or the plate of hors d'oeuvres?"
	  "to PICK UP ARTHUR or PICK UP PHIL at the party?"
	  "jumping into the water from the Presidential Speedboat?"
	  "throwing something into the water from the boat?"
	  "shooting the crowd, the guards, Trillian, yourself, the toolbox?"
	  "ordering GUARDS, SHOOT both before and after they've dropped their photon rifles?"
	  "examining the approaching star system and the third planet from the War Chamber of the battle fleet?"
	  "talking to the Vl'Hurg leader or G'Gugvunt leader?"
	  "dropping something in the Maze (your brain) and then walking around once you've gotten out?"
	  "talking to the bulldozer driver, the Vogon Captain, or the hostess?"
	  "closing the thing your aunt gave you?"
	  "wrapping the towel around your head anywhere except Traal?"
	  "typing I AM ARTHUR DENT to the game (as opposed to while talking to a character in the game)?"          
	  "pushing the red button on the Thumb when an Engineer robot is already present?"
	  "counting the hors d'oeuvres, the crowd at the Dais, or the guards (at various points)?"
	  "typing PANIC?  How about DON'T PANIC?"
	  "typing DON'T LOOK or DON'T WAIT or DON'T (anything else)?"
	  "typing GIVE UP or THROW IN THE TOWEL or PULL MYSELF TOGETHER?"
	  "brushing your teeth with the toothbrush?"
	  "typing ESCAPE at any point?"
	  "filling anything?"
	  "returning to various scenes after you've successfully completed them? Examples: returning to Damogran after stealing the Heart of Gold. Returning to Traal after getting the interface."
	  "typing APPLAUD at any point (other than during the poetry reading)?"
	  "answering the game's various rhetorical questions, such as \"Did you have a particular direction in mind?\" or \"Don't you think it would be a bad idea to leave the ceremonies?\", by typing YES or NO?"
	  "typing APPRECIATE [something]?"
	  "asking various characters about the object of the game? (Especially Prosser, Ford, Marvin, Eddie, the Nutrimat, the screening door, and the Beast.)">
	 <LTABLE 3
	  "GUIDE ENTRIES"
	  "Here's a complete list of things that you can CONSULT the Hitchhiker's Guide about. You should use it only as a last resort, or for your interest once you've finished the game."
	  "ALCOHOL"
	  "ATOMIC VECTOR PLOTTER"
	  "BABEL FISH"
	  "BROWNIAN MOTION"
	  "DAMOGRAN"
	  "EARTH"
	  "FLUFF"
	  "FRANCE"
	  "GALACTIC SECURITY AGENCY"
	  "GALAXIA WOONBEAM"
	  "GENUINE PEOPLE PERSONALITIES"
	  "GREEN BUTTON"
	  "HEART OF GOLD"
	  "HITCHHIKER'S GUIDE"
	  "IMPROBABILITY DRIVES"
	  "INFOCOM"
	  "INTELLIGENCE"
	  "LARGE PLUG"
	  "LONG DANGLY BIT"
	  "MAGRATHEA"
	  "MATTER TRANSFERENCE BEAMS"
	  "NUTRIMAT"
	  "PAN-GALACTIC GARGLE BLASTER"
	  "PERIL-SENSITIVE SUNGLASSES"
	  "PROTEIN"
	  "RAVENOUS BUGBLATTER BEAST OF TRAAL"
	  "RED BUTTON"
	  "SANTRAGINEAN MINERAL WATER"
	  "SIRIUS CYBERNETICS CORPORATION"
	  "SMALL PLUG"
	  "SMALL RECEPTACLE"
	  "SPACE"
	  "THUMB"
	  "TOWEL"
	  "VOGON POETRY"
	  "VOGONS"
	  "WALKING"
	  "various tools"
	  "various weapons">
	 <LTABLE 3
	  "FOOTNOTES"
	  "The section tells where each footnote is referenced in the game. Once again, you shouldn't develop this section until you've finished."
	  "FN# HOW TO GET IT"
	  " 1  ENJOY THE DARKNESS in the Dark"
	  " 2  Type FORD, WHAT ABOUT MY HOUSE?"
	  " 3  Upon arrival at the Speedboat"
	  " 4  Listen to the music in the Pub"
	  " 5  Remove the towel (beast asleep)"
	  " 6  Type FOOTNOTE without any number"
	  " 7  Shoot the Beast three times"
	  " 8  Consult the Guide about fluff"
	  " 9  ASK GUIDE ABOUT SPACE in space"
	  "10  Looking in the Engine Room"
	  "11  This footnote is not referenced"
	  "12  This footnote is self referenced"
	  "13  Push the autopilot button thrice"
	  "14  When Ford hands you the Guide"
	  "15  Read the banner at the Dais">>
>>