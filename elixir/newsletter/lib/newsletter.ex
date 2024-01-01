defmodule Newsletter do
  def read_emails(path) do
    File.read!(path) |> String.split("\n") |> Enum.map(&String.trim/1) |> Enum.reject(&(&1 == ""))
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    with emails <- read_emails(emails_path),
         pid <- open_log(log_path) do
      Enum.each(emails, &maybe_send_and_log(&1, send_fun, pid))
      close_log(pid)
    end
  end

  defp maybe_send_and_log(email, send_fun, pid) do
    case send_fun.(email) do
      :ok -> log_sent_email(pid, email)
      _ -> :ok
    end
  end
end
