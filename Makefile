APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=moudrick
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
# TARGETARCH=arm64
TARGETARCH=amd64
IMAGE_TAG=${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/moudrick/kbot/cmd.appVersion=${VERSION}
	ls -l

image:
	docker build . \
	-t ${IMAGE_TAG} \
	--build-arg TARGETOS=${TARGETOS} \
	--build-arg TARGETARCH=${TARGETARCH} \
	--progress plain

push:
	docker push ${IMAGE_TAG}

clean:
	rm -rf kbot
	docker rmi ${IMAGE_TAG}
#	docker rmi --force ${IMAGE_TAG}

# "make linux", яка збере код для Linux. Те саме повинно бути зроблено для arm, macOS та Windows.
# -- android arm
# linux arm64
# linux amd64
# darwin amd64
# windows amd64

eval_arm:
#	$(eval TARGETOS=linux)
#	$(eval TARGETARCH=arm)
	$(eval TARGETARCH=arm64)

eval_linux:
	$(eval TARGETOS=linux)
#	$(eval TARGETARCH=amd64)

eval_macos:
	$(eval TARGETOS=darwin)
#	$(eval TARGETARCH=amd64)

eval_windows:
	$(eval TARGETOS=windows)
#	$(eval TARGETARCH=amd64)

eval_alternative_registry:
	$(eval REGISTRY=gcr.io/k8s-k3s-386221)
	$(eval IMAGE_TAG=${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH})

alternative_registry: eval_alternative_registry build image push clean

arm:     eval_arm     alternative_registry
linux:   eval_linux   alternative_registry
macos:   eval_macos   alternative_registry
windows: eval_windows alternative_registry
