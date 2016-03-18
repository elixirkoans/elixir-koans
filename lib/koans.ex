defmodule Koans do
  defmacro koan(name, body) do
    compiled_name = String.to_atom(name)
    number_of_args = ASTMangler.count(body)
    quote do
      @koans unquote(compiled_name)

      generate_test_method(unquote(compiled_name), unquote(number_of_args), unquote(body))

      def unquote(compiled_name)() do
        try do
          unquote(body)
          :ok
        rescue
          e in _ -> e
        end
      end
    end
  end

  defmacro generate_test_method(_name, 0, _body), do: false
  defmacro generate_test_method(name, 1, body) do
    single_var = ASTMangler.expand(body, Macro.var(:answer, Koans))
    quote do
      def unquote(name)(answer) do
        converted = {answer}
        unquote(single_var)
        :ok
      end
    end
  end
  defmacro generate_test_method(name, number_of_args, body) do
    answer_placeholders = expand(number_of_args)
    multi_var = ASTMangler.expand(body, answer_placeholders)
    quote do
      def unquote(name)({:multiple, answers}) do
        converted = List.to_tuple(answers)
        unquote(multi_var)
        :ok
      end
    end
  end

  def expand(amount) do
    Enum.map(0..amount, fn (idx) -> quote do: elem(converted, unquote(idx)) end)
  end

  defmacro __using__(_opts) do
    quote do
      @compile :nowarn_unused_vars
      Module.register_attribute(__MODULE__, :koans, accumulate: true)
      require ExUnit.Assertions
      import Koans
      import BlankAssertions

      @before_compile Koans
    end
  end

  defmacro __before_compile__(env) do
    koans = Module.get_attribute(env.module, :koans) |> Enum.reverse
    quote do
      def all_koans do
        unquote(koans)
      end
    end
  end
end
