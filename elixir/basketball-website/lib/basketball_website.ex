defmodule BasketballWebsite do
  def extract_from_path(nil, _path), do: nil
  def extract_from_path(data, ""), do: data

  def extract_from_path(data, path) when is_map(data) and is_binary(path) do
    [key | rest] = String.split(path, ".")
    data[key] |> extract_from_path(rest |> Enum.join("."))
  end

  def get_in_path(data, path) do
    data |> get_in(String.split(path, "."))
  end
end
