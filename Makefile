NAME=migrate

VERSION?=dev
COMMIT=$(shell git rev-parse HEAD | cut -c -8)

LDFLAGS=-ldflags "-X github.com/tombell/migrate/cmd/migrate/commands.Version=${VERSION} -X github.com/tombell/migrate/cmd/migrate/commands.Commit=${COMMIT}"

PLATFORMS:=darwin linux windows

dev:
	@echo "building dist/${NAME}"
	@go build ${LDFLAGS} -o dist/${NAME} ./cmd/${NAME}

prod: $(PLATFORMS)

$(PLATFORMS):
	@echo "building dist/${NAME}-$@-amd64"
	@GOOS=$@ GOARCH=amd64 go build ${LDFLAGS} -o dist/${NAME}-$@-amd64 ./cmd/${NAME}

clean:
	@rm -fr dist

.DEFAULT_GOAL := dev
.PHONY: dev prod $(PLATFORMS) clean
