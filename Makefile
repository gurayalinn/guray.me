#!/usr/bin/make -f
#@IgnoreInspection BashAddShebang
# Makefile for guray.me

export ROOT=$(realpath $(dir $(lastword $(MAKEFILE_LIST))))
export DEBUG=true
export APP=gurayme

# VER := $(shell git describe --tags --always --dirty)
# LDFLAGS += -X "main.Version=$(VER)"
LDFLAGS += -X "main.BuildTimestamp=$(shell date -u "+%Y-%m-%d %H:%M:%S")"
LDFLAGS += -X "main.goVersion=$(shell go version | sed -r 's/go version go(.*)\ .*/\1/')"

ENGINE := $(shell { command -v podman || command -v docker; } 2>/dev/null)
COMPOSE := $(shell { command -v docker-compose || command -v docker compose; } 2>/dev/null)

export GOPROXY = https://proxy.golang.org/cached-only,direct
GO := GO111MODULE=on CGO_ENABLED=0 go
CGO := GO111MODULE=on CGO_ENABLED=1 go
IMAGE_NAME = gurayme
GOFILE=cmd/server/main.go
GOOS=linux
VER=0.0.1
GOARCH=amd64
BINARY = $(IMAGE_NAME)
GO_MAIN = $(GOFILE)
GO_VERSION=$(shell go version | cut -c 14- | cut -d' ' -f1 | cut -d'.' -f2)

GOFILES := $(shell find $(CURDIR) -name '*.go' | grep -vE '(\.pb\.go|\.pb\.gw\.go|\.pb\.validate\.go|_test.go|_templ.go|vendor|views)')
PKG_LIST := $(shell go list $(CURDIR)/... | grep -v $(CURDIR)/vendor/)

GO_BUILD=$(shell $(GO) build -o $(CURDIR)/bin/$(BINARY) $(CURDIR)/$(GO_MAIN))
GOFMT := $(shell gofmt -s -d -w -l -e $(GOFILES))
GO_VET := $(shell $(GO) vet $(PKG_LIST))
GO_IMPORTS := $(shell goimports -d -l -e -w $(GOFILES))
GO_LINT := $(shell golangci-lint run --deadline 5m0s --skip-dirs vendor --skip-files '.*/[^p].*\.go' $(CURDIR)/...)

## TODO: Will be added later
# GO_TEST := $(shell $(GO) test -short -coverprofile=coverage.out -covermode=atomic -v $(CURDIR)/...)
# GO_RACE := $(shell $(CGO) test -race -coverprofile=coverage.out -covermode=atomic -v $(CURDIR)/...)
# GO_BENCHMARK := $(shell $(CGO) test -run="-" -bench=".*" -count=8 -benchmem -v $(CURDIR)/... > benchmark.out)

# Include tools.Makefile from /tools directory to use the functions/variables
# Dependencies are listed in the tools.Makefile : init - migrate - air - mockery - golangci-lint
include $(CURDIR)/tools/tools.Makefile

# .PHONY: FORCE

.DEFAULT_GOAL := help

# OS specific settings
ifeq ($(OS),Windows_NT)
	BINARY := $(BINARY).exe
endif

# ~~~ All Commands ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~ --------------------------------------------------------------------------------------- ~~~

.PHONY: all
all: gen css js check build run ## Clean and build project
	@echo "Clean and build project"
	@echo "done! $@"

.PHONY: dev
dev: css js ## Run the project
	@echo "Run the project with air"
	@templ generate --watch --proxy="http://localhost:8080" --cmd "air"

.PHONY: gen
gen: ## Generate the templates
	@echo "Generate the templates"
	@templ generate
	@echo "done! $@"

.PHONY: css
css: ## Generate the css files
	@echo "Generate the css"
	@bun run css
	@echo "done! $@"

.PHONY: js
js: ## Generate the js files
	@echo "Generate the js"
	@bun run js
	@echo "done! $@"

.PHONY: check
check: go.mod fmt imports vet lint ## Check project
	@echo "> imports - fmt - lint - vet - go.mod"
	@echo "done! $@"

.PHONY: go.mod
go.mod: ## Update go.mod
	$(GO) mod tidy
	$(GO) mod verify
	$(GO) mod download
	$(GO) mod vendor
	@echo "done! $@"

.PHONY: go.sum
go.sum: go.mod ## Update go.sum

.PHONY: fmt
fmt: ## Format the files
	@echo "Format the files"
	$(GOFMT)
	@echo "done! $@"

.PHONY: imports
imports: ## Add missing imports
	@echo "Add missing imports"
	$(GO_IMPORTS)
	@echo "done! $@"

.PHONY: vet
vet: ## Vet the files
	@echo "Vet the files"
	$(GO_VET)
	@echo "done! $@"

.PHONY: lint
lint: ## Lint the files
	@echo "Lint the files"
	$(GO_LINT)
	@echo "done! $@"

.PHONY: clean
clean: ## Remove previous build
	@echo "Remove previous build and cache..."
	@rm -f $(CURDIR)/bin/$(BINARY)
	@echo "done! $@"

.PHONY: build
build: $(BINARY) ## Build binary

.PHONY: $(BINARY)
$(BINARY): clean ## Sub command to "build"
	@echo "Build $(BINARY)"
	$(GO) build -o $(CURDIR)/bin/$@ $(CURDIR)/$(GO_MAIN)
	@echo "done! $@"

