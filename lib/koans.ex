defmodule Koans do
  @prefix "koan: "

  defmacro koan(name, body) do
    compiled_name = :"#{prefix}#{name}"
    quote do
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
      require ExUnit.Assertions
      import Koans
      import BlankAssertions
    end
  end

  def prefix do
    @prefix
  end
end
