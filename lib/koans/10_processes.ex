defmodule Processes do
  use Koans

  koan "You are a process" do
    assert Process.alive?(self()) == ___
  end

  koan "You can ask a process to introduce itself" do
    information = Process.info(self())

    assert information[:status] == ___
  end

  koan "New processes are spawned functions" do
    pid = spawn(fn -> nil end)

    assert Process.alive?(pid) == ___
  end

  koan "You can send messages to processes" do
    send self(), "hola!"

    receive do
      msg -> assert msg == ___
    end
  end

  koan "A common pattern is to include the sender in the message, so that it can reply" do
    pid = spawn(fn -> receive do
                         {:hello, sender} -> send sender, :how_are_you?
                      end
                 end)

    send pid, {:hello, self()}
    assert_receive ___
  end

  koan "Waiting for a message can get boring" do
    parent = self()
    spawn(fn -> receive do
                after
                  5 -> send parent, {:waited_too_long, "I am impatient"}
                end
           end)

    assert_receive ___
  end

  koan "Killing a process will terminate it" do
    pid = spawn(fn -> Process.exit(self(), :kill) end)
    :timer.sleep(500)
    assert Process.alive?(pid) == ___
  end

  koan "You can also terminate processes other than yourself" do
    pid = spawn(fn -> receive do end end)

    assert Process.alive?(pid) == ___
    Process.exit(pid, :kill)
    assert Process.alive?(pid) == ___
  end

  koan "Trapping will allow you to react to someone terminating the process" do
    parent = self()
    pid = spawn(fn ->
                      Process.flag(:trap_exit, true)
                      send parent, :ready
                      receive do
                        {:EXIT, _pid, reason} -> send parent, {:exited, reason}
                      end
    end)

    receive do
      :ready -> true
    end

    Process.exit(pid, :random_reason)

    assert_receive ___
  end

  koan "Trying to quit normally has no effect" do
    pid = spawn(fn -> receive do end end)
    Process.exit(pid, :normal)

    assert Process.alive?(pid) == ___
  end

  koan "Exiting normally yourself on the other hand DOES terminate you" do
    pid = spawn(fn -> Process.exit(self, :normal) end)
    :timer.sleep(100)

    assert Process.alive?(pid) == ___
  end

  koan "Parent processes can be informed about exiting children, if they trap and link" do
    Process.flag(:trap_exit, true)
    spawn_link(fn -> Process.exit(self, :normal) end)

    assert_receive {:EXIT, _pid, ___}
  end

  koan "If you monitor your children, you'll be automatically informed for their depature" do
    spawn_monitor(fn -> Process.exit(self(), :normal) end)

    assert_receive {:DOWN, _ref, :process, _pid, ___}
  end
end
