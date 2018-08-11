FROM elixir:latest
MAINTAINER krlsdu <krlsdu@gmail.com>

RUN apt-get update
RUN apt-get install -y tmux git inotify-tools vim
COPY . elixir-koans 
RUN cd elixir-koans && \
  mix local.hex --force && \
  mix deps.get
COPY elixir-koans.sh /bin/elixir-koans.sh
RUN chmod +x /bin/elixir-koans.sh

WORKDIR elixir-koans
CMD [ "elixir-koans.sh" ]