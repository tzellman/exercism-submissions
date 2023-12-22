defmodule WineCellar do
  @options [
    white: "Fermented without skin contact.",
    red: "Fermented with skin contact using dark-colored grapes.",
    rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
  ]

  def explain_colors, do: @options

  def filter(cellar, color, opts \\ []) do
    wines = cellar |> Keyword.get_values(color)

    Enum.reduce(opts, wines, fn {key, value}, acc ->
      acc |> filter_by(key, value)
    end)
  end

  defp filter_by(wines, :year, year) do
    filter_by_year(wines, year)
  end

  defp filter_by(wines, :country, country) do
    filter_by_country(wines, country)
  end

  defp filter_by(wines, _option, _value), do: wines

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
