VERSION = 0.0.1

base:
	docker build -f Dockerfile-base -t gruffwizard/nog-base:${VERSION} -t gruffwizard/nog-base:latest .

quarkus:
	docker build -f Dockerfile-quarkus-only -t gruffwizard/nog-quarkus:${VERSION} -t gruffwizard/nog-quarkus:latest .

theia:
	docker build -f Dockerfile-theia -t gruffwizard/nog-quarkus-theia:${VERSION} -t gruffwizard/nog-quarkus-theia:latest .

all: base quarkus theia

push: all
	docker push gruffwizard/nog-base:latest
	docker push gruffwizard/nog-quarkus:latest
	docker push gruffwizard/nog-quarkus-theia:latest
