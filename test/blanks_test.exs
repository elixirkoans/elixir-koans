defmodule BlanksTest do
  use ExUnit.Case, async: true

  test "simple replacement" do
    ast = quote do: 1 + ___

    assert Blanks.replace(ast, 37) == quote(do: 1 + 37)
  end

  test "Work with multiple different replacements" do
    [koan | _] = SampleKoan.all_koans()
    assert :ok == apply(SampleKoan, koan, [{:multiple, [3, 4]}])
  end

  test "complex example" do
    ast = quote do: assert(true == ___)

    assert Blanks.replace(ast, true) == quote(do: assert(true == true))
  end

  test "multiple arguments" do
    ast = quote do: assert(___ == ___)

    assert Blanks.replace(ast, [true, false]) == quote(do: assert(true == false))
  end

  test "pins variables in assert_receive replacement" do
    ast = quote do: assert_receive(___)

    assert Blanks.replace(ast, Macro.var(:answer, __MODULE__)) ==
             quote(do: assert_receive(^answer))
  end

  test "does not pin values in assert_receive replacement" do
    ast = quote do: assert_receive(___)
    assert Blanks.replace(ast, :lolwat) == quote(do: assert_receive(:lolwat))
  end

  test "counts simple blanks" do
    ast = quote do: 1 + ___

    assert Blanks.count(ast) == 1
  end

  test "counts multiple blanks" do
    ast = quote do: assert(___ == ___)

    assert Blanks.count(ast) == 2
  end

  test "replaces whole line containing blank" do
    ast =
      quote do
        1 + 2
        2 + ___
      end

    expected_result =
      quote do
        1 + 2
        true
      end

    actual_result = Blanks.replace_line(ast, fn _ -> true end)

    assert actual_result == expected_result
  end

  test "replacement fn can access line" do
    ast =
      quote do
        1 + 2
        2 + ___
      end

    expected_result =
      quote do
        1 + 2
        some_fun(2 + ___)
      end

    actual_result =
      Blanks.replace_line(ast, fn line ->
        quote do: some_fun(unquote(line))
      end)

    assert actual_result == expected_result
  end
end
