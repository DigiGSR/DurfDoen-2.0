# durfdoen-2.0
Durf Doen 2.0

## Setup instructions

1. Install bundler (`gem install bundler`)
2. Install other gems (`bundle install`)
3. Build and serve the site (`bundle exec nanoc live`)

### Optional setup via docker

You can run the code in a separated docker environment. It compiles the code and serves the files via nginx.

    docker build --tag durfdoen2 . && docker run --publish 8080:80 --detach --name dd durfdoen2
