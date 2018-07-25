FROM elixir:latest
MAINTAINER Michael Clifford <cliffom@gmail.com>

RUN apt-get update
RUN apt-get install -y tmux git inotify-tools vim
RUN git clone https://github.com/elixirkoans/elixir-koans.git /app
RUN cd /app && \
  mix local.hex --force && \
  mix deps.get
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

WORKDIR /app
CMD /root/entrypoint.sh
