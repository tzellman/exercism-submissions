defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    %Matrix{
      matrix:
        input
        |> String.split("\n")
        |> Enum.map(fn row -> row |> String.split() |> Enum.map(&String.to_integer/1) end)
    }
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
    matrix.matrix
    |> Enum.map(fn row -> row |> Enum.map(&Integer.to_string/1) |> Enum.join(" ") end)
    |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix), do: matrix.matrix

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index) do
    matrix.matrix |> Enum.at(index - 1)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
    max_width =
      Enum.reduce(matrix.matrix, 0, fn row, acc ->
        max(acc, row |> length())
      end)

    (max_width - 1)..0
    |> Enum.reduce([], fn index, acc ->
      [matrix.matrix |> Enum.map(fn row -> Enum.at(row, index) end) | acc]
    end)
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    matrix.matrix |> Enum.map(fn row -> Enum.at(row, index - 1) end)
  end
end
