GOPRIVATE := "github.com/tidbcloud/*"
MAKEFILE_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

default: dev

.PHONY: dev
dev: fmt mod vet lint generate build test

.PHONY: vet
vet:
	GOPRIVATE=$(GOPRIVATE) go vet ./...

.PHONY: mod
mod:
	GOPRIVATE=$(GOPRIVATE) go mod tidy
	GOPRIVATE=$(GOPRIVATE) go mod download
	GOPRIVATE=$(GOPRIVATE) go mod verify

.PHONY: generate
generate:
	GOPRIVATE=$(GOPRIVATE) go generate ./...

.PHONY: fmt
fmt:
	GOPRIVATE=$(GOPRIVATE) gofmt -s -w .

.PHONY: lint
lint:
	GOPRIVATE=$(GOPRIVATE) golangci-lint run --config $(MAKEFILE_DIR)/../.golangci.yml

.PHONY: test
test:
	GOPRIVATE=$(GOPRIVATE) go test -v -count=1 -race -shuffle=on -coverprofile=$(MAKEFILE_DIR)/../coverage.tidb-mgmt-service.txt ./...

.PHONY: build
build:
	mkdir -p $(MAKEFILE_DIR)/../bin/tidb-mgmt-service
	GOPRIVATE=$(GOPRIVATE) go build -o $(MAKEFILE_DIR)/../bin/tidb-mgmt-service ./...

.PHONY: vuln
vuln:
	GOPRIVATE=$(GOPRIVATE) govulncheck -test ./...
