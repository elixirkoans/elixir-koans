ARG VERSION
FROM elixir:${VERSION}
RUN apt-get update && apt-get install -y inotify-tools
WORKDIR /elixir-koans
ADD . /elixir-koans/
RUN mix local.hex --force
CMD ["bash", "-c", "mix deps.get && mix meditate"]
