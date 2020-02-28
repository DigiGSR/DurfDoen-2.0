#!/bin/bash

bundle exec nanoc

scp -rP 2222 output/ durfdoen@157.193.231.142:/home/durfdoen/public
