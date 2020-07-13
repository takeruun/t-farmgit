FROM ruby:2.6.5-alpine3.10

RUN apk add --update-cache --no-cache tzdata libxml2-dev curl-dev \
    make gcc libc-dev g++ linux-headers \
    mysql-dev mysql-client nodejs git

RUN mkdir /t-farm

WORKDIR /t-farm

ADD Gemfile /t-farm/Gemfile
ADD Gemfile.lock /t-farm/Gemfile.lock

RUN gem install bundler && \
    bundle install && \
    apk update

ADD . /t-farm

RUN rm -rf /usr/local/bundle/cache/* /workdir/vendor/bundle/cache/*

RUN mkdir -p tmp/sockets

VOLUME /t-farm/public
VOLUME /t-farm/tmp

ARG RAILS_ENV
ARG RAILS_MASTER_KEY

ENV RAILS_ENV $RAILS_ENV
ENV RAILS_MASTER_KEY $RAILS_MASTER_KEY

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

RUN if [ "${RAILS_ENV}" = "production" ]; then bundle exec rails assets:precompile assets:clean; else export RAILS_ENV=development; fi

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]