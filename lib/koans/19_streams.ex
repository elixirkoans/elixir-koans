defmodule Streams do
  use Koans

  @intro "Streams"

  koan "Streams are lazier than Enum, they only return a struct" do
    assert Stream.map([1, 2, 3], &(&1 + 1)).__struct__ == ___
  end

  koan "Streams are executed by terminal operations" do
    updated_list =
      [1, 2, 3]
      |> Stream.map(&(&1 + 1))
      |> Enum.to_list

    assert updated_list == ___
  end

  koan "Which will let you decide which element you want to compute in the stream" do
    computed_element =
      1..42
      |> Stream.map(&("I computed: #{&1}"))
      |> Enum.take(1)

    assert computed_element == ___
  end
end
