defmodule Darts do
  @radius_outer 10.0
  @radius_middle 5.0
  @radius_inner 1.0

  @points_outer 1
  @points_middle 5
  @points_inner 10

  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    :math.sqrt(x * x + y * y) |> score_by_radius()
  end

  defp score_by_radius(radius) when radius <= @radius_inner, do: @points_inner
  defp score_by_radius(radius) when radius <= @radius_middle, do: @points_middle
  defp score_by_radius(radius) when radius <= @radius_outer, do: @points_outer
  defp score_by_radius(_), do: 0
end
