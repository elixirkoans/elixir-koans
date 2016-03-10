defmodule PowerTest do
  use ExUnit.Case

  test "something" do
    koans = Equalities.all_koans
    answers = [true, 1]

    combined = Enum.zip(koans, answers)
    Enum.each(combined, fn({koan, answer}) -> assert :passed == Runner.test_single_koan(Equalities, koan, answer) end)
  end
end
