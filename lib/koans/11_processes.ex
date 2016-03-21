defmodule Processes do
  use Koans

  koan "Tests run in a process" do
    assert Process.alive?(:__)
  end

  koan "You can ask a process to introduce itself" do
    information = Process.info(self)

    assert information[:status] == :__
  end

  koan "You can send messages to any process you want" do
    send self(), "hola!"
    assert_receive :__
  end

  koan "A common pattern is to include the sender in the message" do
    pid = spawn(fn -> receive do
                         {:hello, sender} -> send sender, :how_are_you?
                         _ -> assert false
                      end
                 end)

    send pid, {:hello, self()}
    assert_receive :__
  end

  koan "Waiting for a message can get boring" do
    parent = self()
    spawn(fn -> receive do
                   _anything -> flunk "I really wasn't expecting messages"
                after
                  10 -> send parent, {:waited_too_long, "I am inpatient"}
                end
           end)

    assert_receive :__
  end

  koan "Killing a process will terminate it" do
    pid = spawn(fn -> Process.exit(self(), :kill) end)
    :timer.sleep(500)
    assert Process.alive?(pid) == :__
  end

  koan "You can also terminate other processes than yourself" do
    pid = spawn(fn -> receive do end end)

    assert Process.alive?(pid) == :__
    Process.exit(pid, :kill)
    assert Process.alive?(pid) == :__
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
    wait()
    Process.exit(pid, :random_reason)

    assert_receive :__
  end

  koan "Trying to quit normally has no effect" do
    pid = spawn(fn -> receive do
                      end
                end)
    Process.exit(pid, :normal)
    assert Process.alive?(pid) == :__
  end

  koan "Exiting yourself on the other hand DOES termiante you" do
    pid = spawn(fn -> receive do
                        :bye -> Process.exit(self(), :normal)
                      end
                end)

    send pid, :bye
    :timer.sleep(100)
    assert Process.alive?(pid) == :__
  end

  koan "Parent processes can be informed about exiting children, if they trap and link" do
    parent = self()
    spawn(fn ->
            Process.flag(:trap_exit, true)
            spawn_link(fn -> Process.exit(self(), :normal) end)
            receive do
              {:EXIT, _pid ,reason} -> send parent, {:exited, reason}
            end
     end)

    assert_receive :__
  end

  koan "If you monitor your children, you'll be automatically informed for their depature" do
    parent = self()
    spawn(fn ->
            spawn_monitor(fn -> Process.exit(self(), :normal) end)
            receive do
              {:DOWN, _ref, :process, _pid, reason} -> send parent, {:exited, reason}
            end
     end)

    assert_receive :__
  end

  def wait do
    receive do
      :ready -> true
    end
  end
end
