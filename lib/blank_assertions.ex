defmodule BlankAssertions do
  defmacro assert(expr) do
    if contains_blank?(expr) do
      code = Macro.escape(expr)
      quote do
        raise ExUnit.AssertionError, expr: unquote(code)
      end
    else
      quote do
        ExUnit.Assertions.assert(unquote(expr))
      end
    end
  end

  defmacro refute(expr) do
    if contains_blank?(expr) do
      code = Macro.escape(expr)
      quote do
        raise ExUnit.AssertionError, expr: unquote(code)
      end
    else
      quote do
        ExUnit.Assertions.refute(unquote(expr))
      end
    end
  end

  defmacro assert_receive(expr) do
    code = Macro.escape(expr)
    if contains_blank?(expr) do
      quote do
        raise ExUnit.AssertionError, expr: {:assert_receive, [], [unquote(code)]}
      end
    else
      quote do
        ExUnit.Assertions.assert_receive(var!(expr), 100)
      end
    end
  end

  def assert(value, opts) do
    ExUnit.Assertions.assert(value, opts)
  end

  def refute(value, opts) do
    ExUnit.Assertions.refute(value, opts)
  end

  def flunk(message \\ "Flunked!") do
    ExUnit.Assertions.flunk(message)
  end

  defp contains_blank?(expr) do
    Blanks.count(expr) > 0
  end
end
