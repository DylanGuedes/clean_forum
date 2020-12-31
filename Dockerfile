FROM ruby:2.3.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client nodejs \
        qt4-dev-tools libqt4-dev libqt4-core libqt4-gui libqtwebkit-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
