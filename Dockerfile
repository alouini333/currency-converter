FROM ruby:2.7.1

WORKDIR /code
COPY . /code
RUN gem install bundler:1.17.2
RUN bundle install

EXPOSE 4567

CMD ["sh", "run.sh"]