defmodule Blanks do
  def replace(ast, replacement) when not is_list(replacement), do: replace(ast, [replacement])
  def replace([do: ast], replacements), do: [do: replace(ast, replacements)]
  def replace(ast, replacements) do
    ast
    |> Macro.prewalk(replacements, &pre/2)
    |> elem(0)
  end

  defp pre({:assert_receive, _, args} = node, replacements) do
    {args, replacements} = Macro.prewalk(args, replacements, &pre_pin/2)
    {put_elem(node, 2, args), replacements}
  end
  defp pre(:___, [first | remainder]), do: {first, remainder}
  defp pre({:___, _, _}, [first | remainder]), do: {first, remainder}
  defp pre(node, acc), do: {node, acc}

  defp pre_pin(:___, [first | remainder]), do: {pin(first), remainder}
  defp pre_pin({:___, _, _}, [first | remainder]), do: {pin(first), remainder}
  defp pre_pin(node, acc), do: {node, acc}

  defp pin(var) when is_tuple(var) do
    quote do
      ^unquote(var)
    end
  end
  defp pin(var), do: var

  def count(ast) do
    ast
    |> Macro.prewalk(0, &count/2)
    |> elem(1)
  end

  defp count(:___, acc), do: {node, acc+1}
  defp count({:___, _, _}, acc), do: {node, acc+1}
  defp count(node, acc), do: {node, acc}

  def replace_line([do: ast], replacement_fn), do: [do: replace_line(ast, replacement_fn)]
  def replace_line({:__block__, meta, lines}, replacement_fn) do
    replaced_lines = Enum.map(lines, fn(line) ->
      replace_line(line, replacement_fn)
    end)

    {:__block__, meta, replaced_lines}
  end
  def replace_line(line, replacement_fn) do
    if Blanks.count(line) > 0 do
      replacement_fn.(line)
    else
      line
    end
  end
end
