defmodule KoansHarnessTest do
  use ExUnit.Case

  test "Equalities" do
    answers = [true, 1, 2, 1, :something]

    assert all_pass?(Equalities, answers) == [:passed, :passed, :passed, :passed, :passed]
  end

  def all_pass?(module, answers) do
    module.all_koans
    |> Enum.zip(answers)
    |> Enum.map(fn({koan, answer}) -> KoansHarnessTest.test_single_koan(module, koan, answer) end)
  end

  def test_single_koan(module, name, answer) do
    case apply(module, name, [answer]) do
      :ok -> :passed
      error -> {:error, name, error}
    end
  end
end
