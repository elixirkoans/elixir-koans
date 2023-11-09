defmodule SingleArity do
  @moduledoc false
  use Koans

  @intro """
  A koan with single arity testing
  """

  koan "Only one" do
    assert match?(:foo, ___)
  end
end
