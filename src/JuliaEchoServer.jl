module JuliaEchoServer

using HTTP, HTTP.Messages
using JSON

const HOST = "0.0.0.0"
const PORT = 8081
mutable struct EchoServer
  host::String
  port::Int64
end
EchoServer() = EchoServer(HOST, PORT)
EchoServer(host::String) = EchoServer(host, PORT)
EchoServer(port::Int64) = EchoServer(HOST, port)

listen(self::EchoServer) = begin
  println("start listening on $(self.host):$(self.port)")
  HTTP.serve(self.host, self.port) do req::HTTP.Request
    println("receive request $req")
    headers = [
      "Content-Type" => "application/json"
    ]
    body = Dict(
      "method" => req.method,
      "target" => req.target,
      "headers" => req.headers,
      "body" => String(req.body),
    )
    return HTTP.Response(200, headers, body = JSON.json(body))
  end
end

end # module
