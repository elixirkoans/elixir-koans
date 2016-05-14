defmodule IntroTest do
  use ExUnit.Case

  alias Display.Intro

  test "module not visited yet" do
    assert Intro.intro(SampleKoan, []) == "There is something\n\n"
  end

  test "module has been visited" do
    assert Intro.intro(SampleKoan, [SampleKoan]) == ""
  end
end
