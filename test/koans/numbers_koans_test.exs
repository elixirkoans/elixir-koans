defmodule NumbersTests do
  use ExUnit.Case
  import TestHarness

  test "Numbers" do
    answers = [
      true,
      false,
      1.0,
      2,
      1,
      4,
      4.0,
      false,
      5,
      true,
      true,
      [5, 8, 1, 2, 7],
      1234,
      "1234",
      42,
      " years",
      {:multiple, [1, ".2"]},
      34.5,
      1.5,
      35.0,
      34.3,
      99.0,
      12.34,
      {:multiple, [6.0, 5.0, 8.9, -5.567]},
      {:multiple, [1, 10]},
      {:multiple, [true, true, false]},
      {:multiple, [true, false]}
    ]

    test_all(Numbers, answers)
  end
end
