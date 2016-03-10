defmodule KoansHarnessTest do
  use ExUnit.Case

  test "Equalities" do
    answers = [true, 1, 2, 1, :something]

    assert all_pass?(Equalities, answers) == [:passed, :passed, :passed, :passed, :passed]
  end

  def all_pass?(module, answers) do
    module.all_koans
    |> Enum.zip(answers)
    |> Enum.map(fn({koan, answer}) -> Runner.run_koan(module, koan, [answer]) end)
  end
end
