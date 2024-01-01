defmodule FileSniffer do
  @media_types %{
    "exe" => "application/octet-stream",
    "bmp" => "image/bmp",
    "png" => "image/png",
    "jpg" => "image/jpg",
    "gif" => "image/gif"
  }

  @elf_header <<0x7F, 0x45, 0x4C, 0x46>>
  @bmp_header <<0x42, 0x4D>>
  @png_header <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>
  @gif_header <<0x47, 0x49, 0x46>>
  @jpg_header <<0xFF, 0xD8, 0xFF>>

  def type_from_extension(extension),
    do: @media_types[extension |> String.downcase()]

  def type_from_binary(<<@bmp_header, _rest::binary>>), do: type_from_extension("bmp")
  def type_from_binary(<<@elf_header, _rest::binary>>), do: type_from_extension("exe")
  def type_from_binary(<<@png_header, _rest::binary>>), do: type_from_extension("png")
  def type_from_binary(<<@gif_header, _rest::binary>>), do: type_from_extension("gif")
  def type_from_binary(<<@jpg_header, _rest::binary>>), do: type_from_extension("jpg")
  def type_from_binary(_), do: nil

  def verify(file_binary, extension) do
    with binary_type <- type_from_binary(file_binary),
         ext_type <- type_from_extension(extension),
         true <- binary_type == ext_type and not is_nil(binary_type) do
      {:ok, ext_type}
    else
      _ -> {:error, "Warning, file format and file extension do not match."}
    end
  end
end
