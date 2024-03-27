-module(rudy).

-export([init/1]).

init(Port) ->
    Opt = [list, {active, false}, {reuseaddr, true}],
    case gen_tcp:listen(Port, Opt) of
        {ok, Listen} ->
            handler(Listen),
            gen_tcp:close(Listen),
            ok;
        {error, Error} ->
            io:format("rudy: error init: ~w~n", [Error])
    end.

handler(Listen) ->
    case gen_tcp:accept(Listen) of
        {ok, Client} ->
            spawn(fun() -> request(Client) end),
            handler(Listen);
        {error, Error} ->
            io:format("rudy: error handler: ~w~n", [Error])
    end.

request(Client) ->
    Recv = gen_tcp:recv(Client, 0),
    case Recv of
        {ok, Str} ->
            {Request, _, _} = http:parse_request(Str),
            %Response = reply(Request),
            gen_tcp:send(Client, http:ok("todo bien"));
        {error, Error} ->
            io:format("rudy: error request: ~w~n", [Error])
    end,
    gen_tcp:close(Client).

reply({{get, URI, _}, _, _}) ->
    http:get(URI).
