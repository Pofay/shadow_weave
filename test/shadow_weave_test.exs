defmodule ShadowWeaveTest do
  use ExUnit.Case
  doctest ShadowWeave

  test "request to /pages/form" do
    request = """
    GET /pages/form HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = ShadowWeave.Handler.handle_request(request)

    assert String.contains?(response, "200 OK")
  end

  test "request to /pages/doesnotexist" do
    request = """
    GET /pages/doesnotexist HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = ShadowWeave.Handler.handle_request(request)

    assert String.contains?(response, "404 Not Found")
  end
end
