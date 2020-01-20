FROM ruby:2.6.1
    RUN apt-get update && \
        apt-get install -y mysql-client nodejs --no-install-recommends vim && \
        rm -rf /var/lib/apt/lists/*

    RUN mkdir /t-farm
    
    WORKDIR /t-farm
    
    ARG RAILS_ENV
    ENV RAILS_ENV ${RAILS_ENV}

    ADD Gemfile /t-farm/Gemfile
    ADD Gemfile.lock /t-farm/Gemfile.lock

    RUN gem install bundler
    RUN bundle install

    ADD . /t-farm

    # Add a script to be executed every time the container starts.
    COPY entrypoint.sh /usr/bin/
    RUN chmod +x /usr/bin/entrypoint.sh
    ENTRYPOINT ["entrypoint.sh"]

    EXPOSE 3000

    RUN if ["${RAILS_ENV}" = "production"]; then bundle exec rails assets:precompile; else export RAILS_ENV=development; fi
    CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]