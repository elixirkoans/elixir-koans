defmodule PassingKoan do
  @moduledoc false
  use Koans

  @intro "something"

  koan "Hi there" do
    assert 1 == 1
  end
end
