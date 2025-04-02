defmodule Exercises.Exercise9 do
  @doc """
   Spawn :server process, which endlessly handles messages.
   Sever should pass messages to :test process.
   When server gets exit singal, then it should send :handle_exit message to :test process.
   Server should send :nothing_todo message to :test process after 500ms inactivity.
   Spawn unregistered client process which sends to server 10 messages


  to test run in console:
    mix test --only test9
  """
  def server() do
    # write your code here
    spawn(fn ->
      Process.register(self(), :server)
      Process.flag(:trap_exit, true)

      handle_msgs = fn f ->
        receive do
          {:EXIT, _, _} -> send(:test, :handle_exit)
          msg -> send(:test, msg)
        after
          500 -> send(:test, :nothing_todo)
        end

        f.(f)
      end

      handle_msgs.(handle_msgs)
    end)
  end

  def client() do
    # write your code here
    spawn(fn ->
      Enum.each(1..10, fn n -> send(:server, "Hello there #{n}") end)
    end)
  end
end
