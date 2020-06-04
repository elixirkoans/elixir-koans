defmodule Koans do
  defp valid_name(name) do
    Regex.match?(~r/([A-Z]|\.\.\.).+/, name)
  end

  defmacro koan(name, do: body) do
    if not valid_name(name) do
      raise "Name does not start with a capital letter: #{name}"
    end

    compiled_name = String.to_atom(name)
    number_of_args = Blanks.count(body)
    compiled_body = Blanks.replace_line(body, &blank_line_replacement/1)

    quote do
      @koans unquote(compiled_name)

      generate_test_method(unquote(compiled_name), unquote(number_of_args), unquote(body))

      def unquote(compiled_name)() do
        try do
          unquote(compiled_body)
          :ok
        rescue
          e -> {:error, __STACKTRACE__, e}
        end
      end
    end
  end

  defmacro generate_test_method(_name, 0, _body), do: false

  defmacro generate_test_method(name, 1, body) do
    single_var = Blanks.replace(body, Macro.var(:answer, __MODULE__))

    quote do
      def unquote(name)(answer) do
        try do
          unquote(single_var)
          :ok
        rescue
          e -> {:error, __STACKTRACE__, e}
        end
      end
    end
  end

  defmacro generate_test_method(name, number_of_args, body) do
    answer_vars =
      for id <- 1..number_of_args, do: Macro.var(String.to_atom("answer#{id}"), __MODULE__)

    multi_var = Blanks.replace(body, answer_vars)

    quote do
      def unquote(name)({:multiple, unquote(answer_vars)}) do
        try do
          unquote(multi_var)
          :ok
        rescue
          e -> {:error, __STACKTRACE__, e}
        end
      end
    end
  end

  defp blank_line_replacement({:assert, _meta, [expr]}) do
    code = Macro.escape(expr)
    quote do: raise(ExUnit.AssertionError, expr: unquote(code))
  end

  defp blank_line_replacement(line) do
    code = Macro.escape(line)
    quote do: raise(ExUnit.AssertionError, expr: unquote(code))
  end

  defmacro __using__(_opts) do
    quote do
      @compile :nowarn_unused_vars
      Module.register_attribute(__MODULE__, :koans, accumulate: true)

      require ExUnit.Assertions
      import ExUnit.Assertions
      import Koans

      @before_compile Koans
    end
  end

  defmacro __before_compile__(env) do
    koans = koans(env)

    quote do
      def all_koans do
        unquote(koans)
      end

      def intro, do: @intro
    end
  end

  defp koans(env) do
    env.module
    |> Module.get_attribute(:koans)
    |> Enum.reverse()
  end
end
