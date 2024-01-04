defmodule WordSearch do
  defmodule Location do
    defstruct [:from, :to]

    @type t :: %Location{
            from: %{row: integer, column: integer},
            to: %{row: integer, column: integer}
          }
  end

  defmodule Letter do
    defstruct [:letter, :col, :row]

    @type t :: %Letter{
            letter: String.t(),
            col: integer,
            row: integer
          }
  end

  @doc """
  Find the start and end positions of words in a grid of letters.
  Row and column positions are 1 indexed.
  """
  @spec search(grid :: String.t(), words :: [String.t()]) :: %{String.t() => nil | Location.t()}
  def search(grid, words) do
    with rows <- grid |> parse_grid_to_rows(),
         cols <- rows |> Enum.zip() |> Enum.map(&Tuple.to_list/1),
         words <- words |> Enum.map(&normalize/1) do
      find_words(%{}, rows, words)
      |> find_words(cols, words)
      |> find_words(get_diagonals(rows), words)
    end
  end

  defp parse_grid_to_rows(grid) do
    grid
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.with_index()
    |> Enum.map(fn {row, row_index} ->
      row
      |> normalize()
      |> Enum.with_index()
      |> Enum.map(fn {letter, col_index} ->
        %Letter{letter: letter, col: col_index + 1, row: row_index + 1}
      end)
    end)
  end

  defp normalize(string) do
    string |> String.downcase() |> String.graphemes()
  end

  defp find_words(found_map, rows, words) do
    Enum.reduce(words, found_map, fn word, acc ->
      word_string = to_string(word)

      rows
      |> Enum.reduce(acc, fn row, acc ->
        replace_if_nil(acc, word_string, fn ->
          find_row_word(row, word)
        end)
      end)
    end)
  end

  defp get_diagonals(rows) do
    get_diagonals(:southeast, rows) ++
      get_diagonals(:northeast, rows) ++
      get_diagonals(:southwest, rows) ++
      get_diagonals(:northwest, rows)
  end

  defp get_diagonals(:southeast, rows) do
    rows
    |> Enum.with_index()
    |> Enum.map(fn {_row, index} ->
      index..0 |> Enum.zip(rows) |> Enum.map(&Enum.at(elem(&1, 1), elem(&1, 0))) |> Enum.reverse()
    end)
  end

  defp get_diagonals(:southwest, rows) do
    rows
    |> Enum.with_index()
    |> Enum.map(fn {row, index} ->
      row_length = length(row)

      index..0
      |> Enum.zip(rows)
      |> Enum.map(&Enum.at(elem(&1, 1), row_length - elem(&1, 0) - 1))
    end)
  end

  defp get_diagonals(:northeast, rows) do
    get_diagonals(:southeast, rows |> Enum.reverse())
  end

  defp get_diagonals(:northwest, rows) do
    get_diagonals(:southwest, rows |> Enum.reverse())
  end

  defp replace_if_nil(map, key, func) do
    case Map.get(map, key, nil) do
      nil ->
        map
        |> Map.put(key, func.())

      _ ->
        map
    end
  end

  defp find_row_word(row, word) do
    word_length = length(word)
    indexes = 0..(length(row) - length(word))
    reverse = row |> Enum.reverse()

    tries =
      Enum.reduce(indexes, [], fn index, acc ->
        [
          Enum.drop(row, index) |> Enum.take(word_length),
          Enum.drop(reverse, index) |> Enum.take(word_length) | acc
        ]
      end)

    case Enum.find(tries, fn letters ->
           match_word = letters |> Enum.reject(&is_nil/1) |> Enum.map(& &1.letter)
           match_word == word
         end) do
      nil ->
        nil

      letters ->
        with h <- letters |> List.first(),
             t <- letters |> List.last() do
          %Location{
            from: %{row: h.row, column: h.col},
            to: %{row: t.row, column: t.col}
          }
        end
    end
  end
end
