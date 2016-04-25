# Elixir Koans

[![Build Status](https://travis-ci.org/elixirkoans/elixir-koans.svg?branch=master)](https://travis-ci.org/elixirkoans/elixir-koans)

Elixir koans is a fun, easy way to get started with the elixir programming language. It is a tour
of the most important features and idiomatic usage of the language.

### Prerequisites

To install Elixir, please refer to the [official guide](http://elixir-lang.org/install.html) for instructions.

To fetch mix dependencies, run:
```sh
$ mix deps.get
```

On Linux, you'll need to install `inotify-tools` if you already haven't to be able
to use the autorunner in this project.

### Running

With the dependencies installed, just navigate to the root directory of this project and run:
```sh
$ mix meditate
```
to get going. You should see the first failure with a blank line in it. The goal is
to fill in the blanks and make all the koans pass by doing so.

To make the autorunner less noisy, you can start the koans with
```sh
$ mix meditate --clear-screen
```

### Contributing

We welcome contributions! If something does not make sense along the way or you feel
like an important lesson is missing from the koans, feel free to fork the project
and open a pull request.
