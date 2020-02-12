defmodule Agents do
  use Koans

  @intro "Agents"

  koan "Agents maintain state, so you can ask them about it" do
    {:ok, pid} = Agent.start_link(fn -> "Hi there" end)
    assert Agent.get(pid, & &1) == "Hi there"
  end

  koan "Agents may also be named so that you don't have to keep the pid around" do
    Agent.start_link(fn -> "Why hello" end, name: AgentSmith)
    assert Agent.get(AgentSmith, & &1) == "Why hello"
  end

  koan "Update to update the state" do
    Agent.start_link(fn -> "Hi there" end, name: __MODULE__)

    Agent.update(__MODULE__, fn old ->
      String.upcase(old)
    end)

    assert Agent.get(__MODULE__, & &1) == "HI THERE"
  end

  koan "Use get_and_update when you need to read and change a value in one go" do
    Agent.start_link(fn -> ["Milk"] end, name: __MODULE__)

    old_list =
      Agent.get_and_update(__MODULE__, fn old ->
        {old, ["Bread" | old]}
      end)

    assert old_list == ["Milk"]
    assert Agent.get(__MODULE__, & &1) == ["Bread", "Milk"]
  end

  koan "Somebody has to switch off the light at the end of the day" do
    {:ok, pid} = Agent.start_link(fn -> ["Milk"] end, name: __MODULE__)

    Agent.stop(__MODULE__)

    assert Process.alive?(pid) == false
  end
end
