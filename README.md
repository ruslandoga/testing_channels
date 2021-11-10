Getting:

```elixir
> mix test

...18:54:04.486 [error] Postgrex.Protocol (#PID<0.417.0>) disconnected: ** (DBConnection.ConnectionError) client #PID<0.485.0> exited


Finished in 0.04 seconds (0.04s async, 0.00s sync)
3 tests, 0 failures

Randomized with seed 427296
```

Expecting:

```elixir
> mix test

...18:54:04.486 [error] Postgrex.Protocol (#PID<0.417.0>) disconnected: ** (DBConnection.ConnectionError) client #PID<0.485.0> exited
Client #PID<0.491.0> is still using a connection from owner at location:

    ...stacktrace...

The connection itself was checked out by #PID<0.491.0> at location:

    ...stacktrace...


Finished in 0.04 seconds (0.04s async, 0.00s sync)
3 tests, 0 failures

Randomized with seed 427296
```
