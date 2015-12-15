defmodule Lists do
  use Koans

  koan "We shall contemplate truth by testing reality, via equality" do
    assert List.first([1, 2, 3]) == 2
  end
end
