# cloudera-boot
Dockefile for [Cloudera Director Client][1]. This repo has a sample cluster.conf just for your reference. Refer to [Provisioning a Cluster on AWS][2] for the full syntax.

## Usage
Bootstrap a CDH cluster on AWS
```
$ docker pull kirasoa/cloudera-boot
$ export AWS_ACCESS_KEY_ID=xxxxxx
$ export AWS_SECRET_ACCESS_KEY=xxxxxx
$ vi cluster.conf
$ docker run --rm -ti -v ${PWD}:/cloudera-boot -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" kirasoa/cloudera-boot:latest
```
Also you can use an arbitrary [Cloudera Director CLI][3] command, e.g.
```
docker run --rm -ti -v ${PWD}:/cloudera-boot -e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" -e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" kirasoa/cloudera-boot:latest cloudera-director validate cluster.conf
```

## How to build from the source
```
$ git clone https://github.com/tsuyo/cloudera-boot
$ cd cloudera-boot
$ docker build -t kirasoa/cloudera-boot:latest .
```

[1]: http://www.cloudera.com/documentation/director/latest/topics/director_client.html
[2]: http://www.cloudera.com/documentation/director/latest/topics/director_deployment_modify_config_file.html
[3]: http://www.cloudera.com/documentation/director/latest/topics/director_cli_commands.html
