defmodule IntegerTests do
  use ExUnit.Case
  import TestHarness

  test "Integers" do
    answers = [
      true,
      true,
      [5, 8, 1, 2, 7],
      1234,
      '7',
      "1234",
    ]

    test_all(Integers, answers)
  end
end
