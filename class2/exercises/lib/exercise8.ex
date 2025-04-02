defmodule Exercises.Exercise8 do
  @doc """
   - Modify exercise7 by adding trap_exit to world process.
   - handle exit signal
    - send exit message to :test process
   - explain why :world process is alive or dead

   input: none
   returns: pid


  to test run in console:
     mix test --only test8
  """
  def process_link() do
    pid_hello =
      spawn(fn ->
        receive do
          :bad_msg -> raise("error")
          :die_normally -> :ok
        end
      end)

    Process.register(pid_hello, :hello)

    # write here your code
    pid_world =
      spawn(fn ->
        Process.register(self(), :world)
        Process.flag(:trap_exit, true)
        Process.link(pid_hello)

        Process.sleep(1_000)
        send(:hello, :bad_msg)

        receive do
          msg -> send(:test, msg)
        end

        receive do
          _ -> :ok
        end

        IO.inspect("Bye bye 🤫🧏‍♂️")
      end)

      spawn(fn ->
        Process.sleep(1_500)

        if Process.alive?(pid_world) do
          send(:test, ":world is alive!")
        else
          send(:test, ":world is dead!")
        end
      end)
  end
end
