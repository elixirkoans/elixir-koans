defmodule EnumTests do
  use ExUnit.Case
  import TestHarness

  test "Enums" do
    answers = [
      3,
      3,
      1,
      {:multiple, [2, ArgumentError]},
      {:multiple, [true, false]},
      {:multiple, [true, false]},
      {:multiple, [true, false]},
      [10, 20, 30],
      [1, 3],
      [2],
      [1, 2, 3],
      [1, 2, 3, 4, 5],
      [1, 2, 3],
      [a: 1, b: 2, c: 3],
      2,
      nil,
      :no_such_element,
      6,
      {:multiple, [[[1, 2], [3, 4], [5, 6]], [[1, 2, 3], [4, 5]]]},
      [1, 10, 2, 20, 3, 30],
      {:multiple, [["apple", "apricot"], ["banana", "blueberry"]]},
      [4, 8, 12]
    ]

    test_all(Enums, answers)
  end
end
