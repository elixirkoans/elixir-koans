#!/bin/sh -e

docker build -t elixir-koans .
docker run --rm -v `pwd`/lib/koans:/elixir-koans/lib/koans -ti elixir-koans
