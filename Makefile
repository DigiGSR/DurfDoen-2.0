.PHONY: live build setup

live:
	bundle exec nanoc live

build:
	bundle exec nanoc

setup:
	which bundle || { { gem install bundler && which bundle; } || echo 'Could not find `bundle`.'" Make sure the directory with the Ruby's gem executables is in your PATH. (Typically ~/.gem/ruby/*/bin)" && false; }
	bundle install
