*********************
Christian Cornelis
S/N: 0939357
CIS*4500 Assignment 2
February 11th, 2018
**********************


BUILDING PROJECT:
*****************

Please run my app using an iPhone 8 Plus in Portrait orientation. My app is designed to run only on this model, and in this orientation.

NOTE:
*****
-The app is laid out specifically so that the keyboard has room to be open and still view all necessary UI components.

INPUT FILE NOTES:
*****************
-Input file MUST be called "input.txt"
-All input file structures MUST adhere to those exemplified in the SampleStory textfile on CourseLink
-If an option has a condition, it must be of the form "-if <ITEM> go <ROOM TO GO TO> else <MESSAGE TO OUTPUT>"
	-The ">" in the room to go to is used to split the line and MUST be present

INVENTORY:
**********
-To access the inventory, the user MUST press the i key (works if capitalized as well)
-TO EXIT the inventory, the user must press the I or i
-Once the user reaches the end, the inventory is reset only when the user chooses to either restart the story or exit the app, 
 meaning they can view what items they ended the story with

USER INPUT:
***********
-The user must input their selected choice in the textfield beneath the textview containing the state of the story.
-Input will immediately be read in and the text field will be cleared immediately
-If the user enters invalid input (ie. An option number not listed or not the letter I or i), the state of the story will stay the same and nothing will happen,

RESETTING THE STORY:
********************
-The story can be reset by hitting the 'Reset' button in the middle of the screen, or by reaching the end of the story and choosing to start again.
-If the user completes the story and exits, the story will be completely reset if they re-open the app.

SPECIAL CASE HANDLING:
**********************
-If the user picks an item up and transforms it, and the user picks up the pre-transformed item again, it WILL NOT be transformed a second time
-If the user enters a room which adds multiple items to the inventory and the user has already been here:
1. The message saying the user picked up all items in the room will be displayed if the user doesn't have ONE OR MORE of the items already in their inventory
2. ONLY the items that are not currently in their inventory (ie. the ones that have been transformed since they were last in the room) will be re-added to their inventory.

-If the user picks up an item that can be transformed, but have the transformed item in their inventory already, the item WILL NOT be transformed a second time.

REFERENCES:
***********

https://stackoverflow.com/questions/27880650/swift-extract-regex-matches
-Used this reference to gain an understanding of how to effectively implement a function in Swift 4 that could extract regex matches.
-Also used it to gain an understanding of how I could create a function that could check if a regex found any matches in a string.
