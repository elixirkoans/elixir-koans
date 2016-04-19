defmodule Agents do
  use Koans

  koan "Agents maintain state, so you can ask them about it" do
    Agent.start_link(fn() -> "Hi there" end, name: __MODULE__)
    assert Agent.get(__MODULE__, &(&1)) == __
  end

  koan "Update to update the state" do
    Agent.start_link(fn() -> "Hi there" end, name: __MODULE__)

    Agent.update(__MODULE__, fn(old) ->
      String.upcase(old)
    end)
    assert Agent.get(__MODULE__, &(&1)) == __
  end

  koan "Use get_and_update when you need read and change a value in one go" do
    Agent.start_link(fn() -> ["Milk"] end, name: __MODULE__)

    old_list = Agent.get_and_update(__MODULE__, fn(old) ->
      {old, ["Bread" | old]}
    end)

    assert old_list == __
    assert Agent.get(__MODULE__, &(&1)) == __
  end

  koan "Somebody has to switch off the light at the end of the day" do
    Agent.start_link(fn() -> ["Milk"] end, name: __MODULE__)

    result = Agent.stop(__MODULE__)

    assert result == __
  end
end
