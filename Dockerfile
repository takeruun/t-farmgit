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

    RUN mkdir -p tmp/sockets

    # Expose volumes to frontend
    VOLUME /t-farm/public
    VOLUME /t-farm/tmp

    ARG RAILS_MASTER_KEY

    ENV RAILS_ENV production
    ENV RAILS_MASTER_KEY $RAILS_MASTER_KEY

    # Add a script to be executed every time the container starts.
    COPY entrypoint.sh /usr/bin/
    RUN chmod +x /usr/bin/entrypoint.sh
    ENTRYPOINT ["entrypoint.sh"]

    EXPOSE 3000

    RUN RAILS_ENV=production bundle exec rails assets:precompile
    #CMD ["bundle", "exec", "rails", "s", "puma", "-b", "0.0.0.0", "-p", "3000", "-e", "${RAILS_ENV}"]
    CMD ["bundle", "exec", "puma", "-C", "config/puma.rb", "-e", "production"]