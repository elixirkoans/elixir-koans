defmodule KoansHarnessTest do
  use ExUnit.Case

  test "Equalities" do
    answers = [true,
               1,
               2,
               1,
               :something]

    test_all(Equalities, answers)
  end

  test "Lists" do
    answers = [1,
               3,
               [1,2,:a,"b"],
               [1,2],
               [1,2,3],
               [1,3],
               ["life", "life", "life"],
               [1, 2, 3, 4, 5],
               [1, 2, 3, 4],
               [1, 4, 2, 3],
               [10, 2, 3],
               [1, 2, 3],
               [1, 2, 3, 4],
               [1, 2, 3, 4],
               {1, 2, 3},
               ["value"],
               [{1, 3, 5}, {2, 4, 6}]
               ]

    test_all(Lists, answers)
  end

  def test_all(module, answers) do
    module.all_koans
    |> Enum.zip(answers)
    |> run_all(module)
  end

  def run_all(pairs, module) do
    Enum.map(pairs, fn ({koan, answer}) -> Runner.run_koan(module, koan, [answer]) end)
  end
end
