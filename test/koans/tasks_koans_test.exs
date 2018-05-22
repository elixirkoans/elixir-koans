defmodule TasksTests do
  use ExUnit.Case
  import TestHarness

  test "Tasks" do
    answers = [
      10,
      :ok,
      nil,
      false,
      9,
      [1, 4, 9, 16]
    ]

    test_all(Tasks, answers)
  end
end
