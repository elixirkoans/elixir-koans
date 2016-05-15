defmodule Display.Failure do
  alias Display.Paint

  @no_value :ex_unit_no_meaningful_value

  def format_failure(%{error: %ExUnit.AssertionError{expr: @no_value, message: message}, file: file, line: line}) do
    """
    #{Paint.cyan("Assertion failed in #{file}:#{line}")}
    #{Paint.red(message)}
    """
  end
  def format_failure(%{error: %ExUnit.AssertionError{expr: expr}, file: file, line: line}) do
    format_assertion_error(expr, file, line)
  end
  def format_failure(%{error: error, file: file, line: line}) do
    """
    #{Paint.cyan("Error in #{file}:#{line}")}
    #{format_error(error)}
    """
  end

  defp format_assertion_error(error, file, line) do
    """
    #{Paint.cyan("Assertion failed in #{file}:#{line}")}
    #{Paint.red(Macro.to_string(error))}
    """
  end

  defp format_error(error) do
    trace = System.stacktrace |> Enum.take(2)
    Paint.red(Exception.format(:error, error, trace))
  end

  def show_compile_error(error) do
    format_error(error)
  end
end
