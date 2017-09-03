# netcat webserver
Code for a small web server written in bash that use nc without -c or -e option based on alpine linux and meant to be run inside of the docker swarm with suplementary testservice that will check whether it works properly
bashserver currently evaluates input of get requests sent via curl or your favorite web browser that consist oof palindrome string or non palindrome string and send proper answers: 200 if the string is palindrome and 400 if it is not.
There is a compose file with my basic knowledge of docker there is postgresql included in it if someone need logs for some scripts. Btw there is a small easter egg for comic book lovers and geeks in code. :)

## TODO
I probably should break it down in few packages one which is
a basic example of doing it netcat-openbsd way. And other with actual ncat. But in anyway this repository is not important as it was project specific so I will not do it except if someone ask for making this full blown nc server.
I mean there are already implementations of it and this is not meant to act as a webserver whcih I could implement also to be HTTP1.1 compliant but I don't have time for that nor wish to do it.

#### Few comments about usage
testservice in this version run 3 loops each of 3 replicated services toward any of the 3 bashservers
loops consist of around 80 phrases randomly generated at runtime from 460 multi word with special characters
palindromes and 100k english dictionary I use `shuf -n 1 filename` so there is no overhead on generating list.
testservice also generate reports which consist of tab separated value of the string tested and result returned
They can at the moment be accessed via `docker service logs myapp_testservice`
Also the logs of what is recived by the bashserver can be accessed via `docker service logs myapp_bashserver` myapp here is just a name that you give to a stack when you deploy it via command `docker stack deploy -c docker-compose.yml nameTHatYouWantToGiveToTheStack` in my case name was myapp.

## Guide for usage
1. clone a repo
2. install docker and docker-compose and docker-machine if needed
3. start docker swarm with command `docker swarm init --advertise-addr address`
4. run `docker stack deploy -c docker-compose myapp` to deploy a stack then you can access the app via stackaddress:7000 
5. wait for services to deploy then run the command `curl -G http://address:7000 --data-urlencode "query"` will be checked whether is a palindrome. You can add any other script and add aditional headers if you want this was just a test of writing nc webserver that run in docker-swarm mode and understand HTTP in few days. :) It is GPLv3 repo as everything else I do exept for contracts. :)

## DONE
- [x] Made bash script as a wrapper around netcat
- [x] Run successful tests o f a container
- [x] Run successful deployment on local swarm with laptop and 2 VM's
- [x] Made a .drone.yml file that builds images from a Dockerfiles in the repo
- [x] Run successful tests on my drone server
- [x] Services are deployed properly on my machine in swarm mode
- [x] They update properly too from drone.
- [x] All tests passes and bashserver is queried properly from testservice with expected results
- [x] downloaded around 500 palindrome phrases
- [x] downloaded english dictionary of around 100k words
- [x] using shuf for generating random test lists
.
