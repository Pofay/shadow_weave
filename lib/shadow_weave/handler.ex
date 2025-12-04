defmodule ShadowWeave.Handler do
  def handle_request(request) do
    request
    |> parse()
    |> route()
    |> format_response()
  end

  def parse(request) do
    conv = %{method: "GET", path: "/wildthings", resp_body: ""}
  end

  def route(conv) do
    conv = %{method: "GET", path: "/wildthings", resp_body: "Owlbears, Beholders, Dragons"}
  end

  def format_response(conv) do
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20

    Owlbears, Beholders, Dragons
    """
  end
end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

expected_response = """
HTTP/1.1 200 OK
Content-Type: text/html
Content-Length: 20

Owlbears, Beholders, Dragons
"""

response = ShadowWeave.Handler.handle_request(request)
IO.puts(response)
