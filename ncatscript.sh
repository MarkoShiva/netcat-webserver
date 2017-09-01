#!/bin/bash
while true  # Finaly found ncat package on the Alpine this shoudl work faster and better
do
 ncat -l -k -p 7000 -c './preprocesing.sh; echo $*'

done
