defmodule MapSets do
  use Koans

  @intro "My name is Set, MapSet."

  @set MapSet.new([1, 2, 3, 4, 5])

  koan "I am very similar to a list" do
    assert Enum.fetch(@set, 0) == {:ok, 1}
  end

  koan "However, I do not allow duplication" do
    new_set = MapSet.new([1, 1, 2, 3, 3, 3])

    assert MapSet.size(new_set) == 3
  end

  def sorted?(set) do
    list = MapSet.to_list(set)
    sorted = Enum.sort(list)
    list == sorted
  end

  koan "You cannot depend on my order" do
    new_set = MapSet.new(1..33)
    assert sorted?(new_set) == false

    # Note: The number "33" is actually special here. Erlang uses a different
    # implementation for maps after 32 elements which does not maintain order.
    # http://stackoverflow.com/a/40408469

    # What do you think this answer to this assertion is?
    assert sorted?(@set) == true
  end

  koan "Does this value exist in the map set?" do
    assert MapSet.member?(@set, 3) == true
  end

  koan "I am merely another collection, but you can perform some operations on me" do
    new_set = MapSet.new(@set, fn x -> 3 * x end)

    assert MapSet.member?(new_set, 15) == true
    assert MapSet.member?(new_set, 1) == false
  end

  koan "Add this value into a map set" do
    modified_set = MapSet.put(@set, 6)

    assert MapSet.member?(modified_set, 6) == true
  end

  koan "Delete this value from the map set" do
    modified_set = MapSet.delete(@set, 1)

    assert MapSet.member?(modified_set, 1) == false
  end

  koan "Are these maps twins?" do
    new_set = MapSet.new([1, 2, 3])

    assert MapSet.equal?(@set, new_set) == false
  end

  koan "I want only the common values in both sets" do
    intersection_set = MapSet.intersection(@set, MapSet.new([5, 6, 7]))

    assert MapSet.member?(intersection_set, 5) == true
  end

  koan "Unify my sets" do
    new_set = MapSet.union(@set, MapSet.new([1, 5, 6, 7]))

    assert MapSet.size(new_set) == 7
  end

  koan "I want my set in a list" do
    assert MapSet.to_list(@set) == [1, 2, 3, 4, 5]
  end
end
