defmodule ASTMangler do
  def expand([do: thing], replacement) do
    [do: expand(thing, replacement)]
	end

  def expand({fun, context, args}, replacement) do
    new_args = replace(args, replacement)
    {fun, context, new_args}
  end

  def replace(args, b) do
    args
    |> Enum.find_index(fn(x) -> x == :__ end)
    |> replace(args, b)
  end

	def replace(nil, [], _b), do: []
	def replace(nil, [ast], b) do
    [expand(ast,b)]
	end
  def replace(index, list, b) do
    List.update_at(list, index, fn(_)-> b end)
  end
end
