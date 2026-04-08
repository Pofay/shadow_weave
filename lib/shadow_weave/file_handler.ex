defmodule ShadowWeave.FileHandler do
  def handle_file(file) do
    case File.read(file) do
      {:ok, content} -> {200, content}
      {:error, :enoent} -> {404, "Page not found."}
      {:error, reason} -> {500, "Cannot read from the void: #{reason}"}
    end
  end
end
