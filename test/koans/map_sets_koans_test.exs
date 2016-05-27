defmodule MapSetsTest do
  use ExUnit.Case
  import TestHarness

  test "MapSets" do
    answers = [
      {:multiple, [true, false]},
      3,
      true,
      true,
      false, 
      5,
      false,
      true,
      7,
      [1, 2, 3, 4, 5],
    ]

    test_all(MapSets, answers)
  end
end