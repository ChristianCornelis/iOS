# iOS


Assignment 1 - XCode and a Simple Application
----------------------------------------------
> Due Friday, January 26, 2018
> Graded out of 10%
> 
> Write an application that reads a text string which is entered by the user.
> Then calculate the Flesch index for the string and print the results to
> the screen.
> 
> Write an application using Xcode. Do not create a Playground.
> 
> 
> The Flesch Index
> ----------------
> The following index (Rudolf Flesch, How to Write Plain English, Barnes & Noble
> Books, 1979) was invented by Flesch as a simple tool to guage the legibility
> of a document without linguistic analysis.
> 
> 1. Count all words in the file. A word is any sequence of characters delimited
> by white space, whether or not it is an actual English word.
> 
> 2. Count all syllables in each word. To make this simple, use the following
> rules: Each group of adjacent vowels (a,e,i,o,u,y) counts as one syllable
> (for example, the "ea" in "real" contributes one syllable, but the "e..a"
> in "regal" count as two syllables). However, an "e" at the end of a word
>  doesn't count as a syllable. Also each word has at least one syllable, even
>  if the previous rules give a count of 0.
> 
> 3. Count all sentences. A sentence is ended by a period, colon, semicolon,
> question mark, or exclamation mark. Multiples of these characters should be
> treated as the end of a single sentence. For example "Fred said so..." is
> a single sentence.
> 
> 4. The index is computed by:
>    Index = 206.835 - 84.6 * (# syllables/# words) - 1.015 * (# words/# sentences)
> rounded to the nearest integer.
> 
> This index is a number, usually between 0 and 100, indicating how difficult the text is to read. Some examples for random material for various publications are:
> 
> Comics	95
> Consumer Ads	82
> Sports Illustrated	65
> Time	57
> New York Times	39
> Auto insurance policy	10
> Internal Revenue Code	-6
> 
> 
> The purpose of the index is to force authors to rewrite their text until the
> index is high enough. This is achieved by reducing the length of sentences
> and by removing long words. For example, the sentence: 
> 
>   The following index was invented by Flesch as a simple tool to estimate the
>   legibility of a document without linguistic analysis. 
> 
> can be rewritten as: 
> 
> Flesch invented and index to check whether a document is easy to read. To
> compute the index, you need not look at the meaning of the words. 
> 
>   Ignore any numbers entered as input. If multiple punctuation marks occur
>   then ignore all of them after the first until a non-punctuation mark occurs.
> 
> 
> Input
> -----
> 
> You are to write a program that reads text from an input window 
> and computes the legibility index. There should be a button labeled "Calculate"
> which tells the system to read the current input string and then calculate the
> output.
> 
> Your program should display:
> 
> 1. the legibility index you have computed
> 2. the count of syllables in the input
> 3. the count of words in the input
> 4. the count of sentences in the input
> 
> in a format such as:
> 
> Legibility Index  = 87
> Syllable Count    = 10238
> Word count        = 2032
> Sentence count    = 193
>
> Develop the program for IOS using Swift.
>
> Include a readme.txt file which contains your name, student number, and a brief description of anything
> does not work as expected.


Assignment 2 - Data Structures, Files, Text I/O
--------------------------------------------------------
Due Friday, February 9, 2018
Graded out of 20%

There are two options for this assignment. You only need to write
one of the programs described, either A or B.

Plan A - Write an application that allows the user to read an interactive
story. The reader must navigate through menu options to progress through
the story.

Plan B - Write an application that creates a map from a text file and allows
the user to interactively navigate the rooms and hallways it contains.

Write an the program using Swift using Xcode. Do not create a Playground.

Plan A - Interactive Story
-------------------------------
The program will need to read a text file that contains the story, the
menu options, and the inventory options. The user should be provided
with a numbered menu which allows them to select the option in the
story. The user should only enter the number of menu item they wish to
pursue.

Locations in the Story:
Each location in the story is stored in the input file.

The Inventory:
The user can carry items they find while moving through the
story. The user should be able to see the items carried by pressing
the i key.
Inventory items are automatically added to the inventory when the user
enters the area where the item is located. The user does not need to
perform any action to pick up an inventory item.
Items in the inventory are described as a String. The inventory must
be stored in a data structure which contains a collection of these strings.
Write functions to add and replace items in the inventory.
The inventory cannot contain multiple copies of the same item and there
cannot be duplicates. If an item is transformed into something else then
the user can pick up the original item again as it is no longer in
the inventory. For example, if the user has a cup and they fill it
with water and transform it into "cup of water" then they could pick
up the cup again if they find it in another location.

Input File:
There is a single input file for a story. The file describes:
-each location described as a text string
-a label for each location in <> brackets, e.g. <A>, <B>
-one or more links between locations
-inventory objects as a text string
-actions that can happen if the user has an inventory item
with them

Areas are listed in the input file. The user starts in the first area
listed in the file. Your program should display the description of the
first area when the user starts the story.
All strings in the input file are surrounded by double quotes.

The format for each area in the story is:
<TAG> "Description String"
1. "Description String for option 1" <move to location TAG>
2. "Description String for option 2" <move to location TAG>
...

Any number of options can appear after the <TAG> line.
Description Strings can appear on any number of lines. They are enclosed
with double quotes.
The <move to location TAG> identifies where the user can navigate to
given their current location. The location where they will move to is
listed after the description as a <TAG>. It must match a <TAG> in some other
part of the input file.

For example:
<A> "You are in a round room with a sink and a doorway North."
1. "Go North" <B>

In this example the user is in location <A> and has one choice. When they
select option 1 they will move to location <B>, the description and
options for location <B> will then be displayed.
they will

If there is an inventory item in the room then the it should automatically
be added to the inventory list. Inventory items are listed after the
room description and before the navigation options. The inventory items
have the format:

-inventory "Inventory item description string" item1, item2, ...

-inventory :a keyword, there will only be one -inventory entry per area
"item description string" :print this string so the user knows what items are there
item1, item2 :comma separated list of inventory items, they are strings and can contain spaces

For example:
<A> "You are in a round room with doorway North."
-inventory "You see a key and a cup on the ground which you pick up." "key", "cup"
1. "Go North" <B>

In this example when the user enters the room they would see the following:
You are in a round room with doorway North.
You see a key and a cup on the ground which you pick up.
1. Go North

The key and cup strings would be added to the inventory data structure.
Users should not see the message about inventory items if they already
have those items in their inventory. In the above example if the
inventory data structure contains the key and cup strings then the message
about picking them up should not be printed. If the user does not have
all of the inventory items listed in the room then print the message
and add the inventory items to the list which are not currently on the list.

Inventory items can be used for two purposes. They can be transformed into
other items and they can be used to allow entry to areas of the story.

If an inventory item is transformed then the string describing it is
replaced with a different string in the inventory data structure. 
For instance, if the user has the cup item and they enter a room with a sink
then the cup would be transformed into "cup of water".
After the room description you use the -if tag to indicate a transformation.
For example:

<A> "You are in a round room with a sink and a doorway North."
-if "cup" "cup of water" "You fill the cup with water at the sink."
1. "Go North" <B>

When the user enters the room and the cup is in the inventory then
then "cup" is replaced in the inventory with "cup of water" and the
message is printed out after the room description. In the above example
the user would see:

You are in a round room with a sink and a doorway North.
You fill the cup with water at the sink.
1. Go North

You could find an inventory item in a room that can transform them.
In this case add the item to the inventory first and then perform the
transformation. More than one transformation can appear in an area. When
this happens there will be multiple -if tags.

<A> "You are in a round room with a sink and a doorway North."
-inventory "You see a key and a cup on the ground which you pick up." "key", "cup"
-if "cup" "cup of water" "You fill the cup with water at the sink."
1. "Go North" <B>

In the above example the user would see:
You are in a round room with a sink and a doorway North.
You see a key and a cup on the ground which you pick up.
You fill the cup with water at the sink.
1. Go North

Inventory items can be used to access areas in the story. The user must
have the item listed in their inventory to navigate to an area. If the
item is not present then they receive a message stating they did not move
and their location is not updated.

To use an inventory item for access to a new area the keywords -if, else, and go are
used after a movement option. For example:

<B> "You are in a square room with a door North and a path East."
1. "Follow the path to the East." <C>
2. "Go through the door to the North."
-if "key" go <D> else "The door is locked. It looks like you need a key."
3. "Go South." <A>

When the user enters the room they will see:
You are in a square room with a door North and a path East.
1. Follow the path to the East.
2. Go through the door to the North.
3. Go South.

In this example if the user does not have the key in their inventory
and they select option 2 they will see the message:
The door is locked. It looks like you need a key.
If they have the key in their inventory they will move to location <D>.

The final area in the story should have two options. To exit the
story or to reset it and start again. This is indicated using the -end
tag in the input file.

<D> "You have reached the end"
-end

The user would see:
You have reached the end.
1. Start again.
2. Exit.

Each area in the story will have the following sections:
-Area tag and description.
-Optional inventory item(s).
-Optional inventory item transformations.
-One or more movement options with optional inventory item requirements.

Implement each area as an object and the inventory as an object.
Write appropriate routines to navigate the story by moving between
the areas. Write methods to print out the messages for the objects and
to perform the inventory management, transformations, and when using
an item to move to an area.


Plan B - Navigate a Maze
-------------------------------
Read a ASCII text maps from a file. Allow the user to interactively
move through the rooms and hallways it contains. Only show the rooms
which the user has entered and the hallways they have travelled through.
They should not automatically see the entire map when they start a level.

The file can contain the following characters:
. a space in a room that the player can move through
\# a space in a hallway that the player can move through
@ the player
d a little dog
V stairs down
A stairs up
Any other character in the file is a wall and cannot be passed through.
The player can only move through areas that have the . # A V characters
in them. They cannot move through an area containing any other character.

There can be multiple maps in the file which are traveled through
using the V and A locations. Each map can have one V and one A. The
user always starts on the stairs up A location. When they reach the stairs
down V location they will move to the next map in the sequence. If they
move onto the stairs up location after being off of it then they move
to the previous level. The V and A are not required in each level
but there should be a stairs up A in the first level to provide a
starting location for the player.

The map should be displayed on the top of the screen.
Below the map the user should see eight direction buttons that
allow them to move around the map. You should include a reset
button which moves back to the first map in the sequence.

The file containing the maps lists each map in sequence. Each level
can have a different size. The number of rows and columns for each level
listed before each level. For example:

10x10
XXXXXXXXXX
X........X
X..V.....X
X........X
X........X
X........X
X........X
X.....A..X
X........X
XXXXXXXXXX
12x12
XXXXXXXXXX  
X........X  
X........X  
XXXXX#XXXX  
     #      
     #      
   XX#XXXX  
   X.A...X  
   X.....X  
   XXXXXXX 



The above file contains two levels of different sizes. The user would
start in the first level on the A character. They would move to the second
map by stepping on the V character. They could move back to the first
level by moving back onto the A character.

Every location defined by the size of the map must be occupied in
the file. So a 10x10 map must contain 10 characters in each row and there
must be 10 rows. The rows may need to be padded with blank spaces.

There can be any number of levels in the input file.

Store the maps in a data structure. You will likely need another
data structure to store the areas which the user has visited.

After the user pushes a button indicating the direction they wish to
move you will need to use the map to determine if the user can enter
the location they have selected. If the location cannot be entered then
the user character @ should stay in its current location.

Animate the little dog d by making it move randomly around the map.
The dog cannot change levels by using the stairs. Each level will have
its own dog. The user cannot move into the location which contains the dog.

When the user moves their character @ should move around the map. 
It should be possible to draw the  entire map on the screen at one time.

It is probably a good idea to use a fixed size (non-proportional) font.

NOTES
----------
Provide a readme.txt which contains your name, students number, and a
description of anything that doesn't work correctly in your program.

Bundle your submission and submit it thought Dropbox on Courselink.
Test your bundle before you submit it to make sure that you have
included all of the files necessary to run the program.


Assignment 3 - SceneKit, Scene Graphs 
-------------------------------------
Due Friday, March 2, 2018
Graded out of 20%

Use the scene graph generator in the SceneKit module to create 3D images.
Use spirograph equations to draw multiple objects in spiral patterns.
The program should read the parameters from a text file.

Write an the program using Swift using Xcode. Do not create a Playground.

The lecture notes on Scene Graphs contain the formula and pseudo code
to draw the spirals and sample outputs. The lecture notes and a sample
scene graph file are on the Courselink site.

Read the parameters from a text file located in the same directory as the
ViewController.swift file. The format for the file is:

k, l, R

where each parameter is separated by a comma. For example:

0.7, 0.2, 3.0

means that k=0.7, l=0.2, and R=3.0. There is nothing in the file other
than the three parameters and two commas.

Iterate over the spiral formula 10000 times. Each iteration will create
a new object so the program will create 10000 objects. Increment the t
parameter by 0.06282 for each object.

You can place a small object at the origin to direct the camera if
you wish. You can change the default colours and object types if you
wish. 


References
----------
A tutorial that explains how to use the SceneKit is available at:
	https://code.tutsplus.com/tutorials/an-introduction-to-scenekit-fundamentals--cms-23847
This tutorial uses some older SceneKit options.  An updated ViewController.swift
is on the courselink site which should run with Swift 4.

There are many other SceneKit tutorials on the web. A few links are:
https://www.invasivecode.com/weblog/scenekit-tutorial-part-1/
https://www.raywenderlich.com/83748/beginning-scene-kit-tutorial
https://www.weheartswift.com/introduction-scenekit-part-1/

https://developer.apple.com/documentation


NOTES
-----
Provide a readme which contains your name, students number, and a
description of anything that doesn't work correctly in your program.

Bundle your submission and submit it thought Dropbox on Courselink.
Test your bundle before you submit it to make sure that you have
included all of the files necessary to run the program.
