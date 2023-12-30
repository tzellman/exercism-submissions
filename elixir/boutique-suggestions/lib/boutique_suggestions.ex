defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    for top <- tops,
        bottom <- bottoms,
        filter_clashing_colors(top, bottom) and
          filter_price(top, bottom, options[:maximum_price] || 100.0),
        do: {top, bottom}
  end

  defp filter_price(top, bottom, max_price),
    do: top.price + bottom.price <= max_price

  defp filter_clashing_colors(%{base_color: color}, %{base_color: color}), do: false
  defp filter_clashing_colors(_, _), do: true
end
