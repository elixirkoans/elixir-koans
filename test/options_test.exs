defmodule OptionTest do
  use ExUnit.Case, async: true

  test "has default options" do
    options = Options.parse([])
    refute Map.fetch!(options, :clear_screen)
  end

  test "override clearing of screen" do
    options = Options.parse(["--clear-screen"])
    assert Map.fetch!(options, :clear_screen)
  end

  test "ignores unknown options" do
    options = Options.parse(["--foo"])
    refute Map.fetch!(options, :clear_screen)
  end
end
