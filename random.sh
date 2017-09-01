#!/bin/bash
rm -f randomwords # remove previous collection
i=0
while [[ i -le 36 ]]; do

shuf -n 1 palindromes >> randomwords # This append one random line in randomwords
shuf -n 1 dictionary >> randomwords # This append one dictionary word to randomwords
i=$(($i + 1))
done
