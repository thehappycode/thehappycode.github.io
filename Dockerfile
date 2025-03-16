# "#################################################"
FROM ubuntu:24.04

# "#################################################"
# "Get the latest APT packages"
RUN apt-get update

# "#################################################"
# "Install Ruby and other prerequisites
RUN apt-get -y install \
    git \
    ruby-full \
    build-essential \
    zlib1g-dev


# "#################################################"
# "Configuration the gem installation PATH
RUN echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
RUN echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
RUN echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
RUN bash -c "source ~/.bashrc"

# "#################################################"
# "Install Jekyll and Bundler
RUN gem install jekyll bundler

# "#################################################"
# "Tạo WORKDIR
WORKDIR /app

# COPY source code vào /app trong container
COPY . /app

# Bundle install các dependencies
RUN bundler install

# Mở port 4000
EXPOSE 4000

# Chạy Jekyll khi khởi động container
CMD ["bundle", "exec", "jekyll", "serve", "--livereload", "--host", "0.0.0.0"]

