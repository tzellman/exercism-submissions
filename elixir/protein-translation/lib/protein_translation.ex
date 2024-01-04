defmodule ProteinTranslation do
  @known_codons %{
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UGG" => "Tryptophan",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) do
    with proteins when is_list(proteins) <-
           rna
           |> String.split("", trim: true)
           |> Enum.chunk_every(3)
           |> Enum.map(&Enum.join(&1, ""))
           |> Enum.reduce_while([], fn codon, acc ->
             case of_codon(codon) do
               {:ok, "STOP"} -> {:halt, acc}
               {:ok, protein} -> {:cont, [protein | acc]}
               {:error, _} -> {:halt, {:error, "invalid RNA"}}
             end
           end) do
      {:ok, proteins |> Enum.reverse()}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    case @known_codons[codon |> String.upcase()] do
      nil -> {:error, "invalid codon"}
      protein -> {:ok, protein}
    end
  end
end
