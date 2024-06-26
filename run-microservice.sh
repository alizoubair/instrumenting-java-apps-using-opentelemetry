#!/bin/bash

mvn clean package -Dmaven.test.skip=true
AGENT_FILE=opentelemetry-javaagent-all.jar

if [ ! -f "${AGENT_FILE}" ]; then
  curl -L https://github.com/aws-observability/aws-otel-java-instrumentation/releases/download/v1.28.1/aws-opentelemetry-agent.jar --output ${AGENT_FILE}
fi

export OTEL_TRACES_EXPORTER=otlp
export OTEL_METRICS_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_ENDPOINT=HTTP://localhost:5555
export OTEL_RESOURCE_ATTRIBUTES=service.name=hello-app,service.version=1.0

java -javaagent:./${AGENT_FILE} -jar target/hello-app-1.0.jar
