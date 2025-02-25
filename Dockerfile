FROM ruby:3.0

# yarnインストール時のバージョンを指定
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# パッケージリスト更新後、railsとDBに必要なパッケージインストール
RUN apt-get update && apt-get install -y nodejs postgresql-client yarn

# /usr/src/appを作業ディレクトリとし、Gemfile Gemfile.lockをコピーする
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./

# コピーしたGemfile Gemfile.lockに書いてあるGemをinstallする
RUN bundle install

# railsのアプリを含め、すべてのファイルをコピー
COPY . ./