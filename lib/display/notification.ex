defmodule Display.Notifications do
  def congratulate do
    Colours.green("\nYou have learned much. You must find your own path now.")
  end

  def invalid_koan(koan, modules) do
    koans_names = module_names(modules)
    "Did not find koan #{name(koan)} in " <> koans_names
  end

  defp module_names(modules) do
    modules
    |> Enum.map(&Atom.to_string/1)
    |> Enum.map(&name/1)
    |> Enum.join(", ")
    |> Colours.red
  end

  defp name("Elixir." <> module), do: module
  defp name(module), do: name(Atom.to_string(module))
end
