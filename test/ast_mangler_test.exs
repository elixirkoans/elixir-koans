defmodule ASTManglerTest do
  use ExUnit.Case, async: true

  test "simple replacement" do
    ast = quote do: 1 + :__

    mangled = ASTMangler.expand(ast, 37)
    assert {:+, [context: ASTManglerTest, import: Kernel], [1, 37]} == mangled
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

    assert [do: {:assert, [line: 5], [{:==, [line: 5], [true, true]}]}] == ASTMangler.expand(ast, true)
  end
end
