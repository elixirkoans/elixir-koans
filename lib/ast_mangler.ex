defmodule ASTMangler do
  def expand(ast, replacement) do
    Macro.prewalk(ast, fn(node) -> update(node, replacement) end)
  end

  def update(:__, replacement), do: replacement
  def update(node, _), do: node
end
