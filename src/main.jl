#!/usr/bin/env julia --project=.

using JuliaEchoServer

port = get(ENV, "PORT", "8000")

server = JuliaEchoServer.EchoServer(parse(Int, port))
JuliaEchoServer.listen(server)
