defmodule HandlerTest do
  use ExUnit.Case

  import ShadowWeave.Handler, only: [handle_request: 1]

  test "GET /wildlife" do
    request = """
    GET /wildlife HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 36

    ✨ Owlbears, Beholders, Dragons ✨
    """

    response = handle_request(request)

    assert response == expected
  end

  test "404 on unknown routes" do
    request = """
    GET /yeti HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected = """
    HTTP/1.1 404 Not Found
    Content-Type: text/html
    Content-Length: 68

    💀 Beware! You have entered Shar's Domain. 404 Error at /yeti 💀
    """

    response = handle_request(request)

    assert response == expected
  end

  test "GET /owlbears/1 returns the correct response" do
    request = """
    GET /owlbears/1 HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 104

    ✨ <h1>Show Owlbear</h1>
    <p>
    Name: Margot, Type: Forest
    Is Aggressive: <strong>false</strong>
    </p>
     ✨
    """

    response = handle_request(request)

    assert response == expected
  end

  test "DELETE /owlbears/2 returns the correct response" do
    request = """
    DELETE /owlbears/2 HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected = """
    HTTP/1.1 403 Forbidden
    Content-Type: text/html
    Content-Length: 64

    ⛔ You do not have the strength to kill Owlbear 2: Richter. ⛔
    """

    response = handle_request(request)

    assert response == expected
  end

  test "GET /owlbears?id=3 returns the correct response" do
    request = """
    GET /owldbears?id=3 HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 102

    ✨ <h1>Show Owlbear</h1>
    <p>
    Name: Dario, Type: Swamp
    Is Aggressive: <strong>false</strong>
    </p>
     ✨
    """

    response = handle_request(request)

    assert response == expected
  end
end
