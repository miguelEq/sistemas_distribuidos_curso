# TP crash

* [Enunciado ](https://gitlab.com/sistemas_distribuidos/curso/-/blob/master/labs/01-crash.md)

* ### Resolución al ejercicio de concurrencia 

``` erlang
    P = spawn(tic, first, []).

    P ! {toe, bar}.

    P ! {tac, gurka}.

    P ! {tic, foo}.
```

¿En qué orden fueron recibidos los mensajes? Notar como los mensajes son
encolados y como el proceso selecciona en que orden los procesa.


Se ejecutan en el siguiente orden respetando el orden de una queue:

``` erlang
    P ! {tic, foo}.

    P ! {toe, bar}.
   
    P ! {tac, gurka}.
```

* ### Resolución al ejercicio de PING-PONG

Levantar 2 shell de la siguiente manera(compilar en caso de que no se hallan compilado los modulos):

``` erlang
erl -name server1@ip-maquina -setcookie secret

pingpong:init_pong().
```

``` erlang
erl -name server2@ip-maquina -setcookie secret

pingpong:init_ping('server1@ip-maquina').
```