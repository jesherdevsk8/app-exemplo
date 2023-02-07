FROM debian:latest

ENV TZ=America/Sao_Paulo
ENV APP_PATH /app-exemplo
ENV BUNDLER_VERSION=2.4.5

RUN apt-get update -qq && apt-get upgrade -y && \
  apt-get install -y \
  build-essential \
  libpq-dev \
  libghc-qrencode-prof \
  nodejs \
  npm \
  yarn \
  zlib1g-dev \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

ADD vendor/dependencies/ /opt/
RUN tar zxvf /opt/openssl-1.1.1s.tar.gz && \
  cd openssl-1.1.1s && \
  ./config && \
  make && \
  make test && \
  make install
RUN tar zxvf /opt/ruby-2.7.2.tar.gz && \
  cd ruby-2.7.2 && \
  ./configure && \
  make && \
  make install

RUN gem install bundler -v $BUNDLER_VERSION

WORKDIR $APP_PATH
COPY . .

COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install
RUN npm install --global yarn && yarn install --check-files

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]

CMD ["rails", "server", "-b", "0.0.0.0"]
