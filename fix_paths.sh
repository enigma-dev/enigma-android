#!/bin/bash

cat ${1}/cxxflags.in | sed "s#-I\([^/A-Z]\|[A-Z][^:]\|[A-Z]:[^/\\]\)#-I${2}/\1#g" > ${1}/build.cxxflags
cat ${1}/cflags.in | sed "s#-I\([^/A-Z]\|[A-Z][^:]\|[A-Z]:[^/\\]\)#-I${2}/\1#g" > ${1}/build.cflags

for m in $(cat ${1}/makefiles.in); do echo "include ${3}/android/external/${m}" >> ${1}/build.makefiles_; done
mv ${1}/build.makefiles_ ${1}/build.makefiles

for s in $(cat ${1}/sources.in); do echo ${s} | sed "s#\\(^[^/]\\)#${2}/\\1#g" >> ${1}/sources_.list; done
cat  ${1}/sources_.list | xargs echo > ${1}/sources.list
rm ${1}/sources_.list