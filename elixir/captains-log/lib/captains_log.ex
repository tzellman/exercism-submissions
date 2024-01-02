defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class(), do: Enum.random(@planetary_classes)

  def random_ship_registry_number() do
    ship_number = (999 + :rand.uniform(9000)) |> Integer.to_string()
    "NCC-#{ship_number}"
  end

  def random_stardate() do
    41000.0 + :rand.uniform() * 1000.0
  end

  @spec format_stardate(float()) :: String.t()
  def format_stardate(stardate) do
    :io_lib.format("~.1f", [stardate]) |> to_string()
  end
end
