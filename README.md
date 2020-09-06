# durfdoen-2.0
Durf Doen 2.0

## Setup instructions

1. Install bundler (`gem install bundler`)
2. Install other gems (`bundle install`)
3. Build and serve the site (`bundle exec nanoc live`)

### Setup on windows

This is very flacky, but it might help to 
- Ofcourse only install ruby 2.6
- change `gem 'mini_racer'` to `gem 'mini_racer', platforms: :ruby` in Gemfile
- following this github page https://github.com/eakmotion/therubyracer_for_windows
- Edit this file `C:\Ruby26-x64\lib\ruby\gems\2.6.0\gems\eventmachine-1.2.7-x64-mingw32\lib` by adding `require 'em pure_ruby'` and a newline to the top of the file.
- After all this, on my machine, it still throws an exception, but the live reloading works, until it doesn't (most of the time after a failed compile)


### Optional setup via docker

You can run the code in a separated docker environment. It compiles the code and serves the files via nginx.

    docker build --tag durfdoen2 . && docker run --publish 8080:80 --detach --name dd durfdoen2
