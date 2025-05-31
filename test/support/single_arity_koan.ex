defmodule SingleArity do
  use Koans

  @intro """
  A koan with single arity testing
  """

  koan "Only one" do
    assert match?(:foo, ___)
  end
end
