defmodule TrackerTest do
  use ExUnit.Case

  @sample_modules [SampleKoan, PassingKoan]

  test "can start" do
    Tracker.start(@sample_modules)
    assert Tracker.summarize == %{total: 2, current: 0}
  end

  test "can be notified of completed koans" do
    Tracker.start(@sample_modules)
    Tracker.completed(:"Hi there")
    assert Tracker.summarize == %{total: 2, current: 1}
  end

  test "multiple comletions of the same koan count only once" do
    Tracker.start(@sample_modules)
    Tracker.completed(:"Hi there")
    Tracker.completed(:"Hi there")
    assert Tracker.summarize == %{total: 2, current: 1}
  end
end
