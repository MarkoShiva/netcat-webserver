# Using alpine as minimalistic distribution
FROM alpine
# Adding bash nc and shadow for chsh
RUN apk -U add bash coreutils gawk nmap-ncat # if you want nc add netcat-openbsd here
# Changing a shell for root to /bin/bash
RUN sed -i 's/ash$/bash/' /etc/passwd
# Making directory /app
RUN mkdir /bin/testdata
# Adding needed files to the directory

copy ./myscript.sh ./scriptcorrect ./scripterror \
 ./palindrome.sh badrequestheaders correctheaders specialheaders ncatscript.sh preprocesing.sh /bin/
# setting workdirectory
workdir /bin
# pening up the port
expose 7000
#cmd /bin/bash -c /bin/myscript.sh # use this script if you want netcat-openbsd version instead of ncat
cmd /bin/bash -c /bin/ncatscript.sh
