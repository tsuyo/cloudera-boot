cb-build() {
  docker-compose build
}

cb-bootstrap() {
  docker-compose up -d bootstrap
}

cb-server() {
  docker-compose up -d server
}

cb-logs() {
  docker-compose logs -f
}

cb-log-server() {
  cb-logs | grep server_1
}

cb-log-client() {
  cb-logs | grep bootstrap_1
}

cb-shell() {
  docker-compose run -e SERVER_HOST_N_PORT=server:7189 shell /bin/bash
}

cb-shell-remote() {
  if [[ "$#" -lt 2 ]]; then
    echo "Usage: cb-shell-remote <REMOTE_USER> <REMOTE_HOST>"
    return
  fi
  REMOTE_USER=$1
  REMOTE_HOST=$2
  docker-compose run -e SERVER_HOST_N_PORT=localhost:7189 -e REMOTE_USER=$REMOTE_USER -e REMOTE_HOST=$REMOTE_HOST shell
}

cb-exec() {
  docker-compose run -e SERVER_HOST_N_PORT=server:7189 shell sh -c "$*"
}

cb-exec-remote() {
  if [[ "$#" -lt 3 ]]; then
    echo "Usage: cb-exec-remote <REMOTE_USER> <REMOTE_HOST> <COMMAND>"
    return
  fi
  REMOTE_USER=$1
  REMOTE_HOST=$2
  shift; shift

  docker-compose run -e SERVER_HOST_N_PORT=localhost:7189 -e REMOTE_USER=$REMOTE_USER -e REMOTE_HOST=$REMOTE_HOST shell sh -c "portforward && $*"
}

cb-terminate() {
  docker-compose run -e SERVER_HOST_N_PORT=server:7189 shell cd-terminate-remote
}

cb-shutdown() {
  docker-compose down
}

