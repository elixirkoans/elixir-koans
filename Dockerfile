ARG VERSION
FROM elixir:${VERSION}
RUN apt-get update && apt-get install -y inotify-tools
WORKDIR /elixir-koans
ADD . /elixir-koans/
RUN mix local.hex --force
RUN mix deps.get
CMD mix meditate
