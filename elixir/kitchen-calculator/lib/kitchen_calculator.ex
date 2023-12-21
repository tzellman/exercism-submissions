defmodule KitchenCalculator do
  @cup_to_milliliter 240
  @ounce_to_milliliter 30
  @teaspoon_to_milliliter 5
  @tablespoon_to_milliliter 15

  @type volume_pair :: {atom(), float()}

  @spec get_volume(volume_pair) :: float()
  def get_volume({_unit, volume}), do: volume

  @spec to_milliliter(volume_pair) :: {:milliliter, float()}
  def to_milliliter({unit, volume}) do
    {:milliliter, volume * unit_to_milliliter(unit)}
  end

  def from_milliliter({:milliliter, volume}, unit) when is_atom(unit) do
    {unit, volume / unit_to_milliliter(unit)}
  end

  def convert(volume_pair, unit) do
    volume_pair |> to_milliliter() |> from_milliliter(unit)
  end

  defp unit_to_milliliter(:cup), do: @cup_to_milliliter
  defp unit_to_milliliter(:fluid_ounce), do: @ounce_to_milliliter
  defp unit_to_milliliter(:teaspoon), do: @teaspoon_to_milliliter
  defp unit_to_milliliter(:tablespoon), do: @tablespoon_to_milliliter
  defp unit_to_milliliter(:milliliter), do: 1
  defp unit_to_milliliter(_), do: raise("Unknown unit")
end
