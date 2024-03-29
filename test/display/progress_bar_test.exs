defmodule ProgressBarTest do
  use ExUnit.Case

  alias Display.ProgressBar

  test "empty bar" do
    bar = ProgressBar.progress_bar(%{total: 12, current: 0})
    assert bar == "|                              | 0 of 12 -> 0.0% complete"
  end

  test "puts counter on the right until half the koans are complete" do
    bar = ProgressBar.progress_bar(%{total: 12, current: 3})
    assert bar == "|=======>                      | 3 of 12 -> 25.0% complete"
  end

  test "full bar" do
    bar = ProgressBar.progress_bar(%{total: 12, current: 12})
    assert bar == "|=============================>| 12 of 12 -> 100.0% complete"
  end
end
