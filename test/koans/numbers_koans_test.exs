defmodule NumbersTests do
  use ExUnit.Case
  import TestHarness

  test "Numbers" do
    answers = [
      true,
      true,
      [5, 8, 1, 2, 7],
      1234,
      '7',
      "1234",
      42,
      35.0,
      34.3,
      99.0,
      12.34,
      {34.5, ""},
      {1.0, " million dollars"},
      {:multiple, [6.0, 5.0, 8.94, -5.567]},
    ]

    test_all(Numbers, answers)
  end
end