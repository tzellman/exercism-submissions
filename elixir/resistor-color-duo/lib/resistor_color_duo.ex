defmodule ResistorColorDuo do
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value([first_color, second_color | _rest] = _colors) do
    color_to_number(first_color) * 10 + color_to_number(second_color)
  end

  defp color_to_number(:black), do: 0
  defp color_to_number(:brown), do: 1
  defp color_to_number(:red), do: 2
  defp color_to_number(:orange), do: 3
  defp color_to_number(:yellow), do: 4
  defp color_to_number(:green), do: 5
  defp color_to_number(:blue), do: 6
  defp color_to_number(:violet), do: 7
  defp color_to_number(:grey), do: 8
  defp color_to_number(:white), do: 9
end
