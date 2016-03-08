defmodule Processes do
  use Koans

  koan "tests run in a process!" do
    assert Process.alive?(self)
  end

  koan "can spew out information about a process" do
    information = Process.info(self)

    assert information[:status] == :running
  end

  koan "process can send messages to itself" do
    send self(), "hola!"
    assert_receive "hola!"
  end

  koan "a common pattern is to include the sender in the message" do
    pid = spawn(fn -> receive do
                         {:hello, sender} -> send sender, :how_are_you?
                         _ -> assert false
                      end
                 end)

    send pid, {:hello, self()}
    assert_receive :how_are_you?
  end

  koan "you don't have to wait forever for messages" do
    parent = self()
    spawn(fn -> receive do
                   _anything -> flunk "I really wasn't expecting messages"
                after
                  10 -> send parent, {:waited_too_long, "I am inpatient"}
                end
           end)

    assert_receive {:waited_too_long, "I am inpatient"}
  end

  koan "killing a process will terminate it" do
    pid = spawn(fn -> Process.exit(self(), :kill) end)
    :timer.sleep(500)
    refute Process.alive?(pid)
  end

  koan "killing a process kills it for good" do
    pid = spawn(fn -> receive do
                      end
    end)
    assert Process.alive?(pid)
    Process.exit(pid, :kill)
    refute Process.alive?(pid)
  end

  koan "can trap a signal in a child process" do
    parent = self()
    pid = spawn(fn ->
                      Process.flag(:trap_exit, true)
                      send parent, :ready
                      receive do
                        {:EXIT, _pid, reason} -> send parent, {:exited, reason}
                      end
    end)
    wait()
    Process.exit(pid, :random_reason)

    assert_receive {:exited, :random_reason}
    refute Process.alive?(pid)
  end

  koan "quitting normally has no effect" do
    pid = spawn(fn -> receive do
                      end
                end)
    Process.exit(pid, :normal)
    assert Process.alive?(pid)
  end

  koan "quititing your own process normally does terminate it though" do
    pid = spawn(fn -> receive do
                        :bye -> Process.exit(self(), :normal)
                      end
                end)

    assert Process.alive?(pid)
    send pid, :bye
    :timer.sleep(100)
    refute Process.alive?(pid)
  end

  koan "linked processes are informed about exit signals of children when trapping those signals" do
    parent = self()
    spawn(fn ->
            Process.flag(:trap_exit, true)
            spawn_link(fn -> Process.exit(self(), :normal) end)
            receive do
              {:EXIT, _pid ,reason} -> send parent, {:exited, reason}
            end
     end)

    assert_receive {:exited, :normal}
  end

  koan "monitoring processes are informed via messages without having trapping" do
    parent = self()
    spawn(fn ->
            spawn_monitor(fn -> Process.exit(self(), :normal) end)
            receive do
              {:DOWN, _ref, :process, _pid, reason} -> send parent, {:exited, reason}
            end
     end)

    assert_receive {:exited, :normal}
  end

  def wait do
    receive do
      :ready -> true
    end
  end
end
