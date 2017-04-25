defmodule OptionTest do
  use ExUnit.Case, async: true

  test "can target specifc koans" do
    Options.start(["--koan=Strings"])
    assert Options.initial_koan() == Strings
  end
end
