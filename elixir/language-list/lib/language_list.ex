defmodule LanguageList do
  @elixir_language "Elixir"

  def new(), do: []

  def add(list, language) when is_list(list), do: [language | list]

  def remove([_lang | tail] = list) when is_list(list), do: tail

  def first([head | _tail] = list) when is_list(list), do: head

  def count(list) when is_list(list), do: length(list)

  def functional_list?(list) when is_list(list), do: @elixir_language in list
end
