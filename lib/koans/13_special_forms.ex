defmodule SpecialForms do
  use Koans

  koan "Quickly create a list with for" do
    result = for x <- [1,2,3,4], do: x * x
    assert result == :__
  end

  koan "Any enumerable can be used to generate values for a comprehension" do
    result = for x <- -4..4, do: x + 10
    assert result == :__
  end

  koan "Pattern matching left of the generator is fine for filtering" do
    goods_and_bads = [good: 4, bad: 3, good: 28, good: 1, bad: -1, bad: 0]
    result = for {:good, x} <- goods_and_bads, do: x + 10
    assert result == :__
  end

  koan "Or you can use an explicit filter function" do
    even? = fn(x) -> rem(x, 2) == 0 end

    result = for x <- -3..3, even?.(x), do: x*x
    assert result == :__
  end

  koan "Multiple generators can be used in conjunction" do
    below_max? = fn(x) -> x < 50 end

    widths = [2,3,4]
    heights = [12,20,30]

    ok_sizes = for width <- widths,
                  height <- heights,
                  below_max?.(width*height),
                  do: width * height

    assert ok_sizes |> Enum.sort == :__
  end

  koan "You can refernece values from another generator" do
    less_than_five? = fn(x,y) -> (x * y) < 5 end
    result = for a <- 1..5,
                 b <- a..10,
                 less_than_five?.(a, b),
                 do: a * b

     assert result == :__
  end

  koan "Can capture multiple results." do
    opts = %{ width: 10, height: 10}
    area = with {:ok, x} <- Map.fetch(opts, :width),
                {:ok, y} <- Map.fetch(opts, :height),
                do: x * y

    assert area == :__
  end

  koan "When with fails to match" do
    opts = %{ height: 10}
    area = with {:ok, x} <- Map.fetch(opts, :width),
                {:ok, y} <- Map.fetch(opts, :height),
                do: x * y

    assert area == :__
  end

  koan "Cond will run the first expression where something it true" do
    cond_example = fn(x) -> cond do
                        rem(x,3) == 0 -> :by_three
                        rem(x,5) == 0 -> :by_five
                        rem(x,2) == 0 -> :by_two
                      end
                   end

    assert cond_example.(10) == :__
  end

  koan "'True' will always match in a case" do
    cond_example = fn(x) -> cond do
                        x == 0 -> :zero
                        true -> "it was true"
                      end
                   end

    assert cond_example.(7) == :__
  end

  koan "Case example" do
    case_example = fn(x) -> case x do
                       :ok -> "it was ok"
                       :error -> "it wasn't ok"
                       _ -> "it was something else"
                      end
                    end

    assert case_example.(:ok) == :__
    assert case_example.(:error) == :__
    assert case_example.(:foo) == :__
  end
end
