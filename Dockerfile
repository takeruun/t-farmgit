FROM ruby:2.6.1
    RUN apt-get update && \
        apt-get install -y mysql-client nodejs --no-install-recommends vim curl && \
        apt-get update && apt-get install -y yarn && \
        rm -rf /var/lib/apt/lists/*

    RUN mkdir /t-farm
    
    WORKDIR /t-farm

    ADD Gemfile /t-farm/Gemfile
    ADD Gemfile.lock /t-farm/Gemfile.lock

    RUN gem install bundler
    RUN bundle install

    ADD . /t-farm

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

    CMD ["bundle", "exec", "puma", "-C", "config/puma.rb", "-e", "${RAILS_ENV}"]