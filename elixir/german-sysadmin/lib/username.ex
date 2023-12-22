defmodule Username do
  @lowercase_alpha ?a..?z

  def sanitize(username) do
    username |> Enum.map(&sanitize_char/1) |> List.flatten()
  end

  defp sanitize_char(char) do
    case char do
      x when x in @lowercase_alpha -> x
      ?_ -> char
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      _ -> ~c""
    end
  end
end
