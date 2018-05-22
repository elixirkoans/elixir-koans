defmodule RunnerTest do
  use ExUnit.Case, async: true

  test "path to number" do
    path = "lib/koans/01_just_an_example.ex"
    assert Runner.path_to_number(path) == 1
  end
end
