# cloudera-boot
This repo includes [Cloudera Director][1] utilities. The main component is Dockerfile for Cloudera Director server & client. You can try full Cloudera Director features on your own machine (without any additional instance just for Cloudera Director server on a cloud provider like AWS - great cost savings!). Or you can deploy this on one of several Container-as-a-service providers (e.g. AWS ECS). A sample cluster.conf file is included just for your reference. Refer to [Provisioning a Cluster on AWS][2] for the full syntax of the configuration file.

## Download & Preparation
You need [Docker Community Edition][3] to use commands in this repository. The last command here builds docker image and may take some time depending on your environment.
```
$ git clone https://github.com/tsuyo/cloudera-boot
$ cd cloudera-boot
$ . bin/cloudera-boot.sh # load several functions/aliases
$ cb-build # may take a while
```
And the following environment variables are required in advance.
```
$ export AWS_ACCESS_KEY_ID=xxxxxx
$ export AWS_SECRET_ACCESS_KEY=xxxxxx
$ export SSH_PRIVATE_KEY=<your_SSH_PRIVATE_KEY_FILENAME> # pem file name
```

## Usage 1: Bootstrap a cluster (local mode)
bootstrap/terminate a cluster from cluster.conf. The commands below launch Cloudera Director server, followed by command to create a cluster via the server.
```
$ vi cluster.conf # edit your own cluster.conf
$ cb-bootstrap
$ cb-logs       # show both server & client logs (optional)
$ cb-log-server # show server log (optional)
$ cb-log-client # show client log (optional)
```
You can access Cloudera Director web console via http://localhost:7189 as usual. After trying some great jobs against the cluster, you can terminate it with the following command:
```
$ cb-terminate
```
or even execute any Cloudera Director CLI command once you enter shell mode:
```
$ cb-shell # enter shell mode
[root@xxxxxxxxxxxx cloudera-boot]# cloudera-director validate cluster.conf
[root@xxxxxxxxxxxx cloudera-boot]# cloudera-director bootstrap-remote cluster.conf --lp.remote.username=admin --lp.remote.password=admin --lp.remote.hostAndPort=server:7189
[root@xxxxxxxxxxxx cloudera-boot]# cloudera-director terminate-remote cluster.conf --lp.remote.username=admin --lp.remote.password=admin --lp.remote.hostAndPort=server:7189
```
If you feel you don't need the server anymore, shutdown it completely as follows:
```
$ cb-shutdown
```

## Usage 2: Launch Cloudera Director server (local mode)
If you need just Cloudera Director server's functions, it's as easy as:
```
$ cb-server
$ cb-log-server # show server log (optional)
```
Now you can access the server web console via http://localhost:7189. After playing around on the web console, you can terminate the server with the following command:
```
$ cb-shutdown
```

## Usage 3: Execute Cloudera Director CLI command (local mode)
You might not need any server function e.g. when you just validate your cluster.conf syntax. Then it's reasonable to execute a client command only.

### One time execution
You can execute any shell command (including cloudera-director command of course) followed by "cb-exec"
```
$ cb-exec cloudera-director validate cluster.conf # or any other command here
Process logs can be found at /opt/cloudera-director-client/logs/application.log
Plugins will be loaded from /opt/cloudera-director-client/plugins
Java HotSpot(TM) 64-Bit Server VM warning: ignoring option MaxPermSize=256M; support was removed in 8.0
Cloudera Director 2.5.0 initializing ...
Configuration file passes all validation checks.
```

### Shell mode
If you'd rather want a REPL shell, type "cb-shell" instead
```
$ cb-shell
[root@xxxxxxxxxxxx cloudera-boot]# cloudera-director validate cluster.conf
```

## Usage 4: Execute Cloudera Director CLI command (remote mode)
If you have a remote Cloudera Director server already, you can connect it by specifying
- REMOTE_USER: user name to connect Cloudera Director server via ssh - e.g. ec2-user. This should be the owner of ${SSH_PRIVATE_KEY}
- REMOTE_HOST: Cloudera Director server hostname or IP address

as command arguments for "cb-shell-remote" (shell mode)
```
$ cb-shell-remote <REMOTE_USER> <REMOTE_HOST>
[root@xxxxxxxxxxxx cloudera-boot]# cd-bootstrap-remote
[root@xxxxxxxxxxxx cloudera-boot]# cd-terminate-remote
```
or "cb-exec-remote" (one time execution)
```
$ cb-exec-remote <REMOTE_USER> <REMOTE_HOST> cd-bootstrap-remote
```
(NOTE) cd-bootstrap-remote/cd-terminate-remote are aliases for "cloudera-director bootstrap-remote" and "cloudera-director terminate-remote" commands respectively.

[1]: http://www.cloudera.com/documentation/director/latest/topics/director_intro.html
[2]: http://www.cloudera.com/documentation/director/latest/topics/director_deployment_modify_config_file.html
[3]: https://www.docker.com/get-docker
