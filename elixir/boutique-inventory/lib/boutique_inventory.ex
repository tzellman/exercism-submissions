defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory
    |> Enum.sort_by(& &1.price, :asc)
  end

  def with_missing_price(inventory) do
    inventory
    |> Enum.filter(&(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(fn item ->
      Map.update(item, :name, "", fn name ->
        String.replace(name, old_word, new_word)
      end)
    end)
  end

  def increase_quantity(item, count) do
    Map.update(item, :quantity_by_size, %{}, &(&1 |> increase_sizes(count)))
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_size, quantity}, acc ->
      acc + quantity
    end)
  end

  defp increase_sizes(quantities, count) do
    quantities
    |> Enum.into(%{}, fn {key, value} ->
      {key, value + count}
    end)
  end
end
