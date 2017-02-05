# cloudera-boot
Dockerfiles for [Cloudera Director][1] Server & Client. You can try full Cloudera Director features on your own machine (without any additional instance just for Cloudera Director server on a cloud provider like AWS - great cost savings!). This repo has a sample cluster.conf file just for your reference. Refer to [Provisioning a Cluster on AWS][2] for the full syntax of the configuration file.

## How to build
You need Docker (& Docker Compose) to build this repository. It takes several minutes depending on your environment.
```
$ git clone https://github.com/tsuyo/cloudera-boot
$ cd cloudera-boot
$ docker-compose build # may take a while
```

## Usage 1: Server & Client
bootstrap/terminate a cluster using both server & client (recommended). The commands below launches a cloudera director server, followed by a client command creating a cluster via the server (bootstrap-remote).
```
$ export AWS_ACCESS_KEY_ID=<your_AWS_ACCESS_KEY_ID>
$ export AWS_SECRET_ACCESS_KEY=<your_AWS_SECRET_ACCESS_KEY>
$ vi cluster.conf # edit your own cluster.conf
$ docker-compose up -d
$ docker-compose logs -f # if you'd like to check logs from stdout
...
cloudera-director-server_1  | Started Cloudera Director Server (cloudera-director-server):[  OK  ]
cloudera-director-client_1  | waiting for director server wakeup ............................
cloudera-director-client_1  | Process logs can be found at /root/.cloudera-director/logs/application.log
...
cloudera-director-client_1  | * Done ...
cloudera-director-client_1  | Cluster ready.
clouderaboot_cloudera-director-client_1 exited with code 0
```
Optionally, you can access the server web console via http://localhost:7189. After trying some great jobs against the cluster, you can terminate it with the following command ("cd-terminate-remote" is just a wrapper of "cloudera-director terminate-remote" command):
```
$ docker-compose run cloudera-director-client cd-terminate-remote
```
or even execute any [Cloudera Director CLI][3] command instead of cd-terminate-remote like this:
```
$ docker-compose run cloudera-director-client cloudera-director validate cluster.conf
```
If you feel you don't need the server anymore, shutdown it completely as follows:
```
$ docker-compose down
```

## Usage 2: Server Only
If you need just cloudera director server's functions, it's as easy as:
```
$ docker-compose run -p 7189:7189 -d cloudera-director-server
$ docker logs -f $(docker ps -q -n 1) # optionally, this shows application.log from the server
```
Now you can access the server web console via http://localhost:7189. After playing around on the web console, you can terminate the server with the following command:
```
$ docker-compose down
```

## Usage 3: Client Only
You might not need any server functions e.g. when you just validate your cluster.conf syntax. Then it's reasonable to execute a client command only.
```
$ export AWS_ACCESS_KEY_ID=xxxxxx
$ export AWS_SECRET_ACCESS_KEY=xxxxxx
$ vi cluster.conf
$ docker-compose run cloudera-director-client cloudera-director validate cluster.conf # or any other command here
```
Notice: cloudera-director CLI has 'bootstrap' command which can be executed in this Client Only option. However, the recommended way to launch a cluster is using 'bootstrap-remote' command because it can provision both Cloudera Manager instance and cluster instances in parallel and twice as fast as 'bootstrap'.

[1]: http://www.cloudera.com/documentation/director/latest/topics/director_intro.html
[2]: http://www.cloudera.com/documentation/director/latest/topics/director_deployment_modify_config_file.html
[3]: http://www.cloudera.com/documentation/director/latest/topics/director_cli_commands.html
