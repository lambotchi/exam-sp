DOCKER_NETWORK = exam-sp_default
ENV_FILE = hadoop-hive.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} legnoban/hadoop_base:ubuntu1804 hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} legnoban/hadoop_base:ubuntu1804 hdfs dfs -copyFromLocal -f /opt/hadoop-3.2.1/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} legnoban/hadoop_base:ubuntu1804 hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} legnoban/hadoop_base:ubuntu1804 hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} legnoban/hadoop_base:ubuntu1804 hdfs dfs -rm -r /input