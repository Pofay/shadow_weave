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
end
