FROM ruby:2.5

EXPOSE 3000

RUN apt-get update \
&& apt-get install -y nodejs sqlite3 imagemagick --no-install-recommends \
&& rm -rf /var/lib/apt/lists/*\
&& echo "Asia/Tokyo" > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install -j4

COPY . /usr/src/app
CMD bundle exec rails s
# RUN rake assets:precompile
# CMD bundle exec unicorn -c config/unicorn.rb
