defmodule ShadowWeave.Parser do
  alias ShadowWeave.Conn

  def parse(request) do
    [top, params] = String.split(request, "\n\n")

    [method, path, _] =
      top
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %Conn{method: method, path: path, resp_body: "", status: nil}
  end
end
