FROM ruby:2.5.3

LABEL maintainer="pedro.fausto@hotmail.com"

ARG NODE_VERSION=10.24.1

RUN sed -i \
      -e 's|deb.debian.org/debian|archive.debian.org/debian|g' \
      -e 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' \
      -e '/stretch-updates/d' /etc/apt/sources.list \
    && apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get install -y --allow-unauthenticated --no-install-recommends \
      build-essential \
      curl \
      git \
      imagemagick \
      libmagickwand-dev \
      libpq-dev \
    && curl -fsSLO "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" \
    && tar -xJf "node-v${NODE_VERSION}-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
    && rm "node-v${NODE_VERSION}-linux-x64.tar.xz" \
    && npm install --global yarn@1.22.19 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.3.9 \
    && bundle install --jobs=2

COPY package.json ./
RUN yarn install --ignore-engines

COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000", "-e", "development"]
