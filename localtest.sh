#1/bin/bash
# if you want to locally test the service once you cloned the repo use this script
# or your webbrowser. :)
i=1
while [[ "$i" -le 3 ]]; do
rm -f answer randomwords # we remove previous collection of random words and palindromes
/bin/bash -c "$PWD/random.sh" # We invoke random.sh to generate randomwords list

while read line
  do
#    sleep 1;        # we add sleep to prevent DOS-ing our application
    echo "${line}"  # echo a line so we can see what is being sent
    curl -G  http://0.0.0.0:7000 --data-urlencode "${line}" 2>/dev/null >> answer;
  done < $PWD/randomwords  # we pass our generated randomwords file line by line
gawk '/[0-9]+/ { printf "%s\n", $0 }' answer > newanswer; rm answer
# joining our to files to create a report filebeginnibeginningng
pr -m -t randomwords newanswer > report
cat report #reporting an answers in a log
echo "Loop ${i} is finished" # echo the loop value
i=$(($i+1)) # letting loop advance for one
done
