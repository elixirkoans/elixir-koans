defmodule KeywordLists do
  use Koans

  @intro "KeywordLists"

  koan "Like maps, keyword lists are key-value pairs" do
    kw_list = [foo: "bar"]

    assert kw_list[:foo] == ___
  end

  koan "Keys may be repeated, but only the first is accessed" do
    kw_list = [foo: "bar", foo: "baz"]

    assert kw_list[:foo] == ___
  end

  koan "You could access the values of repeating key" do
    kw_list = [foo: "bar", foo1: "bar1", foo: "baz"]

    assert Keyword.get_values(kw_list, :foo) == [___, ___]
  end

  koan "Keyword lists are just special syntax for lists of two-element tuples" do
    assert [foo: "bar"] == [{___, ___}]
  end

  koan "But unlike maps, the keys in keyword lists must be atoms" do
    kw_list = [foo: "bar"]

    assert_raise ArgumentError, fn -> kw_list[___] end
  end
end
