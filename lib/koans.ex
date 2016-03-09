defmodule Koans do
  defmacro koan(name, body) do
    compiled_name = String.to_atom(name)
    x = quote do: answer
    mangled_body = ASTMangler.expand(body, x)
    quote do
      @koans unquote(compiled_name)
      def unquote(compiled_name)(answer \\ :nothing) do
        try do
            if answer == :nothing do
              unquote(body)
            else
              unquote(mangled_body)
            end
          :ok
        rescue
          e in _ -> e
        end
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
