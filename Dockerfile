FROM ubuntu:18.04

# install ubuntu packages
RUN apt-get update -q \
 && apt-get install -y \
    git \
    curl \
    locales \
    build-essential \
    autoconf \
    libncurses5-dev \
    libwxgtk3.0-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libpng-dev \
    libssh-dev \
    unixodbc-dev \
 && apt-get clean

# install asdf and its plugins
# ASDF will only correctly install plugins into the home directory as of 0.6.2
# so .... Just go with it.
ENV ASDF_ROOT /root/.asdf
ENV PATH "${ASDF_ROOT}/bin:${ASDF_ROOT}/shims:$PATH"
RUN git clone https://github.com/asdf-vm/asdf.git ${ASDF_ROOT} --branch v0.6.2  \
 && asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang \
 && asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir \
 && asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs \
 && ${ASDF_ROOT}/plugins/nodejs/bin/import-release-team-keyring

# set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
# install erlang
ENV ERLANG_VERSION 21.2.2
RUN asdf install erlang ${ERLANG_VERSION} \
 && asdf global erlang ${ERLANG_VERSION}

# install elixir
ENV ELIXIR_VERSION 1.7.4
RUN asdf install elixir ${ELIXIR_VERSION} \
 && asdf global elixir ${ELIXIR_VERSION}

# install local Elixir hex and rebar
RUN mix local.hex --force \
 && mix local.rebar --force

# install nodejs
ENV NODEJS_VERSION 10.8.0
RUN asdf install nodejs ${NODEJS_VERSION} \
 && asdf global nodejs ${NODEJS_VERSION}
