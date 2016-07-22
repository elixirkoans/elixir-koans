defmodule MapSetsTest do
  use ExUnit.Case
  import TestHarness

  test "MapSets" do
    answers = [
      1,      
      3,
      :ok,
      true,
      {:multiple, [true, false]},
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
