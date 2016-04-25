defmodule BlanksTest do
  use ExUnit.Case, async: true

  test "simple replacement" do
    ast = quote do: 1 + ___

    mangled = Blanks.replace(ast, 37)
    assert {:+, [context: BlanksTest, import: Kernel], [1, 37]} == mangled
  end

  test "Work with multiple different replacements" do
    [koan | _] = SampleKoan.all_koans
    assert :ok == apply(SampleKoan, koan, [{:multiple, [3,4]}])
  end

  test "complex example" do
    ast = [do: {:assert, [line: 5], [{:==, [line: 5], [true, {:___, [], __MODULE__}]}]}]

    assert [do: {:assert, [line: 5], [{:==, [line: 5], [true, true]}]}] == Blanks.replace(ast, true)
  end

  test "multiple arguments" do
    ast = [do: {:assert, [line: 5], [{:==, [line: 5], [{:___, [], __MODULE__}, {:___, [], __MODULE__}]}]}]

    assert [do: {:assert, [line: 5], [{:==, [line: 5], [true, false]}]}] == Blanks.replace(ast, [true, false])
  end

  test "counts simple blanks" do
    ast = quote do: 1 + ___

    assert Blanks.count(ast) == 1
  end

  test "counts multiple blanks" do
    ast = [do: {:assert, [line: 5], [{:==, [line: 5], [{:___, [], __MODULE__}, {:___, __MODULE__}]}]}]

    assert Blanks.count(ast) == 2
  end

  test "replaces whole line containing blank" do
    ast = quote do
      1 + 2
      2 + ___
    end

    expected_result = quote do
      1 + 2
      true
    end

    actual_result = Blanks.replace_line(ast, fn(_) -> true end)

    assert actual_result == expected_result
  end

  test "replacement fn can access line" do
    ast = quote do
      1 + 2
      2 + ___
    end

    expected_result = quote do
      1 + 2
      some_fun(2 + ___)
    end

    actual_result = Blanks.replace_line(ast, fn(line) ->
      quote do: some_fun(unquote(line))
    end)

    assert actual_result == expected_result
  end
end
