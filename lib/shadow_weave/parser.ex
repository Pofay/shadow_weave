defmodule ShadowWeave.Parser do
  alias ShadowWeave.Conn

  def parse(request) do
    [top, params_string] = String.split(request, "\n\n", parts: 2)

    [request_line | _header_lines ] = String.split(top, "\n")

    [method, path, _] = String.split(request_line, " ")

    params = parse_params(params_string)
    %Conn{method: method, path: path, params: params, resp_body: "", status: nil}
  end

  def parse_params(params_string) do
    params_string
    |> String.trim
    |> URI.decode_query()
  end
end
