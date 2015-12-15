defmodule Koans do
  defmacro koan(name, body) do
    compiled_name = :"koan: #{name}"
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

  defmacro __using__(_) do
    quote do
      import Koans
      import ExUnit.Assertions
    end
  end
end
