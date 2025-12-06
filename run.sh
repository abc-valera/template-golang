#!/usr/bin/env bash

# run.sh is written using an eponymous pattern for organizing project’s CLI commands.
# Read more: https://run.jotaen.net/

# Load env from dotenv files
[[ -f ./env/example.env ]] && set -a && source ./env/example.env && set +a
[[ -f ./env/.env ]] && set -a && source ./env/.env && set +a

run::locally() {
	go run ./src/cmd
}

run::webapi:dev() {
	docker compose -f compose.yaml -f compose.dev.yaml up --build
}

run::webapi:dev:stop() {
	docker compose -f compose.yaml -f compose.dev.yaml stop
}

run::webapi:dev:down() {
	echo_warning
	docker compose -f compose.yaml -f compose.dev.yaml down -v
}

run::webapi:release() {
	docker compose -f compose.yaml -f compose.release.yaml up --build
}

run::webapi:release:stop() {
	echo_warning
	docker compose -f compose.yaml -f compose.release.yaml stop
}

run::webapi:release:down() {
	echo_warning
	docker compose -f compose.yaml -f compose.release.yaml down -v
}

run::pprof:cpu() {
	go tool pprof -http=:3010 "$URL/debug/pprof/profile"
}

run::pprof:heap() {
	go tool pprof -http=:3010 "$URL/debug/pprof/heap"
}

run::pprof:heap:collect() {
	curl "$URL/debug/pprof/heap?gc=1" >"local/pprof/heap.$(date "+%y-%m-%d--%H-%M-%S")"
}

run::pprof:heap:diff() {
	go tool pprof -http=:3010 -diff_base "$1" "$2"
}

run::pprof:allocs() {
	go tool pprof -http=:3010 "$URL/debug/pprof/allocs"
}

run::pprof:goroutine() {
	go tool pprof -http=:3010 "$URL/debug/pprof/goroutine"
}

echo_warning() {
	echo "This is a dangerous command... Do you want to continue? (y/N)"
	read -r response
	if [[ "$response" =~ ^[Yy]$ ]]; then
		echo "Proceeding with the command..."
	else
		echo "Cancelled"
		exit 0
	fi
}

# "$@" represents all the arguments passed to the script
"$@"
