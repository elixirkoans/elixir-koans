defmodule TrackerTest do
  use ExUnit.Case

  @sample_modules [SampleKoan, PassingKoan]

  test "can start" do
    Tracker.set_total(@sample_modules)
    assert Tracker.summarize() == %{total: 2, current: 0, visited_modules: []}
  end

  test "can be notified of completed koans" do
    Tracker.set_total(@sample_modules)
    Tracker.completed(SampleKoan, :"Hi there")
    assert Tracker.summarize() == %{total: 2, current: 1, visited_modules: [SampleKoan]}
  end

  test "multiple comletions of the same koan count only once" do
    Tracker.set_total(@sample_modules)
    Tracker.completed(SampleKoan, :"Hi there")
    Tracker.completed(SampleKoan, :"Hi there")
    assert Tracker.summarize() == %{total: 2, current: 1, visited_modules: [SampleKoan]}
  end

  test "knows when koans are not complete" do
    Tracker.set_total(@sample_modules)
    refute Tracker.complete?()
  end
end
