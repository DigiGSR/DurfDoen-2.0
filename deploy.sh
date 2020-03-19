#!/bin/bash

bundle exec nanoc

date="`date --iso-8601=seconds`"

scp -rP 2222 output/ "durfdoen@157.193.231.142:/home/durfdoen/builds/$date" &&
ssh durfdoen@157.193.231.142 -p 2222 "rm /home/durfdoen/public && ln -s builds/$date /home/durfdoen/public"
