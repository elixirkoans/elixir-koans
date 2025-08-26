defmodule WithStatementTests do
  use ExUnit.Case
  import TestHarness

  test "With Statement" do
    answers = [
      {:multiple, [9, {:error, :invalid_number}]},
      {:multiple, [{:ok, "Adult user: Alice"}, {:error, :underage}, {:error, :missing_data}]},
      {:multiple, [{:ok 2}, {:error, :division_by_zero}, {:error, :negative_sqrt}]}
    ]

    test_all(WithStatement, answers)
  end
end
