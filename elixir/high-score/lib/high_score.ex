defmodule HighScore do
  def new(), do: %{}

  def add_player(scores, name, score \\ 0) do
    scores |> Map.put(name, score)
  end

  def remove_player(scores, name) do
    scores |> Map.delete(name)
  end

  def reset_score(scores, name) do
    scores |> Map.update(name, 0, fn _ -> 0 end)
  end

  def update_score(scores, name, score \\ 0) do
    scores |> Map.update(name, score, &(&1 + score))
  end

  def get_players(scores) do
    scores |> Map.keys()
  end
end
