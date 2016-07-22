defmodule MapSets do
  use Koans

  @intro "My name is Set, MapSet."

  @set MapSet.new([1, 2, 3, 4, 5])

  koan "I am very similar to a list" do
    assert Enum.fetch(@set, 0) == {:ok, ___}
  end

  koan "However, I do not allow duplication" do
    new_set = MapSet.new([1, 1, 2, 3, 3, 3])

    assert MapSet.size(new_set) == ___
  end

  koan "Even though I am like a list I am unordered after 32 elements" do
    assert 1..33 |> MapSet.new() |> Enum.fetch(0) == {___, 11}
  end

  koan "Does this value exist in the map set?" do
    assert MapSet.member?(@set, 3) == ___
  end
  
  koan "I am merely another collection but, you can perform some operations on me" do
    new_set = MapSet.new(@set, fn x -> 3 * x end)

    assert MapSet.member?(new_set, 15) == ___
    assert MapSet.member?(new_set, 1) == ___
  end

  koan "Add this value into a map set" do
    modified_set = MapSet.put(@set, 6)

    assert MapSet.member?(modified_set, 6) == ___
  end

  koan "Delete this value from the map set" do
    modified_set = MapSet.delete(@set, 1)

    assert MapSet.member?(modified_set, 1) == ___
  end

  koan "How large is my map set?" do
    assert MapSet.size(@set) == ___
  end

  koan "Are these maps twins?" do
    new_set = MapSet.new([1, 2, 3])

    assert MapSet.equal?(@set, new_set) == ___
  end

  koan "I want only the common values in both sets" do
    intersection_set = MapSet.intersection(@set, MapSet.new([5, 6, 7]))

    assert MapSet.member?(intersection_set, 5) == ___
  end

  koan "Unify my sets" do
    new_set = MapSet.union(@set, MapSet.new([1, 5, 6, 7]))

    assert MapSet.size(new_set) == ___
  end

  koan "I want my set in a list" do
    assert MapSet.to_list(@set) == ___
  end
end
