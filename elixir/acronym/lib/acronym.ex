defmodule Acronym do
  @moduledoc """
  Generate acronyms from strings.
  """

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(~r/[\s-]+/)
    |> Enum.map(&String.replace(&1, ~r/[^A-Za-z]+/, ""))
    |> Enum.map(&String.slice(&1, 0, 1))
    |> Enum.join("")
    |> String.upcase()
  end
end
