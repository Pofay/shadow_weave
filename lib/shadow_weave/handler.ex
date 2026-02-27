defmodule ShadowWeave.Handler do
  def handle_request(request) do
    request
    |> parse()
    |> rewrite_path()
    |> log
    |> route()
    |> emojiify()
    |> track()
    |> format_response()
  end

  def log(conv), do: IO.inspect(conv)

  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{method: method, path: path, resp_body: "", status: nil}
  end

  def track(%{status: 404, path: path} = conv) do
    IO.puts("Warning: #{path} is on the loose!")
    conv
  end

  def track(conv), do: conv

  def rewrite_path(%{path: "/wildlife"} = conv) do
    %{conv | path: "/wildthings"}
  end

  def rewrite_path(%{path: "/owldbears?id=" <> id} = conv) do
    %{conv | path: "/owlbears/#{id}"}
  end

  def rewrite_path(conv), do: conv

  def route(%{method: "GET", path: "/about"} = conv) do
    %{conv | resp_body: "ABOUT PAGE.", status: 200}
  end

  def route(%{method: "GET", path: "/wildthings"} = conv) do
    %{conv | resp_body: "Owlbears, Beholders, Dragons", status: 200}
  end

  def route(%{method: "GET", path: "/owlbears"} = conv) do
    %{conv | resp_body: "Margot, Richter, Dario", status: 200}
  end

  def route(%{method: "GET", path: "/owlbears/" <> id} = conv) do
    %{conv | resp_body: "Owlbear #{id}", status: 200}
  end

  def route(%{method: "DELETE", path: "/owlbears/" <> id} = conv) do
    %{conv | resp_body: "You do not have the strength to kill Owlbear #{id}.", status: 403}
  end

  def route(%{method: _method, path: path, status: _status} = conv) do
    %{
      conv
      | resp_body: "Beware! You have entered Shar's Domain. 404 Error at #{path}",
        status: 404
    }
  end

  def format_response(conv) do
    """
    HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
    Content-Type: text/html
    Content-Length: #{byte_size(conv.resp_body)}

    #{conv.resp_body}
    """
  end

  def emojiify(%{status: 200} = conv) do
    %{conv | resp_body: "✨ #{conv.resp_body} ✨"}
  end

  def emojiify(%{status: 404} = conv) do
    %{conv | resp_body: "💀 #{conv.resp_body} 💀"}
  end

  def emojiify(%{status: 403} = conv) do
    %{conv | resp_body: "⛔ #{conv.resp_body} ⛔"}
  end

  def emojiify(conv), do: conv

  defp status_reason(code) do
    %{
      200 => "OK",
      404 => "Not Found",
      403 => "Forbidden"
    }[code]
  end
end

request = """
GET /wildlife HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

request2 = """
GET /owlbears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

request3 = """
GET /yeti HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

request4 = """
GET /owlbears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

request5 = """
DELETE /owlbears/2 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

request6 = """
GET /owldbears?id=3 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

request7 = """
GET /about HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = ShadowWeave.Handler.handle_request(request)
IO.puts(response)

response2 = ShadowWeave.Handler.handle_request(request2)
IO.puts(response2)

response3 = ShadowWeave.Handler.handle_request(request3)
IO.puts(response3)

response4 = ShadowWeave.Handler.handle_request(request4)
IO.puts(response4)

response5 = ShadowWeave.Handler.handle_request(request5)
IO.puts(response5)

response6 = ShadowWeave.Handler.handle_request(request6)
IO.puts(response6)

response6 = ShadowWeave.Handler.handle_request(request6)
IO.puts(response6)

response7 = ShadowWeave.Handler.handle_request(request7)
IO.puts(response7)
