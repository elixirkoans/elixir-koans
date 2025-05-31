defmodule Agents do
  use Koans

  @intro "Agents"

  koan "Agents maintain state, so you can ask them about it" do
    {:ok, pid} = Agent.start_link(fn -> "Hi there" end)
    assert Agent.get(pid, & &1) == ___
  end

  koan "Agents may also be named so that you don't have to keep the pid around" do
    Agent.start_link(fn -> "Why hello" end, name: AgentSmith)
    assert Agent.get(AgentSmith, & &1) == ___
  end

  koan "Update to update the state" do
    Agent.start_link(fn -> "Hi there" end, name: :greeter)

    Agent.update(:greeter, fn old ->
      String.upcase(old)
    end)

    assert Agent.get(:greeter, & &1) == ___
  end

  koan "Use get_and_update when you need to read and change a value in one go" do
    Agent.start_link(fn -> ["Milk"] end, name: :groceries)

    old_list =
      Agent.get_and_update(:groceries, fn old ->
        {old, ["Bread" | old]}
      end)

    assert old_list == ___
    assert Agent.get(:groceries, & &1) == ___
  end

  koan "Somebody has to switch off the light at the end of the day" do
    {:ok, pid} = Agent.start_link(fn -> "Fin." end, name: :stoppable)

    Agent.stop(:stoppable)

    assert Process.alive?(pid) == ___
  end
end
