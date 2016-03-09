defmodule PowerTest do
  use ExUnit.Case

  test "something" do
    [first | _] = Equalities.all_koans

    assert :passed == Runner.test_single_koan(Equalities, first, true)
  end
end
