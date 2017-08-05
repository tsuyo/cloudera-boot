function Cb-Build() {
  docker-compose build
}

function Cb-Bootstrap() {
  docker-compose up -d bootstrap
}

function Cb-Server() {
  docker-compose up -d server
}

function Cb-Logs() {
  docker-compose logs -f
}

function Cb-Log-Server () {
  Cb-Logs | Select-String 'server_1'
}

function Cb-Log-Client() {
  Cb-Logs | Select-String 'bootstrap_1'
}

function Cb-Shell () {
  docker-compose run -e SERVER_HOST_N_PORT="server:7189" shell /bin/bash
}
  
function Cb-Shell-Remote ($remote_user, $remote_host) {
  docker-compose run -e SERVER_HOST_N_PORT="localhost:7189" -e REMOTE_USER=$remote_user -e REMOTE_HOST=$remote_host shell
}

function Cb-Exec() {
  docker-compose run -e SERVER_HOST_N_PORT=server:7189 shell sh -c "$args"
}

function Cb-Exec-Remote($remote_user, $remote_host) {
  docker-compose run -e SERVER_HOST_N_PORT=localhost:7189 -e REMOTE_USER=$remote_user -e REMOTE_HOST=$remote_host shell sh -c "portforward.sh && $args"  
}

function Cb-Terminate() {
  docker-compose run -e SERVER_HOST_N_PORT=server:7189 shell bin/cd-terminate-remote.sh
}

function Cb-Shutdown() {
  docker-compose down
}

function Cb-Status() {
  docker-compose ps
}