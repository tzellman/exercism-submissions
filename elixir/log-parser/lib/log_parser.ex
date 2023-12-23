defmodule LogParser do
  def valid_line?(line) do
    line |> String.match?(~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/)
  end

  def split_line(line) do
    line |> String.split(~r/<[-*~=]*>/)
  end

  def remove_artifacts(line) do
    line |> String.replace(~r/end-of-line\d+/i, "")
  end

  def tag_with_user_name(line) do
    case Regex.run(~r/User\s+(\S+)/, line) do
      nil -> line
      [_, user] -> "[USER] #{user} " <> line
    end
  end
end
