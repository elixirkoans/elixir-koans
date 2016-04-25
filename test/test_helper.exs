ExUnit.start()

defmodule TestHarness do
  def test_all(module, answers) do
    module.all_koans
    |> Enum.zip(answers)
    |> run_all(module)
  end

  def run_all(pairs, module) do
    Enum.map(pairs, fn ({koan, answer}) -> Execute.run_koan(module, koan, [answer]) end)
  end
end
