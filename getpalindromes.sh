#!/bin/bash

curl -G http://www.derf.net/palindromes/old.palindrome.html 2>/dev/null | egrep -A 500 'NAME="STANDARD"' | egrep "<li>" | sed 's/<li>//' | sed 's/^[ \t]*//' > palindromes
# Found very useful list of palindromes on http://www.derf.net/palindromes/old.palindrome.html decided to write function that parse it
# I will now use this list for using random lines from palindromes file for checking
# Also I will use some english dict list for checking of regular words.
curl -G https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt > dictionary
# I will use https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt as the dictionary list
# I might run a function that check that dictionary for palindromes and removes them for it for now I'll just generate random number and check phrase on that line
