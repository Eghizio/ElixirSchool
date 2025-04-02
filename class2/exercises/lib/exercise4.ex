defmodule Exercises.Exercise4 do
  @doc """
   Spawn a new process, register it under :hello name,
   wait for :ping message and send a :timeout msg to :test process after 500ms.
   input: none
   returns: pid

  to test run in console:
    mix test --only test4
  """
  def send_timeout() do
    # write your code here

    spawn(fn ->
      Process.register(self(), :hello)

      receive do
        :ping -> :pong
      after
        500 -> send(:test, :timeout)
      end

    end)

  end
end
