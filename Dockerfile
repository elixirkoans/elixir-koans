FROM elixir:1.5
RUN apt-get update && apt-get install -y inotify-tools
WORKDIR /elixir-koans
ADD . /elixir-koans/
RUN mix local.hex --force
CMD ["bash", "docker-meditate.sh"]
