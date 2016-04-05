defmodule OptionTest do
  use ExUnit.Case, async: true

  test "has default options" do
    Options.start([])
    refute Options.clear_screen?
  end

  test "override clearing of screen" do
    Options.start(["--clear-screen"])
    assert Options.clear_screen?
  end

  test "can target specifc koans" do
    Options.start(["--koan=Strings"])
    assert Options.initial_koan() == Strings
  end

  test "ignores unknown options" do
    Options.start(["--foo"])
    refute Options.clear_screen?
  end
end
