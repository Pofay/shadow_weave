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

  test "GET /owlbears" do
    request = """
    GET /owlbears HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    expected = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 940

    ✨ <h1>All the Owlbears!</h1>

    <ul>
      
        <li>Aurora - Cave</li>
      
        <li>Dario - Swamp</li>
      
        <li>Gideon - Mountain</li>
      
        <li>Isabella - Swamp</li>
      
        <li>Luna - Forest</li>
      
        <li>Margot - Forest</li>
      
        <li>Richter - Mountain</li>
      
        <li>Sophie - Cave</li>
      
    </ul>

    [%ShadowWeave.Owlbear{id: 8, name: "Aurora", type: "Cave", aggressive: true}, %ShadowWeave.Owlbear{id: 3, name: "Dario", type: "Swamp", aggressive: false}, %ShadowWeave.Owlbear{id: 6, name: "Gideon", type: "Mountain", aggressive: true}, %ShadowWeave.Owlbear{id: 7, name: "Isabella", type: "Swamp", aggressive: false}, %ShadowWeave.Owlbear{id: 5, name: "Luna", type: "Forest", aggressive: false}, %ShadowWeave.Owlbear{id: 1, name: "Margot", type: "Forest", aggressive: false}, %ShadowWeave.Owlbear{id: 2, name: "Richter", type: "Mountain", aggressive: true}, %ShadowWeave.Owlbear{id: 4, name: "Sophie", type: "Cave", aggressive: true}]
     ✨
    """

    response = handle_request(request)

    assert response == expected
  end
end
