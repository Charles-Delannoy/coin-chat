FROM ruby:2.6.6-alpine

RUN apk update && apk add build-base nodejs postgresql-dev

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v 2.2.16

RUN bundle install --binstubs

RUN mkdir tmp
RUN mkdir tmp/pids

COPY . .
CMD puma -C config/puma.rb
