defmodule ASTMangler do

  def expand([do: remainder], replacements) when is_list(replacements) do
    [do: expand(remainder, replacements)]
  end
  def expand(ast, replacements) when is_list(replacements) do
    {node, _acc} = Macro.prewalk(ast, replacements, fn(node, acc) -> pre(node, acc) end)
    node
  end
  def expand(ast, replacement) do
    expand(ast, [replacement])
  end

  def pre(:__, [first | remainder]), do: {first, remainder}
  def pre(node, acc), do: {node, acc}


  def count(ast) do
    {_node, acc} = Macro.prewalk(ast, 0, fn(node, acc) -> count(node, acc) end)
    acc
  end

  def count(:__, acc), do: {node, acc+1}
  def count(node, acc), do: {node, acc}
end
