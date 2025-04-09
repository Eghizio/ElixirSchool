defmodule MyApp.ShopInventory do
  use GenServer

  alias MyApp.Item

  # =====EXERCISE 2=====
  # Client API
  # def start_link(initial_state) when is_list(initial_state) do
  #   # Your code here
  #   GenServer.start_link(__MODULE__, initial_state)
  # end

  def create_item(pid, item) do
    # Your code here
    GenServer.cast(pid, {:create_item, item})
  end

  def list_items(pid) do
    # Your code here
    GenServer.call(pid, :list_items)
  end

  def delete_item(pid, item) do
    # Your code here
    GenServer.cast(pid, {:delete_item, item})
  end

  def get_item_by_name(pid, name) do
    # Your code here
    GenServer.call(pid, {:get_item_by_name, name})
  end

  # =====EXERCISE 3=====
  def start_link(initial_state) when is_list(initial_state) do
    # Your code here
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def create_item(item) do
    # Your code here
    GenServer.cast(__MODULE__, {:create_item, item})
  end

  def list_items() do
    # Your code here
    GenServer.call(__MODULE__, :list_items)
  end

  def delete_item(item) do
    # Your code here
    GenServer.cast(__MODULE__, {:delete_item, item})
  end

  def get_item_by_name(name) do
    # Your code here
    GenServer.call(__MODULE__, {:get_item_by_name, name})
  end

  # =====EXERCISE 1=====
  # Server API
  @impl true
  def init(initial_state)when is_list(initial_state) do
    # Your code here
    {:ok, initial_state}
  end

  @impl true
  def handle_call(:list_items, from, state) do
    # Your code here
    {:reply, state, state}
  end

  def handle_call({:get_item_by_name, name}, from, state) do
    # Your code here
    item =
      state
      |> Enum.filter(fn %MyApp.Item{name: ^name} -> true; _ -> false end)
      |> List.first(:nil)

    # item = Enum.find(items, fn %MyApp.Item{name: n} -> name == n end)

    {:reply, item, state}
  end

  @impl true
  def handle_cast({:create_item, item}, state) do
    # Your code here
    {:noreply, state ++ [item]}

    # {:noreply, [item | state]}
  end

  def handle_cast({:delete_item, item}, state) do
    # Your code here
    %{name: name, price: price} = item

    updated_state =
      state
      |> Enum.filter(fn %MyApp.Item{name: ^name, price: ^price} -> false; _ -> true end)

    # updated_state =
    #   state |> List.delete(item)

    {:noreply, updated_state}
  end

  # For supervisor testing
  def handle_cast(:crash, state) do
    throw(:error)
  end
end
