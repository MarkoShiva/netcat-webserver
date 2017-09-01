#!/bin/bash

	string=$* #reciving all characters of the input I think
						# I might need to escape double quotes as they exist in some palindrom examples

# Striping all non alnum characters and changing uppercase to lowercase for tests
checking="$(echo $string| sed -E 's/[^[:alnum:]]//g' | tr '[:upper:]' '[:lower:]')"


len=${#checking}  # calculating a length of the striped string $checking which contains only alnum.
middle=$((len/2)) # calculating middle value of the length if number is odd it will be floor rounded
#echo "vlaue of len is $len"
#echo "vlaue of middle is $middle"

pcheck(){  # definition of main function
status=1   # declaring status to something different then 0 or 1
for ((i=1;i<=middle;i++))  # running the loop middle times if its odd and all other characters pass
													 # string is palindrome as the center letter is same from both sides
do
	ch1=`echo $checking| cut -c$i`     # cut one character from the $i value of checking string
																		 # it do not really cuts it just assign a value of nth character
																		 # from the beginning to the ch1
	ch2=`echo $checking| cut -c$len`	 # cut one character from the len valuel of the string
																		 # assign one character from the end of the string to ch2

	if [[ $ch1 != $ch2 ]] 						 # compare characters of they are not equal echo 400 and exit
	then
		status=2
    echo 400
    break 2													 # break from 2 levels of loop because no further checking is needed
  else
	  let len--												 # lower the size of a string because we nnow want to compare next pair
		 																 # of letters
    status=0						 						 # set status to 0 I can put it outside of else it do not matter
																	   # on this way is only set each time the characters pass the comparation
																		 # it is better logic then doing it in for loop and wait for a if then to throw
																		 # status=2 it is the same functionality only this is better process for me
  fi
done
if [[ status -eq 0 ]]								 # check if the exit status after function is finished a 0
then
  echo 200													 # echo 200 in that case
fi
}
pcheck $checking										 # call our well defined function
