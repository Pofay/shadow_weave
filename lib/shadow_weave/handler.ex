defmodule ShadowWeave.Handler do
  alias ShadowWeave.Conn

  @moduledoc """
  Handles HTTP requests.
  """
  import ShadowWeave.Plugins, only: [rewrite_path: 1, log: 1, track: 1, emojify: 1]
  import ShadowWeave.Parser, only: [parse: 1]
  import ShadowWeave.FileHandler, only: [handle_file: 1]

  @pages_path Path.expand("pages", File.cwd!())

  @doc """
  Transforms the request into a response.
  """
  def handle_request(request) do
    request
    |> parse()
    |> rewrite_path()
    |> log()
    |> route()
    |> emojify()
    |> track()
    |> format_response()
  end

  # Purely academic..
  # def route(%{method: "GET", path: "/pages/" <> file} = conv) do
  #   {status, content} =
  #     Path.expand("../../pages", __DIR__)
  #     |> Path.join(file <> ".html")
  #     |> read_file()

  #   %{conv | resp_body: content, status: status}
  # end

  def route(%Conn{method: "GET", path: "/owlbears/new"} = conv) do
    {status, content} =
      @pages_path
      |> Path.join("form.html")
      |> handle_file()

    %{conv | resp_body: content, status: status}
  end

  def route(%Conn{method: "POST", path: "/owlbears"} = conv) do
    params = %{"name" => "Baloo", "type" => "Silver"}
    %Conn{conv | resp_body: "Created a #{params["type"]} Owlbear named #{params["name"]}!", status: 201}
  end

  def route(%Conn{method: "GET", path: "/about"} = conv) do
    {status, content} =
      @pages_path
      |> Path.join("about.html")
      |> handle_file()

    %Conn{conv | resp_body: content, status: status}
  end

  def route(%Conn{method: "GET", path: "/wildthings"} = conv) do
    %Conn{conv | resp_body: "Owlbears, Beholders, Dragons", status: 200}
  end

  def route(%Conn{method: "GET", path: "/owlbears"} = conv) do
    %Conn{conv | resp_body: "Margot, Richter, Dario", status: 200}
  end

  def route(%Conn{method: "GET", path: "/owlbears/" <> id} = conv) do
    %Conn{conv | resp_body: "Owlbear #{id}", status: 200}
  end

  def route(%Conn{method: "DELETE", path: "/owlbears/" <> id} = conv) do
    %Conn{conv | resp_body: "You do not have the strength to kill Owlbear #{id}.", status: 403}
  end

  def route(%Conn{method: _method, path: path, status: _status} = conv) do
    %Conn{
      conv
      | resp_body: "Beware! You have entered Shar's Domain. 404 Error at #{path}",
        status: 404
    }
  end

  def format_response(%Conn{} = conv) do
    """
    HTTP/1.1 #{conv.status} #{status_reason(conv.status)}
    Content-Type: text/html
    Content-Length: #{byte_size(conv.resp_body)}

    #{conv.resp_body}
    """
  end

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

request8 = """
GET /owlbears/new HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

request9 = """
GET /pages/form HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

request10 = """
GET /pages/doesnotexist HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

request11 = """
POST /pages/owlbears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded
Content-Length: 21

name=Baloo&type=Silver
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

response8 = ShadowWeave.Handler.handle_request(request8)
IO.puts(response8)

response9 = ShadowWeave.Handler.handle_request(request9)
IO.puts(response9)

response10 = ShadowWeave.Handler.handle_request(request10)
IO.puts(response10)

response11 = ShadowWeave.Handler.handle_request(request11)
IO.puts(response11)
