#!/bin/sh
VERSION=1.7
docker build --build-arg VERSION=${VERSION} -t elixir-koans . && docker run --rm -v `pwd`:/elixir-koans -ti elixir-koans
