defmodule RPG.CharacterSheet do
  def welcome() do
    "Welcome! Let's fill out your character sheet together." |> IO.puts()
  end

  def ask_name() do
    "What is your character's name?" |> ask_question()
  end

  def ask_class() do
    "What is your character's class?" |> ask_question()
  end

  def ask_level() do
    "What is your character's level?" |> ask_question() |> String.to_integer()
  end

  def run() do
    with :ok <- welcome(),
         name <- ask_name(),
         class <- ask_class(),
         level <- ask_level(),
         character <- %{name: name, class: class, level: level} do
      character |> IO.inspect(label: "Your character")
    end
  end

  defp ask_question(question) do
    IO.gets(question <> "\n") |> String.trim()
  end
end
