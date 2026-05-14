defmodule ShadowWeave.Parser do
  alias ShadowWeave.Conn

  def parse(request) do
    [top, params_string] = String.split(request, "\n\n", parts: 2)
    [request_line | header_lines] = String.split(top, "\n")
    [method, path, _] = String.split(request_line, " ")

    headers = parse_headers(header_lines)
    params = parse_params(headers["Content-Type"], params_string)

    %Conn{method: method, path: path, params: params, resp_body: "", status: nil}
  end

  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string
    |> String.trim()
    |> URI.decode_query()
  end

  def parse_params(_, _), do: %{}

  def parse_headers(header_lines) do
    Enum.reduce(header_lines, %{}, fn header_line, acc ->
      [header_key, header_value] = String.split(header_line, ": ", trim: true)
      Map.put(acc, header_key, header_value)
    end)
  end

  # def parse_headers(header_lines) do
  #   do_parse_headers(header_lines, %{})
  # end

  # defp do_parse_headers([], headers), do: headers

  # defp do_parse_headers([head | tail], headers) do
  #   [header_key, header_value] = String.split(head, ": ", trim: true)
  #   updated_headers = Map.put(headers, header_key, header_value)
  #   do_parse_headers(tail, updated_headers)
  # end
end
