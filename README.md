# Elixir Koans

[![Build Status](https://travis-ci.org/elixirkoans/elixir-koans.svg?branch=master)](https://travis-ci.org/elixirkoans/elixir-koans)

Elixir koans is a fun way to get started with the elixir programming language. It is a tour
of the most important features and idiomatic usage of the language.

### Prerequisites

You need to have Elixir installed. Please refer to the [official guide](http://elixir-lang.org/install.html) for instructions.

First, clone the repo from GitHub:

```sh
$ git clone https://github.com/elixirkoans/elixir-koans.git
$ cd elixir-koans/
```

Next, fetch mix dependencies by running:

```sh
$ mix deps.get
```

You might get prompted to install further dependencies. Reply "y".

On Linux, you'll need to install `inotify-tools` to be able
to use the autorunner in this project.

### Running

With the dependencies installed, navigate to the root directory of this project and run:

```sh
$ mix meditate
```

You should see the first failure. Open the corresponding file in your favourite text editor
and fill in the blanks to make the koans pass one by one.
The autorunner will give you feedback each time you save.


If you want the autorunner to show you your previous results, run it with `--no-clear-screen`
```sh
$ mix meditate --no-clear-screen
```

If you want to jump to a specific lesson, run it with `--koan=<koan name>`
```sh
$ mix meditate --koan=PatternMatching
```

Any typos on the koan name will show the complete list of koans, where you can pick any.


### Contributing

We welcome contributions! If something does not make sense along the way or you feel
like an important lesson is missing from the koans, feel free to fork the project
and open a pull request.

List of [contributors](CONTRIBUTORS.md).
