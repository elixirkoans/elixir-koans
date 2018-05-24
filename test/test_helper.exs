ExUnit.start()

defmodule TestHarness do
  import ExUnit.Assertions

  def test_all(module, answers) do
    module.all_koans
    |> check_answer_count(answers, module)
    |> Enum.zip(answers)
    |> run_all(module)
    |> check_results
  end

  defp check_answer_count(koans, answers, module) do
    koans_count = length(koans)
    answer_count = length(answers)

    if length(koans) > length(answers) do
      raise "Answer missing for #{module}. #{koans_count} koans, but only #{answer_count} answers."
    else
      koans
    end
  end

  defp check_results(results) do
    Enum.each(results, &assert(&1 == :passed))
  end

  def run_all(pairs, module) do
    Enum.map(pairs, fn {koan, answer} -> Execute.run_koan(module, koan, [answer]) end)
  end
end
