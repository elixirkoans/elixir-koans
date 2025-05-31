defmodule Tasks do
  use Koans

  @intro "Tasks"

  koan "Tasks can be used for asynchronous computations with results" do
    task = Task.async(fn -> 3 * 3 end)
    do_other_stuff()
    assert Task.await(task) + 1 == ___
  end

  koan "If you don't need a result, use start_link/1" do
    {result, _pid} = Task.start_link(fn -> 1 + 1 end)
    assert result == ___
  end

  koan "Yield returns nil if the task isn't done yet" do
    handle =
      Task.async(fn ->
        :timer.sleep(100)
        3 * 3
      end)

    assert Task.yield(handle, 10) == ___
  end

  koan "Tasks can be aborted with shutdown" do
    handle =
      Task.async(fn ->
        :timer.sleep(100)
        3 * 3
      end)

    %Task{pid: pid} = handle
    Task.shutdown(handle)

    assert Process.alive?(pid) == ___
  end

  koan "Shutdown will give you an answer if it has it" do
    handle = Task.async(fn -> 3 * 3 end)
    :timer.sleep(10)
    assert Task.shutdown(handle) == {:ok, ___}
  end

  koan "You can yield to multiple tasks at once and extract the results" do
    squares =
      [1, 2, 3, 4]
      |> Enum.map(fn number -> Task.async(fn -> number * number end) end)
      |> Task.yield_many(100)
      |> Enum.map(fn {_task, {:ok, result}} -> result end)

    assert squares == ___
  end

  def do_other_stuff do
    :timer.sleep(50)
  end
end
