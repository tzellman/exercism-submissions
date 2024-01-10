defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the #{get_day(number)} day of Christmas my true love gave to me: #{get_gifts(number)}."
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    Enum.map(starting_verse..ending_verse, &verse/1) |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end

  defp get_day(1), do: "first"
  defp get_day(2), do: "second"
  defp get_day(3), do: "third"
  defp get_day(4), do: "fourth"
  defp get_day(5), do: "fifth"
  defp get_day(6), do: "sixth"
  defp get_day(7), do: "seventh"
  defp get_day(8), do: "eighth"
  defp get_day(9), do: "ninth"
  defp get_day(10), do: "tenth"
  defp get_day(11), do: "eleventh"
  defp get_day(12), do: "twelfth"

  defp get_gift(1), do: "a Partridge in a Pear Tree"
  defp get_gift(2), do: "two Turtle Doves"
  defp get_gift(3), do: "three French Hens"
  defp get_gift(4), do: "four Calling Birds"
  defp get_gift(5), do: "five Gold Rings"
  defp get_gift(6), do: "six Geese-a-Laying"
  defp get_gift(7), do: "seven Swans-a-Swimming"
  defp get_gift(8), do: "eight Maids-a-Milking"
  defp get_gift(9), do: "nine Ladies Dancing"
  defp get_gift(10), do: "ten Lords-a-Leaping"
  defp get_gift(11), do: "eleven Pipers Piping"
  defp get_gift(12), do: "twelve Drummers Drumming"

  defp get_gifts(1), do: get_gift(1)

  defp get_gifts(number) do
    all_but_last = number..2//-1 |> Enum.map(&get_gift/1) |> Enum.join(", ")
    "#{all_but_last}, and #{get_gift(1)}"
  end
end
