ARG VERSION
FROM elixir:${VERSION}
RUN apk update && apk add -y inotify-tools
WORKDIR /elixir-koans
ADD . /elixir-koans/
RUN mix local.hex --force
CMD ["sh", "-c", "mix deps.get && mix meditate"]
