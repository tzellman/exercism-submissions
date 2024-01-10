defmodule Gigasecond do
  @gigasecond 1_000_000_000
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    with date <- Date.new!(year, month, day),
         time <- Time.new!(hours, minutes, seconds),
         datetime <- DateTime.new!(date, time) |> DateTime.add(@gigasecond, :second),
         date <- datetime |> DateTime.to_date(),
         time <- datetime |> DateTime.to_time() do
      {{date.year, date.month, date.day}, {time.hour, time.minute, time.second}}
    end
  end
end
