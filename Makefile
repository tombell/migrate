NAME=migrate

PLATFORMS:=darwin linux windows

dev:
	@echo "building dist/${NAME}"
	@go build -o dist/${NAME} ./cmd/${NAME}

prod: $(PLATFORMS)

$(PLATFORMS):
	@echo "building dist/${NAME}-$@-amd64"
	@GOOS=$@ GOARCH=amd64 go build -o dist/${NAME}-$@-amd64 ./cmd/${NAME}

clean:
	@rm -fr dist

.DEFAULT_GOAL := dev
.PHONY: dev prod $(PLATFORMS) clean
