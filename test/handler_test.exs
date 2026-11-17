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

  test "/about returns the correct response" do
    request =
      """
      GET /about HTTP/1.1
      Host: example.com
      User-Agent: ExampleBrowser/1.0
      Accept: */*

      """

    expected = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 327

    ✨ <h1>Clark's Wildthings Refuge</h1>

    <blockquote>
    When we contemplate the whole globe as one great dewdrop,
    striped and dotted with continents and islands, flying
    through space with other stars all singing and shining
    together as one, the whole universe appears as an infinite
    storm of beauty. -- John Muir
    </blockquote> ✨
    """

    response = handle_request(request)

    assert response == expected
  end

  test "GET /api/owlbears" do
    request = """
    GET /api/owlbears HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = handle_request(request)

    expected_response = """
    HTTP/1.1 200 OK
    Content-Type: application/json
    Content-Length: 483

    ✨[{"id":1,"name":"Margot","type":"Forest","aggressive":false},
     {"id":2,"name":"Richter","type":"Mountain","aggressive":true},
     {"id":3,"name":"Dario","type":"Swamp","aggressive":false},
     {"id":4,"name":"Sophie","type":"Cave","aggressive":true},
     {"id":5,"name":"Luna","type":"Forest","aggressive":false},
     {"id":6,"name":"Gideon","type":"Mountain","aggressive":true},
     {"id":7,"name":"Isabella","type":"Swamp","aggressive":false},
     {"id":8,"name":"Aurora","type":"Cave","aggressive":true}]✨
    """

    assert remove_whitespace(response) == remove_whitespace(expected_response)
  end

  defp remove_whitespace(text) do
    String.replace(text, ~r{\s}, "")
  end
end
