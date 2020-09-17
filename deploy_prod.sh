#!/bin/bash

bundle exec nanoc

rsync -crtvu --delete -e "ssh -p2222" output/ "durfdoen@student4.ugent.be:/sd/data/durfdoen/"
