FROM ruby:2.7.0
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
	&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
	&& apt-get update -qq \
	&& apt-get install -y nodejs yarn \
	&& mkdir /blog_tutorial
WORKDIR /blog_tutorial
COPY Gemfile /blog_tutorial/Gemfile
COPY Gemfile.lock /blog_tutorial/Gemfile.lock
RUN bundle install
COPY . /blog_tutorial

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
