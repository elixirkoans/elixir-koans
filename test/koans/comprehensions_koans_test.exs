defmodule ComprehensionsTests do
  use ExUnit.Case
  import TestHarness

  test "Comprehensions" do
    answers = [
      [1, 4, 9, 16],
      [1, 4, 9, 16],
      ["Hello World", "Apple Pie"],
      ["little dogs", "little cats", "big dogs", "big cats"],
      [4, 5, 6],
      %{"Pecan" => "Pecan Pie", "Pumpkin" => "Pumpkin Pie"}
    ]

    test_all(Comprehensions, answers)
  end

end
