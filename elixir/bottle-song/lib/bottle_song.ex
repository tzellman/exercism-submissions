defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(start_bottle, take_down) do
    Enum.map(start_bottle..(start_bottle - take_down + 1), &verse/1) |> Enum.join("\n\n")
  end

  defp verse(bottle) when bottle > 0 do
    with current_bottle <- to_english(bottle) |> String.capitalize(),
         next_bottle <- to_english(bottle - 1),
         current_bottle_inflected <- inflect(bottle, "bottle"),
         next_bottle_inflected <- inflect(bottle - 1, "bottle") do
      """
      #{current_bottle} green #{current_bottle_inflected} hanging on the wall,
      #{current_bottle} green #{current_bottle_inflected} hanging on the wall,
      And if one green bottle should accidentally fall,
      There'll be #{next_bottle} green #{next_bottle_inflected} hanging on the wall.\
      """
    end
  end

  defp to_english(10), do: "ten"
  defp to_english(9), do: "nine"
  defp to_english(8), do: "eight"
  defp to_english(7), do: "seven"
  defp to_english(6), do: "six"
  defp to_english(5), do: "five"
  defp to_english(4), do: "four"
  defp to_english(3), do: "three"
  defp to_english(2), do: "two"
  defp to_english(1), do: "one"
  defp to_english(0), do: "no"

  defp inflect(1, word), do: word
  defp inflect(_, word), do: word <> "s"
end
