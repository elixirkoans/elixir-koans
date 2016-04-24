defmodule DisplayTest do
  use ExUnit.Case

  test "puts counter on the right until half the koans are complete" do
    bar = Display.progress_bar(%{total: 12, current: 3})
    assert bar == "|==========>        (3/12)              |"
  end

  test "puts the counter on the left after half the koans are complete" do
    bar = Display.progress_bar(%{total: 12, current: 10})
    assert bar == "|(10/12)========================>       |"
  end

  test "full bar" do
    bar = Display.progress_bar(%{total: 12, current: 12})
    assert bar == "|(12/12)===============================>|"
  end
end
