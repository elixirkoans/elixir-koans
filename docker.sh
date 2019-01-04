#!/bin/sh
docker build -t elixir-koans . && docker run --rm -v `pwd`:/elixir-koans -ti elixir-koans
