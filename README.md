# cloudera-boot
Dockerfile for [Cloudera Director][1]. With this docker image, you can try full Cloudera Director features on your own machine (without any additional instance just for Cloudera Director server on a cloud provider like AWS - great cost savings!). This repo has a sample cluster.conf file just for your reference. Refer to [Provisioning a Cluster on AWS][2] for the full syntax.

## What's New

From Cloudera Director 2.3 release, this docker image contains both server and client packages (only [client package][3] was included in previous versions). This is mainly because provisioning with 'bootstrap-remote' (now default) can provision both Cloudera Manager instance and cluster instances in parallel and is twice as fast as 'bootstrap'. So provisioning 5 node Spark cluster, for example, just takes around 11 minutes now with 'bootstrap-remote' (which requires the server package).

## Usage
Bootstrap a CDH cluster on AWS
```
$ docker pull kirasoa/cloudera-boot
$ export AWS_ACCESS_KEY_ID=xxxxxx
$ export AWS_SECRET_ACCESS_KEY=xxxxxx
$ vi cluster.conf
$ docker run --rm -ti -v ${PWD}:/cloudera-boot -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" kirasoa/cloudera-boot:latest
```
Also you can use an arbitrary [Cloudera Director CLI][4] command, e.g.
```
$ docker run --rm -ti -v ${PWD}:/cloudera-boot -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" kirasoa/cloudera-boot:latest cloudera-director validate cluster.conf
```

## How to build an Docker image from the source (may take a few minutes)
```
$ git clone https://github.com/tsuyo/cloudera-boot
$ cd cloudera-boot
$ docker build --build-arg CD_VER=2.3.0 -t kirasoa/cloudera-boot:2.3.0 -t kirasoa/cloudera-boot:latest .
```

[1]: http://www.cloudera.com/documentation/director/latest/topics/director_intro.html
[2]: http://www.cloudera.com/documentation/director/latest/topics/director_deployment_modify_config_file.html
[3]: http://www.cloudera.com/documentation/director/latest/topics/director_client.html
[4]: http://www.cloudera.com/documentation/director/latest/topics/director_cli_commands.html
