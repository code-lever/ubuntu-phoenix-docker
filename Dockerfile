FROM ubuntu:18.04

# install ubuntu packages
RUN apt-get update -q
RUN apt-get install -y \
    git \
    curl \
    locales \
    build-essential \
    autoconf \
    m4 \
    libncurses5-dev \
    libwxgtk3.0-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libpng-dev \
    libssh-dev \
    unixodbc-dev
RUN apt-get clean

# install asdf
ENV ASDF_ROOT /asdf
RUN git clone https://github.com/asdf-vm/asdf.git ${ASDF_ROOT} --branch v0.4.3
ENV PATH "${ASDF_ROOT}/bin:${ASDF_ROOT}/shims:$PATH"

# install asdf plugins
RUN asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang
RUN asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir
RUN asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs

# install NodeJS team signatures
RUN ${ASDF_ROOT}/plugins/nodejs/bin/import-release-team-keyring

# set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# install erlang
ENV ERLANG_VERSION 20.3.5
RUN asdf install erlang ${ERLANG_VERSION} && \
    asdf global erlang ${ERLANG_VERSION}

# install elixir
ENV ELIXIR_VERSION 1.6.5
RUN asdf install elixir ${ELIXIR_VERSION} && \
    asdf global elixir ${ELIXIR_VERSION}

# install local Elixir hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# install nodejs
ENV NODEJS_VERSION 8.11.1
RUN asdf install nodejs ${NODEJS_VERSION} && \
    asdf global nodejs ${NODEJS_VERSION}
