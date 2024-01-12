defmodule Garden do
  @students [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    with rows <- parse_rows(info_string),
         plants_per_row <- rows |> Enum.reduce(0, &max(&1 |> length(), &2)),
         students_per_row <- plants_per_row |> div(2),
         students <- student_names |> Enum.sort() |> Enum.take(students_per_row),
         student_map <-
           student_names
           |> Enum.reduce(%{}, fn student, acc ->
             Map.put(acc, student, {})
           end) do
      students
      |> Enum.with_index()
      |> Enum.reduce(student_map, fn {student, index}, acc ->
        Map.put(
          acc,
          student,
          rows
          |> Enum.reduce([], fn row, acc -> acc ++ (row |> Enum.slice(index * 2, 2)) end)
          |> List.to_tuple()
        )
      end)
    end
  end

  defp parse_rows(info_string) do
    info_string
    |> String.split("\n")
    |> Enum.map(fn row ->
      row
      |> String.graphemes()
      |> Enum.map(fn plant ->
        plant
        |> plant_from_letter()
      end)
    end)
  end

  defp plant_from_letter("V"), do: :violets
  defp plant_from_letter("R"), do: :radishes
  defp plant_from_letter("C"), do: :clover
  defp plant_from_letter("G"), do: :grass
end
