defmodule ComprehensionsTests do
  use ExUnit.Case
  import TestHarness

  test "Comprehensions" do
    answers = [
      [1, 4, 9, 16],
      [1, 4, 9, 16],
      ["Hello World", "Apple Pie"],
      ["2 dogs", "2 cats", "4 dogs", "4 cats"],
      [4, 5, 6],
      ["Apple Pie", "Pecan Pie", "Pumpkin Pie"],
    ]

    test_all(Comprehensions, answers)
  end

end
