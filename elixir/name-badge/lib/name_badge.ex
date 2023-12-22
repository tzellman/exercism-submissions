defmodule NameBadge do
  @owner "owner"

  def print(id, name, department) do
    [id_str(id), name, department_str(department)]
    |> Enum.filter(fn x -> x end)
    |> Enum.join(" - ")
  end

  defp id_str(nil), do: nil
  defp id_str(id), do: "[#{id}]"

  defp department_str(nil), do: department_str(@owner)
  defp department_str(department), do: department |> String.upcase()
end
