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
    receive do
      message -> assert message == "hola!"
    end
  end

  koan "a spawned process is independent of the current process" do
    pid = spawn(fn -> receive do
                         {:hello, thing} -> assert thing == "world"
                         _ -> assert false
                      end
                 end)

    send pid, {:hello, "world"}
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
    parent = self
    spawn(fn -> receive do
                   _ -> assert false
                after
                  10 -> send parent, {:waited_too_long, "I am inpatient"}
                end
           end)

    assert_receive {:waited_too_long, "I am inpatient"}
  end
end
