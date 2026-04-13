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

    assert String.contains?(response, "404 Not Found")
    assert String.contains?(response, "404 Error at /pages/form")
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
    assert String.contains?(response, "404 Error at /pages/doesnotexist")
  end

  test "request to /owlbears" do
    request = """
    GET /owlbears HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = ShadowWeave.Handler.handle_request(request)

    assert String.contains?(response, "200 OK")
    assert String.contains?(response, "Margot, Richter, Dario")
  end

  test "functions that match on structs don't work with maps" do
    conv = %{method: "GET", path: "/owlbears/new"}

    assert_raise FunctionClauseError, fn ->
      ShadowWeave.Handler.route(conv)
    end
  end
end
