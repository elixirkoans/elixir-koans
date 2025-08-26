defmodule PipeOperator do
  @moduledoc false
  use Koans

  @intro "The Pipe Operator - Making data transformation elegant and readable"

  koan "The pipe operator passes the result of one function to the next" do
    result =
      "hello world"
      |> String.upcase()
      |> String.split(" ")
      |> Enum.join("-")

    assert result == ___
  end

  koan "Without pipes, nested function calls can be hard to read" do
    nested_result = Enum.join(String.split(String.downcase("Hello World"), " "), "_")
    piped_result = "Hello World" |> String.downcase() |> String.split(" ") |> Enum.join("_")

    assert nested_result == piped_result
    assert piped_result == ___
  end

  koan "Pipes pass the result as the first argument to the next function" do
    result =
      [1, 2, 3, 4, 5]
      |> Enum.filter(&(&1 > 2))
      |> Enum.map(&(&1 * 2))

    assert result == ___
  end

  koan "Additional arguments can be passed to piped functions" do
    result =
      "hello world"
      |> String.split(" ")
      |> Enum.join(", ")

    assert result == ___
  end

  koan "Pipes work with anonymous functions too" do
    double = fn x -> x * 2 end
    add_ten = fn x -> x + 10 end

    result =
      5
      |> double.()
      |> add_ten.()

    assert result == ___
  end

  koan "You can pipe into function captures" do
    result =
      [1, 2, 3]
      |> Enum.map(&Integer.to_string/1)
      |> Enum.join("-")

    assert result == ___
  end

  koan "Complex data transformations become readable with pipes" do
    users = [
      %{name: "Bob", age: 25, active: false},
      %{name: "Charlie", age: 35, active: true},
      %{name: "Alice", age: 30, active: true}
    ]

    active_names =
      users
      |> Enum.filter(& &1.active)
      |> Enum.map(& &1.name)
      |> Enum.sort()

    assert active_names == ___
  end

  koan "Pipes can be split across multiple lines for readability" do
    result =
      "the quick brown fox jumps over the lazy dog"
      |> String.split(" ")
      |> Enum.filter(&(String.length(&1) > 3))
      |> Enum.map(&String.upcase/1)
      |> Enum.take(3)

    assert result == ___
  end

  # TODO: Fix this example. It doesn't illustrate the point well.
  koan "The then/2 function is useful when you need to call a function that doesn't take the piped value as first argument" do
    result =
      [1, 2, 3]
      |> Enum.map(&(&1 * 2))
      |> then(&Enum.zip([:a, :b, :c], &1))

    assert result == ___
  end

  koan "Pipes can be used with case statements" do
    process_number = fn x ->
      x
      |> Integer.parse()
      |> case do
        {num, ""} -> {:ok, num * 2}
        _ -> {:error, :invalid_number}
      end
    end

    assert process_number.("42") == ___
    assert process_number.("abc") == ___
  end

  koan "Conditional pipes can use if/unless" do
    process_string = fn str, should_upcase ->
      str
      |> String.trim()
      |> then(&if should_upcase, do: String.upcase(&1), else: &1)
      |> String.split(" ")
    end

    assert process_string.("  hello world  ", true) == ___
    assert process_string.("  hello world  ", false) == ___
  end

  koan "Pipes work great with Enum functions for data processing" do
    sales_data = [
      %{product: "Widget", amount: 100, month: "Jan"},
      %{product: "Gadget", amount: 200, month: "Jan"},
      %{product: "Widget", amount: 150, month: "Feb"},
      %{product: "Gadget", amount: 180, month: "Feb"}
    ]

    widget_total =
      sales_data
      |> Enum.filter(&(&1.product == "Widget"))
      |> Enum.map(& &1.amount)
      |> Enum.sum()

    assert widget_total == ___
  end

  koan "Tap lets you perform side effects without changing the pipeline" do
    result =
      [1, 2, 3]
      |> Enum.map(&(&1 * 2))
      |> tap(&IO.inspect(&1, label: "After doubling"))
      |> Enum.sum()

    assert result == ___
  end

  koan "Multiple transformations can be chained elegantly" do
    text = "The quick brown fox dumped over the lazy dog"

    word_stats =
      text
      |> String.downcase()
      |> String.split(" ")
      |> Enum.group_by(&String.first/1)
      |> Enum.map(fn {letter, words} -> {letter, length(words)} end)
      |> Enum.into(%{})

    assert word_stats["d"] == ___
    assert word_stats["t"] == ___
    assert word_stats["q"] == ___
  end

  koan "Pipes can be used in function definitions for clean APIs" do
    defmodule TextProcessor do
      def clean_and_count(text) do
        text
        |> String.trim()
        |> String.downcase()
        |> String.replace(~r/[^\w\s]/, "")
        |> String.split()
        |> length()
      end
    end

    assert TextProcessor.clean_and_count("  Hello, World! How are you?  ") == ___
  end

  koan "Error handling can be integrated into pipelines" do
    safe_divide = fn
      {x, 0} -> {:error, :division_by_zero}
      {x, y} -> {:ok, x / y}
    end

    pipeline = fn x, y ->
      {x, y}
      |> safe_divide.()
      |> case do
        {:ok, result} -> "Result: #{result}"
        {:error, reason} -> "Error: #{reason}"
      end
    end

    assert pipeline.(10, 2) == ___
    assert pipeline.(10, 0) == ___
  end
end
