# template-golang

This is a starter template for building Go applications. It contains a simple http server.

The project is configured to be started via Docker. To start the server in the release mode, run the following command:

```bash
docker compose -f compose.yaml -f compose.release.yaml up --build
```

Or to start the server locally:

```bash
./run.sh run::locally
```

You can then access the API documentation at `http://localhost:<WEBAPI_PORT>/`. Note, that the `WEBAPI_PORT` is configurable via the dotenv file, `env/example.env` is used by default.
