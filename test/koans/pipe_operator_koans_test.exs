defmodule PipeOperatorTests do
  use ExUnit.Case
  import TestHarness

  test "Pipe Operator" do
    answers = [
      "HELLO-WORLD",
      "hello_world",
      [6, 8, 10],
      "hello, world",
      20,
      "1-2-3",
      ["Alice", "Charlie"],
      ["QUICK", "BROWN", "JUMPS"],
      [a: 2, b: 4, c: 6],
      {:multiple, [{:ok, 84}, {:error, :invalid_number}]},
      {:multiple, [["HELLO", "WORLD"], ["hello", "world"]]},
      250,
      12,
      {:multiple, [2, 2, 1]},
      5,
      {:multiple, ["Result: 5.0", "Error: division_by_zero"]}
    ]

    test_all(PipeOperator, answers)
  end
end
