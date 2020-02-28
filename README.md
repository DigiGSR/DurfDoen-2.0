# durfdoen-2.0
Durf Doen 2.0

## Setup instructions

1. Install Ruby, preferably the version specified in `.ruby-version`
2. Install bundler (`gem install bundler`)
3. Install other dependencies (`bundle install`)
4. Build and serve the site (`bundle exec nanoc live`)

To build the artefacts for production: `bundle exec nanoc`

### Setup on windows

This is very flaky, but it might help to
- Of course only install Ruby 2.6
- Change `gem 'mini_racer'` to `gem 'mini_racer', platforms: :ruby` in Gemfile
- Follow this GitHub page https://github.com/eakmotion/therubyracer_for_windows
- Edit this file `C:\Ruby26-x64\lib\ruby\gems\2.6.0\gems\eventmachine-1.2.7-x64-mingw32\lib`, adding `require 'em pure_ruby'` and a newline to the top of the file
- After all this, on my machine, it still throws an exception, but the live reloading works, until it doesn't (most of the time after a failed compile)

### Optional setup via Docker

You can run the code in a separated Docker environment. It compiles the code and serves the files via nginx.

    docker build --tag durfdoen2 . && docker run --publish 8080:80 --detach --name dd durfdoen2
