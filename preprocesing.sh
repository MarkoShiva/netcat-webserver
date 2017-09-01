#!/bin/bash
export REQUEST=
while read -r line
do
  line=$(echo "$line" | tr -d '\r\n')
#      echo "original line $line"
  if echo "$line" | grep -qE '^GET /' # if line starts with "GET /"
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
      if  echo "$REQUEST" | grep -iE "bats|stab|cave"
      then
        echo -e $(cat specialheaders)           # read the specialheaders if you like comic books



      elif [[ `./palindrome.sh $REQUEST` == 200 ]] # pass stripped and cleared REQUEST to palindrome.sh for evaluation if it echo 200
      then
          echo -e $(cat correctheaders)          # echo -e correctheaders which will echo HTTP1.1 header
      else
          echo -e $(cat badrequestheaders)       # echo -e badrequestheaders which will echo HTTP1.1 header 400
                                                 # correctly formated
      fi

  fi
done
