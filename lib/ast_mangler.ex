defmodule ASTMangler do
  def expand([], _), do: []
  def expand({fun, context, args}, replacement) do
    new_args = replace(args, replacement)
    {fun, context, new_args}
  end
  def expand([do: thing], replacement) do
    [do: expand(thing, replacement)]
  end
  def expand(n, _), do: n

  def replace(nil, _), do: nil
  def replace(args, b) do
    args
    |> Enum.find_index(fn(x) -> x == :__ end)
    |> replace(args, b)
  end
  def replace(nil, ast, b) when is_list(ast) do
    Enum.map(ast, fn(element) -> expand(element, b) end)
  end
  def replace(index, list, b) when is_integer(index) do
    List.update_at(list, index, fn(_)-> b end)
  end
end
