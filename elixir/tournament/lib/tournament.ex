defmodule Tournament do
  defmodule Team do
    defstruct name: "", wins: 0, draws: 0, losses: 0, points: 0
  end

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.filter(&(&1 != nil))
    |> Enum.reduce(%{}, &score_match/2)
    |> Map.values()
    |> Enum.sort(&sort_teams/2)
    |> Enum.map(&format_team/1)
    |> add_table_header()
    |> Enum.join("\n")
  end

  defp parse_line(line) do
    case String.split(line, ";") do
      [team1, team2, result] when result in ~w"win loss draw" -> {team1, team2, result}
      _ -> nil
    end
  end

  defp score_match({team1, team2, result}, teams) do
    with team1 <- teams |> Map.get(team1, %Team{name: team1}),
         team2 <- teams |> Map.get(team2, %Team{name: team2}) do
      teams
      |> Map.put(team1.name, update_team(team1, result))
      |> Map.put(team2.name, update_team(team2, opposite_result(result)))
    end
  end

  defp update_team(%Team{} = team, "win") do
    %Team{team | wins: team.wins + 1, points: team.points + 3}
  end

  defp update_team(%Team{} = team, "loss") do
    %Team{team | losses: team.losses + 1}
  end

  defp update_team(%Team{} = team, "draw") do
    %Team{team | draws: team.draws + 1, points: team.points + 1}
  end

  defp opposite_result("win"), do: "loss"
  defp opposite_result("loss"), do: "win"
  defp opposite_result("draw"), do: "draw"

  defp sort_teams(team1, team2) do
    if team1.points == team2.points do
      String.downcase(team1.name) < String.downcase(team2.name)
    else
      team1.points >= team2.points
    end
  end

  defp format_team(%Team{name: name, wins: wins, draws: draws, losses: losses, points: points}) do
    [
      name,
      Integer.to_string(wins + draws + losses),
      Integer.to_string(wins),
      Integer.to_string(draws),
      Integer.to_string(losses),
      Integer.to_string(points)
    ]
    |> format_row()
  end

  defp add_table_header(table) do
    [
      ["Team", "MP", "W", "D", "L", "P"] |> format_row()
      | table
    ]
  end

  defp format_row([team, matches, wins, draws, losses, points]) do
    [
      String.pad_trailing(team, 30),
      String.pad_leading(matches, 2),
      String.pad_leading(wins, 2),
      String.pad_leading(draws, 2),
      String.pad_leading(losses, 2),
      String.pad_leading(points, 2)
    ]
    |> Enum.join(" | ")
  end
end
