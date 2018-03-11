*********************
Christian Cornelis
S/N: 0939357
CIS*4500 Assignment 1
January 26th, 2018
**********************


BUILDING PROJECT:
*****************

Please run my app using an iPhone 8 Plus in Portrait orientation. My app is designed to run only on this model, and in this orientation.

NOTES:
******

-If a user does not enter anything in the upper text box, an error message will be outputted in the lower text box.

-Smart Quotations were DISABLED on the input field in order to ease filtering them out. If Smart Quotations is ON, then quotations WILL NOT be filtered out.

-The field that outputs all calculations/error messages is not modifiable by the user intentionally.

-If a user does not complete a sentence (end it with a period, semicolon, colon, exclamation point, or question mark), an error message will be output stating that the user must input a valid sentence.

-If a user inputs a valid sentence(s), the Flesch index, number of sentences, number of words, and number of syllables will be outputted.


SPECIAL CASE HANDLING:
**********************

-If a user inputs a number or symbols that were not specified in the assignment specification, they will be ignored. This means that if a user inputs a sentence that is only comprised of digits, for example, "1234.", it will be parsed as a valid sentence that is comprised of zero words.

-If the first character of the user input is a sentence-delimitting character (colon, semicolon, period, exclamation point, or question mark), it WILL NOT count as a sentence.
For example, the input: ".Hello there!" would only count as ONE sentence.