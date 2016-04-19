defmodule Blanks do
  def replace(ast, replacement) when not is_list(replacement), do: replace(ast, [replacement])
  def replace([do: ast], replacements), do: [do: replace(ast, replacements)]
  def replace(ast, replacements) do
    ast
    |> Macro.prewalk(replacements, &pre/2)
    |> elem(0)
  end

  defp pre(:__, [first | remainder]), do: {first, remainder}
  defp pre({:__, _, _}, [first | remainder]), do: {first, remainder}
  defp pre(node, acc), do: {node, acc}

  def count(ast) do
    ast
    |> Macro.prewalk(0, &count/2)
    |> elem(1)
  end

  defp count(:__, acc), do: {node, acc+1}
  defp count({:__, _, _}, acc), do: {node, acc+1}
  defp count(node, acc), do: {node, acc}
end
