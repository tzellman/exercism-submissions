# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{registrations: [], next_id: 1} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn %{registrations: registrations} -> registrations end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{registrations: registrations, next_id: next_id} ->
      plot = %Plot{registered_to: register_to, plot_id: next_id}
      {plot, %{registrations: [plot | registrations], next_id: next_id + 1}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn %{registrations: registrations} = state ->
      %{state | registrations: Enum.reject(registrations, &(&1.plot_id == plot_id))}
    end)
  end

  def get_registration(pid, plot_id) do
    case Agent.get(pid, fn %{registrations: registrations} ->
           Enum.find(registrations, &(&1.plot_id == plot_id))
         end) do
      nil -> {:not_found, "plot is unregistered"}
      plot -> plot
    end
  end
end
