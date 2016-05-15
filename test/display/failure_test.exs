defmodule FailureTests do
  use ExUnit.Case
  alias Display.Failure

  test "assertion failure with proper expression" do
    error = error(%ExUnit.AssertionError{expr: "hi"})

   assert Failure.format_failure(error) == "Assertion failed in some_file.ex:42\n\"hi\"\n"
  end

  test "assertion failure with message" do
    error = error(%ExUnit.AssertionError{expr: :ex_unit_no_meaningful_value, message: "hola"})

   assert Failure.format_failure(error) == "Assertion failed in some_file.ex:42\nhola\n"
  end

  defp error(error) do
    %{
      error: error,
      file: "some_file.ex",
      line:  42
    }
  end
end
