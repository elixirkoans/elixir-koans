defmodule ProcessesTests do
  use ExUnit.Case
  import TestHarness

  test "Processes" do
    answers = [
      true,
      :running,
      true,
      true,
      {:multiple, [false, true]},
      "hola!",
      true,
      {:multiple, ["hola!", "como se llama?"]},
      :how_are_you?,
      {:multiple, ["O", "HAI"]},
      {:multiple, ["foo", "bar"]},
      {:waited_too_long, "I am impatient"},
      {:exited, :random_reason},
      :normal,
      :normal
    ]

    test_all(Processes, answers)
  end
end
