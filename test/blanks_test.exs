defmodule BlanksTest do
  use ExUnit.Case, async: true

  test "simple replacement" do
    ast = quote do: 1 + :__

    mangled = Blanks.replace(ast, 37)
    assert {:+, [context: BlanksTest, import: Kernel], [1, 37]} == mangled
  end

  test "Work with multiple different replacements" do
    [koan | _] = SampleKoan.all_koans
    assert :ok == apply(SampleKoan, koan, [{:multiple, [3,4]}])
  end

  def complex_example do
    [head | tail] = [1,2,3,4]

    assert head == 1
    assert tail == [2,3,4]
  end

  def foo(answer) do
    if answer == :yes do
      :bar
    else
      :batz
    end
  end

  test "complex example" do
    ast = [do: {:assert, [line: 5], [{:==, [line: 5], [true, :__]}]}]

    assert [do: {:assert, [line: 5], [{:==, [line: 5], [true, true]}]}] == Blanks.replace(ast, true)
  end

  test "multiple arguments" do
    ast = [do: {:assert, [line: 5], [{:==, [line: 5], [:__, :__]}]}]

    assert [do: {:assert, [line: 5], [{:==, [line: 5], [true, false]}]}] == Blanks.replace(ast, [true, false])
  end

  test "counts simple blanks" do
    ast = quote do: 1 + :__

    assert Blanks.count(ast) == 1
  end

  test "counts multiple blanks" do
    ast = [do: {:assert, [line: 5], [{:==, [line: 5], [:__, :__]}]}]

    assert Blanks.count(ast) == 2
  end
end
