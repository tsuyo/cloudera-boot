# cloudera-boot
Cloudera Boot is essentially a collection of utilities for [Cloudera Altus Director][1]. With cloudera-boot CLI (cboot), you can achieve the following tasks like
- start & stop Cloudera Altus Director server on your own machine (e.g. Mac)
- check status & view logs for the server
- bootstrap & terminate CDH and Cloudera Enterprise Data Hub in the cloud

You can try full Cloudera Altus Director features on your own machine (without any additional instance in a public cloud provider like AWS) or, of course install this tool on one of the public cloud providers if you like.

A sample cluster.conf file is included in this repo just for your reference. Refer to [Provisioning a Cluster on AWS][2] for the full syntax of the configuration file.

## Installation
### Mac
You only need [Docker Community Edition][3] as a prerequisite (Java isn't even required). The easiest way to install cloudera-boot on Mac is by using [Homebrew][4] as follows

```
$ brew tap tsuyo/tap
$ brew install cloudera-boot
```
To check the installation, you can type 'cboot -h or --help' and should see a similar output as follows
```
$ cboot -h
usage: cboot [-h] {server,s,se,client,c,cl} ...

Cloudera Boot CLI

optional arguments:
  -h, --help            show this help message and exit

commands:
  {server,s,se,client,c,cl}
    server              operations for server
    s                   alias for "server"
    se                  alias for "server"
    client              operations for client
    c                   alias for "client"
    cl                  alias for "client"
```

### Other platforms (Windows, Linux)
Though not tested, you should use cloudera-boot if you have python installed on your platform. You can directly download [cloudera-boot archive file][5], extract it and install 'cboot' and 'cloudera-director' command within your command path.

## Configure ENV variables (optional)
As you can see [Cloudera AWS Reference configuration][6], it's a good idea to externalize confidential information as ENV variables. These variables in configuration are replaced with actual values when bootstrapping a cluster. For example, in AWS, the following environment variables are typically considered as confidential ones.
```
$ export AWS_ACCESS_KEY_ID=xxxxxx     # AWS Access Key
$ export AWS_SECRET_ACCESS_KEY=yyyyyy # AWS Serect Access Key
$ export SSH_PRIVATE_KEY=zzzzzz.pem   # SSH pem file path
```

## Server commands
If you already have a Cloudera Altus Director server in anywhere in the world, that's great! You can use that server instance with cloudera-boot. Skip this section and follow the [Client Commands](#client-commands) section.

Otherwise, you'd like to start a fresh Cloudera Altus Director server in your own machine, please follow this section.

### Start server
As 'cboot -h' indicates, cboot takes 'server' command for server operations. You also use 's' or 'se' as aliases of 'server' (applied for the rest of the document as well). So the following 3 commands are all equivalent and starting server locally.
```
$ cboot server start
$ cboot s start
$ cboot se start
```
When the server is up & running, you can access Cloudera Altus Director web console via http://localhost:7189 as usual on your own machine.

### Check server status
```
$ cboot server status
200
```
If you get other than "200" (as server HTTP status code), something is wrong with the server. Please check the server log as in next section. If you don't get any value at all, that's typically because the server is still on the way of starting. Please wait for a moment (and can check the log as well).

Note that until you get the status "200", any client command against the server will fail.

### View server log
```
$ cboot server log
```

### Other commands (stop, restart ...)
You can check all available server commands with 'cboot server -h'
```
$ cboot server -h
usage: cboot server [-h] {start,stop,restart,status,log} ...

optional arguments:
  -h, --help            show this help message and exit

actions:
  {start,stop,restart,status,log}
    start               start cloudera director server
    stop                stop cloudera director server
    restart             restart cloudera director server
    status              check server status
    log                 view server log
```

## Client commands

### Bootstrap a cluster
Bootstrap a cluster from a Cloudera Altus Director configuration. Options are exactly same as Cloudera's official "cloudera-director bootstrap-remote" command.
```
$ cboot client bootstrap cluster.conf
$ cboot c bootstrap cluster.conf  # c is an alias for "client"
$ cboot cl bootstrap cluster.conf # cl is an alias for "client"
```
Without any option other than a conf file, you can bootstrap a cluster by using [the local server above](#server-commands) with username/password = admin/admin. Of course, you can use any server like the following:
```
$ cboot client bootstrap cluster.conf --lp.remote.username=admin --lp.remote.password=admin --lp.remote.hostAndPort=<anyserver>:<anyport>
```

### Enter a shell mode to run "cloudera-director" interactively
```
$ cboot client shell
bash-4.4# cloudera-director validate-remote cluster.conf  # use the local server with username/password = admin/admin
bash-4.4# cloudera-director bootstrap-remote cluster.conf
bash-4.4# cloudera-director terminate-remote cluster.conf
```

### Other commands (validate, terminate ...)
You can check all available client commands with 'cboot client -h'
```
$ cboot client -h
usage: cboot client [-h] {shell,bootstrap,validate,terminate} ...

optional arguments:
  -h, --help            show this help message and exit

actions:
  {shell,bootstrap,validate,terminate}
    shell               begin an interactive shell
    bootstrap           bootstrap cluster (= "cloudera-director bootstrap-
                        remote")
    validate            validate conf (= "cloudera-director validate-remote")
    terminate           terminate cluster (= "cloudera-director terminate-
                        remote")
```

[1]: http://www.cloudera.com/documentation/director/latest/topics/director_intro.html
[2]: http://www.cloudera.com/documentation/director/latest/topics/director_deployment_modify_config_file.html
[3]: https://www.docker.com/get-docker
[4]: https://github.com/Homebrew/brew
[5]: https://github.com/tsuyo/cloudera-boot/tags
[6]: https://github.com/cloudera/director-scripts/blob/master/configs/aws.reference.conf#L49-L50
