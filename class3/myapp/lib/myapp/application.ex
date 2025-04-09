defmodule MyApp.Application do
  use Application

  # =====EXERCISE 5=====
  @impl true
  def start(type, args) do
    children = [
      # StackSupervisor
      MyApp.Supervisor # this will cause tests 2 & 3 fail
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
