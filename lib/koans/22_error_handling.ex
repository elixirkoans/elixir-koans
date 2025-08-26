defmodule ErrorHandling do
  @moduledoc false
  use Koans

  @intro "Error Handling - Dealing gracefully with things that go wrong"

  koan "Result tuples are a common pattern for success and failure" do
    parse_number = fn string ->
      case Integer.parse(string) do
        {number, ""} -> {:ok, number}
        _ -> {:error, :invalid_format}
      end
    end

    assert parse_number.("123") == ___
    assert parse_number.("abc") == ___
  end

  koan "Pattern matching makes error handling elegant" do
    divide = fn x, y ->
      case y do
        0 -> {:error, :division_by_zero}
        _ -> {:ok, x / y}
      end
    end

    result =
      case divide.(10, 2) do
        {:ok, value} -> "Result: #{value}"
        {:error, reason} -> "Error: #{reason}"
      end

    assert result == ___
  end

  koan "Try-rescue catches runtime exceptions" do
    result =
      try do
        10 / 0
      rescue
        ArithmeticError -> "Cannot divide by zero!"
      end

    assert result == ___
  end

  koan "Try-rescue can catch specific exception types" do
    safe_list_access = fn list, index ->
      try do
        {:ok, Enum.at(list, index)}
      rescue
        FunctionClauseError -> {:error, :invalid_argument}
        e in Protocol.UndefinedError -> {:error, "#{e.value} is not a list"}
      end
    end

    assert safe_list_access.([1, 2, 3], 1) == ___
    assert safe_list_access.([1, 2, 3], "a") == ___
    assert safe_list_access.("abc", 0) == ___
  end

  koan "Multiple rescue clauses handle different exceptions" do
    risky_operation = fn input ->
      try do
        case input do
          "divide" -> 10 / 0
          "access" -> Map.fetch!(%{}, :missing_key)
          "convert" -> String.to_integer("not_a_number")
          _ -> {:ok, "success"}
        end
      rescue
        ArithmeticError -> {:error, :arithmetic}
        KeyError -> {:error, :missing_key}
        ArgumentError -> {:error, :invalid_argument}
      end
    end

    assert risky_operation.("divide") == ___
    assert risky_operation.("access") == ___
    assert risky_operation.("convert") == ___
    assert risky_operation.("safe") == ___
  end

  koan "Try-catch handles thrown values" do
    result =
      try do
        throw(:early_return)
        "this won't be reached"
      catch
        :early_return -> "caught thrown value"
      end

    assert result == ___
  end

  koan "After clause always executes for cleanup" do
    cleanup_called =
      try do
        raise "something went wrong"
      rescue
        RuntimeError -> :returned_value
      after
        IO.puts("Executed but not returned")
      end

    assert cleanup_called == ___
  end

  koan "After executes even when there's no error" do
    {result, value} =
      try do
        {:success, "it worked"}
      after
        IO.puts("Executed but not returned")
      end

    assert result == ___
    assert value == ___
  end

  defmodule CustomError do
    defexception message: "something custom went wrong"
  end

  koan "Custom exceptions can be defined and raised" do
    result =
      try do
        raise CustomError, message: "custom failure"
      rescue
        e in CustomError -> "caught custom error: #{e.message}"
      end

    assert result == ___
  end

  koan "Bang functions raise exceptions on failure" do
    result =
      try do
        Map.fetch!(%{a: 1}, :b)
      rescue
        KeyError -> "key not found"
      end

    assert result == ___
  end

  koan "Exit signals can be caught and handled" do
    result =
      try do
        exit(:normal)
      catch
        :exit, :normal -> "caught normal exit"
      end

    assert result == ___
  end

  koan "Multiple clauses can handle different error patterns" do
    handle_database_operation = fn operation ->
      try do
        case operation do
          :connection_error -> raise "connection failed"
          :timeout -> exit(:timeout)
          :invalid_query -> throw(:bad_query)
          :success -> {:ok, "data retrieved"}
        end
      rescue
        e in RuntimeError -> {:error, {:exception, e.message}}
      catch
        :exit, :timeout -> {:error, :timeout}
        :bad_query -> {:error, :invalid_query}
      end
    end

    assert handle_database_operation.(:connection_error) == ___
    assert handle_database_operation.(:timeout) == ___
    assert handle_database_operation.(:invalid_query) == ___
    assert handle_database_operation.(:success) == ___
  end

  koan "Error information can be preserved and enriched" do
    enriched_error = fn ->
      try do
        String.to_integer("not a number")
      rescue
        e in ArgumentError ->
          {:error,
           %{
             type: :conversion_error,
             original: e,
             context: "user input processing",
             message: "Failed to convert string to integer"
           }}
      end
    end

    {:error, error_info} = enriched_error.()
    assert error_info.type == ___
    assert error_info.context == ___
  end
end
