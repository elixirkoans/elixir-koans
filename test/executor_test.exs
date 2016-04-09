defmodule RunnerTest do
  use ExUnit.Case

  test "passes a koan" do
    assert :passed == Execute.run_module(PassingKoan)
  end

  test "stops at the first failing koan" do
    {:failed, %{error: _, file: file, line: line}, SampleKoan, _name} = Execute.run_module(SampleKoan)
    assert file == 'test/support/sample_koan.ex'
    assert line == 5
  end
end
