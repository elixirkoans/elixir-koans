defmodule ErrorHandlingTests do
  use ExUnit.Case
  import TestHarness

  test "Error Handling" do
    answers = [
      {:multiple, [{:ok, 123}, {:error, :invalid_format}]},
      "Result: 5.0",
      "Cannot divide by zero!",
      {:multiple, [{:ok, 2}, {:error, :invalid_argument}, {:error, "abc is not a list"}]},
      {:multiple,
       [
         {:error, :arithmetic},
         {:error, :missing_key},
         {:error, :invalid_argument},
         {:ok, "success"}
       ]},
      "caught thrown value",
      :returned_value,
      {:multiple, [:success, "it worked"]},
      "caught custom error: custom failure",
      "key not found",
      "caught normal exit",
      {:multiple,
       [
         {:error, {:exception, "connection failed"}},
         {:error, :timeout},
         {:error, :invalid_query},
         {:ok, "data retrieved"}
       ]},
      {:multiple, [:conversion_error, "user input processing"]}
    ]

    test_all(ErrorHandling, answers)
  end
end
