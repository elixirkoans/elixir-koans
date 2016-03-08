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

  test "ignores unknown options" do
    Options.start(["--foo"])
    refute Options.clear_screen?
  end
end
