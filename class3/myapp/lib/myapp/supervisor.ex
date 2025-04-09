defmodule MyApp.Supervisor do
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  # =====EXERCISE 4=====
  @impl true
  def init(initial_state) do
    children = [
      %{
        id: MyApp.ShopInventory,
        start: {MyApp.ShopInventory, :start_link, [initial_state]}
      }
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
