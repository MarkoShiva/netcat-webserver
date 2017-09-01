#!/bin/bash
rm -f /tmp/out
mkfifo /tmp/out
trap "rm -f /tmp/out" EXIT
while true
do
  cat /tmp/out | nc -l -k -p 7000 > >( # parse the netcat output, to build the answer redirected to the pipe "out".
    export REQUEST=
#    while true;
#    do
    while read -r line
    do
      line=$(echo "$line" | tr -d '\r\n')
#      echo "original line $line"
      if echo "$line" | grep -qE '^GET /' # if line starts with "GET /"
      then
        REQUEST=$(echo "$line" | cut -d ' ' -f2) # extract the request
#        echo "original request $REQUEST" #this was only for debugging
      elif echo "$line" | grep -qE '^HEAD /' # if line starts with "GET /"
      then
        REQUEST=$(echo "$line" | cut -d ' ' -f2) # extract the request
#        echo "original request $REQUEST" #this was only for debugging
      elif [[ "${line}" ==  "" ]] # empty line / end of request
      then
        REQUEST=$(echo "$REQUEST" | sed 's/\///') # remove beginning /
        REQUEST=$(echo "$REQUEST" | sed 's/^?//') # remove ? from beginning of encoded msg
        #decode encoded url with awk
        REQUEST=$(echo "$REQUEST" | gawk -niord '{printf RT?$0chr("0x"substr(RT,2)):$0}' RS=%..)
#        echo "line after striping $line" #this was only for debugging
        echo "request after striping $REQUEST" #this was only for debugging
        # check for palindrome.sh output if it returns 200 call scriptcorrect if not call scripterror
        # both are just scripted headers for 200 and 400
        if [[ `./palindrome.sh $REQUEST` == 200 ]] # pass stripped and cleared REQUEST to palindrome.sh
                                                   # for evaluation if it echo 200
        then
            ./scriptcorrect > /tmp/out             # run scriptcorrect which abeginningre wraped headers for
                                                   # http answer and answer itself send it to fifo file
        else
            ./scripterror > /tmp/out               # if answer is not 200 answer with scripterror
        fi
#        ./palindrome.sh $REQUEST | tee > out
      fi
    done
#done
  )
done
