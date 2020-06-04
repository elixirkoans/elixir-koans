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

  test "equality failure" do
    error = error(%ExUnit.AssertionError{expr: quote(do: :lol == :wat), left: :lol, right: :wat})

    assert Failure.format_failure(error) == """
           Assertion failed in some_file.ex:42
           :lol == :wat

           left:  :lol
           right: :wat
           """
  end

  test "match failure" do
    error = error(%ExUnit.AssertionError{expr: quote(do: match?(:lol, :wat)), right: :wat})

    assert Failure.format_failure(error) == """
           Assertion failed in some_file.ex:42
           match?(:lol, :wat)

           value does not match: :wat
           """
  end

  test "only offending lines are displayed for errors" do
    [koan] = SingleArity.all_koans()
    error = apply(SingleArity, koan, []) |> Tuple.to_list |> List.last |> error

    assert Failure.format_failure(error) == """
           Assertion failed in some_file.ex:42\nmatch?(:foo, ___)
           """
  end

  defp error(error) do
    %{
      error: error,
      file: "some_file.ex",
      line: 42
    }
  end
end
