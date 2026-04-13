defmodule ShadowWeave.Parser do
  alias ShadowWeave.Conn

  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %Conn{method: method, path: path, resp_body: "", status: nil}
  end
end
