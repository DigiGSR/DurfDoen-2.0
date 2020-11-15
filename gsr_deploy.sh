#!/bin/bash

bundle exec nanoc

rsync -crtvu --delete output/ "durfdoen@gsr:/home/durfdoen/website/"
