defmodule ControlFlowTests do
  use ExUnit.Case
  import TestHarness

  test "Control Flow" do
    answers = [
      "yes",
      "math works",
      "will execute",
      {:multiple, ["falsy", "falsy", "truthy", "truthy", "truthy"]},
      "matched with x = 2",
      {:multiple, ["positive", "zero", "negative"]},
      {:multiple, ["empty", "one element", "two elements", "many elements"]},
      "warm",
      {:multiple, [{:ok, 5}, {:error, "division by zero"}]},
      {:multiple, ["Success: Hello", "Client error: 404", "Request failed: timeout"]},
      {:multiple,
       ["positive even integer", "positive odd integer", "negative integer", "float", "other"]},
      "verified active user"
    ]

    test_all(ControlFlow, answers)
  end
end
