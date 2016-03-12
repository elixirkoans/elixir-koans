defmodule Koans do
  defmacro koan(name, body) do
    compiled_name = String.to_atom(name)
    mangled_body = ASTMangler.expand(body, quote do: answer)
    quote do
      @koans unquote(compiled_name)
      def unquote(compiled_name)() do
        try do
          unquote(body)
          :ok
        rescue
          e in _ -> e
        end
      end

      def unquote(compiled_name)(answer) do
        unquote(mangled_body)
        :ok
      end
    end
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
