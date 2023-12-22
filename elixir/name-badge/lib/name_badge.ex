defmodule NameBadge do
  @owner "OWNER"

  def print(id, name, department) do
    with id_str <- if(is_nil(id), do: nil, else: "[#{id}]"),
         department_str <- if(is_nil(department), do: @owner, else: String.upcase(department)) do
      [id_str, name, department_str]
      |> Enum.filter(fn x -> x end)
      |> Enum.join(" - ")
    end
  end
end
