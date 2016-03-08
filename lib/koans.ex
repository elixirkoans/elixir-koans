defmodule Koans do
  @prefix "koan: "

  defmacro koan(name, body) do
    compiled_name = :"#{prefix}#{name}"

    quote do
      @koans unquote(compiled_name)
      def unquote(compiled_name)() do
        try do
          unquote(body)
          :ok
        rescue
          e in ExUnit.AssertionError -> e
        end
      end
    end
  end

  defmacro __using__(opts) do
    quote do
      Module.register_attribute(__MODULE__, :koans, accumulate: true)
      require ExUnit.Assertions
      import Koans
      import BlankAssertions

      @before_compile KoansBuilder
    end
  end

  def prefix do
    @prefix
  end
end

defmodule KoansBuilder do
  defmacro __before_compile__(env) do
    koans = Module.get_attribute(env.module, :koans) |> Enum.reverse
    quote do
      def all_koans do
        unquote(koans)
      end
    end
  end
end
