FROM ruby:2.6.1
    RUN apt-get update && \
        apt-get install -y mysql-client nodejs --no-install-recommends && \
        rm -rf /var/lib/apt/lists/*

    RUN mkdir /t-farm

    WORKDIR /t-farm

    ADD Gemfile /t-farm/Gemfile
    ADD Gemfile.lock /t-farm/Gemfile.lock

    RUN gem install bundler
    RUN bundle install

    ADD . /t-farm