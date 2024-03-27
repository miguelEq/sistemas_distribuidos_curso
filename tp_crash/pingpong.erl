-module(pingpong).
-export([init_ping/1, init_pong/0, ping/1, pong/0]).

ping(Node_pong) ->
    {pong, Node_pong} ! self(),
    receive
        Pid_pong ->
            io:format("receive pong ~n", []),
            Pid_pong ! finished
    end.

pong() ->
    receive
        finished ->
            io:format("end ping-pong", []);
        Pid_ping ->
            io:format("receive ping: ~n", []),
            Pid_ping ! self(),
            pong()
    end.

init_pong()->
    register(pong, spawn(pingpong, pong, [])). 

init_ping(Node_pong)-> 
    spawn(pingpong, ping, [Node_pong]).