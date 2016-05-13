defmodule IntroTest do
  use ExUnit.Case

  alias Display.Intro

  test "module not visited yet" do
    assert Intro.intro(SampleKoan, []) == "\e[32mThere is something\n\n\e[0m"
  end

  test "module has been visited" do
    assert Intro.intro(SampleKoan, [SampleKoan]) == ""
  end
end
