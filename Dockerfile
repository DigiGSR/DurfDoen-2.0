# ------- Build -------
FROM ruby:2.7.1-alpine3.11 AS build

RUN apk add build-base

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle config set deployment 'true'
RUN bundle config set without 'development'
RUN bundle install

COPY content content/
COPY layouts layouts/
COPY lib lib/
COPY Guardfile .
COPY Rules .
COPY nanoc.yaml .

RUN bundle exec nanoc



# ------- Release -------
FROM nginx:latest AS release

RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/output /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]
