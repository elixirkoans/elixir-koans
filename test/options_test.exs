defmodule OptionTest do
  use ExUnit.Case, async: true

  test "has default options" do
    Options.parse([])
    refute Options.clear_screen?
  end

  test "override clearing of screen" do
    Options.parse(["--clear-screen"])
    assert Options.clear_screen?
  end

  test "ignores unknown options" do
    options = Options.parse(["--foo"])
    refute Options.clear_screen?
  end
end
