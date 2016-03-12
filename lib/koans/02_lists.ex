defmodule Lists do
  use Koans

  koan "We can see what is ahead" do
    assert List.first([1, 2, 3]) == :__
  end

  koan "Checking what's trailing is also simple" do
    assert List.last([1, 2, 3]) == :__
  end

  koan "Diversity is embraced" do
    assert [1, 2] ++ [:a, "b"] == :__
  end

  koan "Things can evolve" do
    assert [1, 2, 3] -- [3] == :__
  end

  koan "Evolution can have different forms" do
    assert List.delete([1, 2, 2, 3], 2) == :__
  end

  koan "Precision is also valued" do
    assert List.delete_at([1, 2, 3], 1) == :__
  end

  koan "Replication is also possible" do
    assert List.duplicate("life", 3) == :__
  end

  koan "Sometimes levelling the playing field is desired" do
    assert List.flatten([1, [2, 3], 4, [5]]) == :__
  end

  koan "Same rules apply to new members that arrive late" do
    assert List.flatten([1, [2, 3]], [4]) == :__
  end

  koan "Order can also be specified for new members" do
    assert List.insert_at([1, 2, 3], 1, 4) == :__
  end

  koan "We can replace things at specified positions" do
    assert List.replace_at([1, 2, 3], 0, 10) == :__
  end

  koan "Replacing something which is not" do
    assert List.replace_at([1, 2, 3], 10, 0) == :__
  end

  koan "Order is bound by nature's laws" do
    assert List.insert_at([1, 2, 3], 10, 4) == :__
  end

  koan "Sometimes its faster to loop around back" do
    assert List.insert_at([1, 2, 3], -1, 4) == :__
  end

  koan "We can also transform ourselves completely" do
    assert List.to_tuple([1, 2, 3]) == :__
  end

  koan "Wrapping other values is a handy option" do
    assert List.wrap("value") == :__
  end

  koan "Zipping can be a useful operation" do
    assert List.zip([[1, 2], [3, 4], [5, 6]]) == :__
  end
end