.PHONY: run
run: ## Run the binary
	@echo "Run the binary"
	$(CURDIR)/bin/$(BINARY)
	@echo "done! $@"


.PHONY: check-updates
check-updates: ## Check for updates
	@echo "Check for updates"
	go list -u -m -f '{{if not .Indirect}}{{.}}{{end}}' all | grep "\["
	@echo "done! $@"

#.PHONY: test
#test: ## Run tests -short
#	@echo "Run tests"
#	$(GO) clean -i -cache -testcache -modcache
#	$(GO_TEST)
#	@echo "done! $@"

#.PHONY: race
#race: ## Run tests -race
#	@echo "Run tests with data race detector"
#	$(GO) clean -i -cache -testcache -modcache
#	$(GO_RACE)
#	@echo "done! $@"

#.PHONY: benchmark
#benchmark: ## Run benchmarks
#	@echo "Run benchmarks"
#	$(GO) clean -i -cache -testcache -modcache
#	$(GO_BENCHMARK)
#	@echo "done! $@"

#.PHONY: version
#version: ## Show go minor version
#	@echo "Go minor version: $(GO_VERSION)"

#.PHONY: tag
#tag: ## Tag the version
#	@git tag `grep -P '^\tversion = ' $(CURDIR)/${GO_MAIN}|cut -f2 -d'"'`
#	@git tag|grep -v ^v
#	@echo "git push origin `git tag|grep -v ^v`"
#	@echo "done! $@"


#.PHONY: release
#release: check
#	GOOS=darwin GOARCH=amd64 $(GO) build -ldflags '$(LDFLAGS)' -o $(CURDIR)/bin/darwin/$(BINARY)
#	GOOS=linux GOARCH=amd64 $(GO) build -ldflags '$(LDFLAGS)' -o $(CURDIR)/bin/linux/$(BINARY)
#	GOOS=windows GOARCH=amd64 $(GO) build -ldflags '$(LDFLAGS)' -o $(CURDIR)/bin/windows/$(BINARY).exe
#	@echo "done! $@"

# Docker
.PHONY: docker-image
docker-image:
	docker build -t gurayalinn/guray.me:$(VER) -f $(CURDIR)/build/Dockerfile .

.PHONY: push-docker
push-docker:
	docker push gurayalinn/guray.me:$(VER)

.PHONY: stop
stop: ## Stop all containers
	docker ps -q | awk '{print $1}' | xargs -o docker stop

.PHONY: down
down: ## Stop and remove all containers
	docker-compose down -v --remove-orphans --rmi local --timeout 0

.PHONY: dup
dup: ## Start all containers
	docker-compose up -V --build --force-recreate --remove-orphans --quiet-pull --abort-on-container-exit --exit-code-from $(IMAGE_NAME)

# Start the Docker containers
.PHONY: up
up: ## Start the containers
	$(DCO_BIN) up -d
	sleep 3

.PHONY: cprune
cprune: ## Remove all containers
	docker container prune -f

.PHONY: nprune
nprune: ## Remove all networks
	docker network prune -f

.PHONY: bprune
bprune: ## Remove all images
	docker builder prune -af

.PHONY: vprune
vprune: ## Remove all volumes
	docker system prune -f --volumes

# Git
.PHONY: git
git: ## Git push
	git add .
	git commit -m "update"
	git push origin master
	@echo "done! $@"


# HELP #######################################################################

dep-gawk:
	@ if [ -z "$(shell command -v gawk && command -v jq)" ]; then  \
		if [ -x /usr/local/bin/brew ]; then $(MAKE) _brew_gawk_install; exit 0; fi; \
		if [ -x /usr/bin/apt-get ]; then $(MAKE) _ubuntu_gawk_install; exit 0; fi; \
		if [ -x /usr/bin/yum ]; then  $(MAKE) _centos_gawk_install; exit 0; fi; \
		if [ -x /sbin/apk ]; then  $(MAKE) _alpine_gawk_install; exit 0; fi; \
		echo  "GNU Awk and Jq Required, We cannot determine your OS or Package manager. Please install it yourself.";\
		exit 1; \
	fi

_brew_gawk_install:
	@echo "Instaling gawk using brew... "
	@brew install gawk jq unzip --quiet
	@echo "done! $@"

_ubuntu_gawk_install:
	@echo "Instaling gawk using apt-get... "
	@apt-get -q install gawk jq unzip -y
	@echo "done! $@"

_alpine_gawk_install:
	@echo "Instaling gawk using yum... "
	@apk add --update --no-cache gawk jq unzip
	@echo "done! $@"

_centos_gawk_install:
	@echo "Instaling gawk using yum... "
	@yum install -q -y gawk jq unzip;
	@echo "done! $@"


# Help
.PHONY: help
help: dep-gawk ## Display this help screen
	@cat $(MAKEFILE_LIST) | \
		grep -E '^# ~~~ .*? [~]+$$|^[a-zA-Z0-9_-]+:.*?## .*$$' | \
		awk '{if ( $$1=="#" ) { \
			match($$0, /^# ~~~ (.+?) [~]+$$/, a);\
			{print "\n", a[1], ""}\
		} else { \
			match($$0, /^([0-9a-zA-Z_-]+):.*?## (.*)$$/, a); \
			{printf "  - \033[32m%-20s\033[0m %s\n",   a[1], a[2]} \
		}}'
	@echo ""
