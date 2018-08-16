FROM alpine
MAINTAINER krlsdu <krlsdu@gmail.com>

RUN apk add --no-cache \
elixir \
inotify-tools \
tmux \
vim

COPY . elixir-koans 

WORKDIR elixir-koans

RUN mix local.hex --force && \
mix deps.get

RUN chmod +x elixir-koans.sh

CMD [ "./elixir-koans.sh" ]