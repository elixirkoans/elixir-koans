defmodule ProcessesTests do
  use ExUnit.Case
  import TestHarness

  test "Processes" do
    answers = [
      true,
      :running,
      true,
      true,
      "hola!",
      :how_are_you?,
      {:waited_too_long, "I am impatient"},
      false,
      {:multiple, [true, false]},
      {:exited, :random_reason},
      true,
      false,
      :normal,
      :normal,
      ]

    test_all(Processes, answers)
  end
end
