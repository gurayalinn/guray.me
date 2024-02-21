#!/usr/bin/make -f

# This makefile should be used to hold functions/variables
# that are used by other makefiles. It should not be used
# to run commands directly.

# github_url is a function that returns the URL of the latest release
define github_url
	https://github.com/$(GITHUB)/releases/download/v$(VERSION)/$(ARCHIVE)
endef

# darwin, linux, windows
OSTYPE := $(shell echo $(shell uname))
# amd64, 386, arm, arm64, ppc64le, s390x
ARCH := $(shell echo $(shell uname -m) | sed -e 's/x86_64/amd64/' -e 's/i.86/386/' -e 's/arm.*/arm/' -e 's/aarch64.*/arm64/' -e 's/x86.*/386/' -e 's/ppc64le/ppc64le/' -e 's/s390x/s390x/' -e 's/unknown//' -e 's/./\L&/g')
# x86_64
ARCH_64 := $(shell echo $(shell uname -m))
# tar.gz, zip
EXT := $(if $(filter $(OSTYPE),windows),zip,tar.gz)

# Go clean
GO_CLEAN := $(CURDIR)/tools/goclean

# creates a directory bin.
bin:
	@ mkdir -p $@

# ~~~ Tools ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~ --------------------------------------------------------------------------------------- ~~~

.PHONY: clean-bin
clean-bin: ## Remove previous installed tools
	@echo "Remove previous installed tools"
	@rm -f $(CURDIR)/bin/*
	@echo "done! $@"

.PHONY: clean-go
clean-go: ## Uninstall all go tools
	@echo "Uninstall all tools"
	@chmod +x $(GO_CLEAN)
	@$(GO_CLEAN) honnef.co/go/tools/cmd/staticcheck@latest
	@$(GO_CLEAN) github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	@$(GO_CLEAN) golang.org/x/tools/cmd/goimports@latest
	@$(GO_CLEAN) github.com/cosmtrek/air@latest
	@$(GO_CLEAN) github.com/a-h/templ/cmd/templ@latest
	@$(GO_CLEAN) github.com/labstack/echo/v4@latest
	@echo "done! $@"

.PHONY: init
init: tools go-tools ## Install all tools
	@echo "done! $@"

go-tools: clean-go ## Install all go tools
	@echo "Install go tools"
	@$(GO) install honnef.co/go/tools/cmd/staticcheck@latest
	@$(GO) install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	@$(GO) install golang.org/x/tools/cmd/goimports@latest
	@$(GO) install github.com/cosmtrek/air@latest
	@$(GO) install github.com/a-h/templ/cmd/templ@latest
	@$(GO) get github.com/labstack/echo/v4@latest
	@echo "done! $@"

.PHONY: tools
tools: clean-bin migrate air mockery golangci-lint tailwindcss ## Install bin tools

# ~~ [migrate] ~~~ https://github.com/golang-migrate/migrate ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.PHONY: migrate
ifeq (, $(shell which migrate))
MIGRATE := $(shell command -v migrate || echo "bin/migrate")
migrate: bin/migrate ## Install migrate (database migration)

bin/migrate: GITHUB := golang-migrate/migrate
bin/migrate: BIN := migrate
bin/migrate: VERSION := 4.17.0
bin/migrate: LATEST := $(shell curl -s https://api.github.com/repos/$(GITHUB)/releases/latest | sed -n 's/.*"tag_name": "v\([^"]*\)".*/\1/p')
bin/migrate: VERSION := $(or $(VERSION),$(LATEST))
bin/migrate: ARCHIVE := $(or $(ARCHIVE),$(shell echo $(BIN).$(OSTYPE)-$(ARCH).$(EXT) | tr A-Z a-z))

bin/migrate: bin
	@echo $(github_url)
	@printf "Install $(BIN)... "
	@if curl -Ls $(shell echo $(call github_url) | tr A-Z a-z) | tar -zOxf - $(BIN) > $@; then \
		chmod +x $@ && echo "done! $@"; \
	else \
		echo "Error: Unable to download $(BIN)"; \
		rm -f $@; \
		exit 1; \
	fi
endif

# ~~ [ air ] ~~~ https://github.com/cosmtrek/air ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.PHONY: air
ifeq (, $(shell which air))
AIR := $(shell command -v air || echo "bin/air")
air: bin/air ## Install air (go file watcher)

bin/air: GITHUB  := cosmtrek/air
bin/air: BIN  := air
bin/air: VERSION := 1.49.0
bin/air: LATEST := $(shell curl -s https://api.github.com/repos/$(GITHUB)/releases/latest | sed -n 's/.*"tag_name": "v\([^"]*\)".*/\1/p')
bin/air: VERSION := $(or $(VERSION),$(LATEST))
bin/air: ARCHIVE := $(or $(ARCHIVE),$(shell echo $(BIN)_$(VERSION)_$(OSTYPE)_$(ARCH).$(EXT) | tr A-Z a-z))

bin/air: bin
	@echo $(github_url)
	@printf "Install $(BIN)... "
	@if curl -Ls $(shell echo $(call github_url) | tr A-Z a-z) | tar -zOxf - $(BIN) > $@; then \
		chmod +x $@ && echo "done! $@"; \
	else \
		echo "Error: Unable to download $(BIN)"; \
		rm -f $@; \
		exit 1; \
	fi
endif

# ~~ [ mockery ] ~~~ https://github.com/vektra/mockery ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.PHONY: mockery
ifeq (, $(shell which mockery))
MOCKERY := $(shell command -v mockery || echo "bin/mockery")
mockery: bin/mockery ## Install mockery (mocks generation)

bin/mockery: GITHUB  := vektra/mockery
bin/mockery: BIN  := mockery
bin/mockery: VERSION := 2.40.1
bin/mockery: LATEST := $(shell curl -s https://api.github.com/repos/$(GITHUB)/releases/latest | sed -n 's/.*"tag_name": "v\([^"]*\)".*/\1/p')
bin/mockery: VERSION := $(or $(VERSION),$(LATEST))
bin/mockery: ARCHIVE := $(or $(ARCHIVE),$(shell echo $(BIN)_$(VERSION)_$(OSTYPE)_$(ARCH_64).$(EXT)))

bin/mockery: bin
	@echo $(github_url)
	@printf "Install $(BIN)... "
	@if curl -Ls $(shell echo $(call github_url) | tr A-Z a-z) | tar -zOxf - $(BIN) > $@; then \
		chmod +x $@ && echo "done! $@"; \
	else \
		echo "Error: Unable to download $(BIN)"; \
		rm -f $@; \
		exit 1; \
	fi
endif

# ~~ [ golangci-lint ] ~~~ https://github.com/golangci/golangci-lint ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.PHONY: golangci-lint
ifeq (, $(shell which golangci-lint))
GOLANGCI := $(shell command -v golangci-lint || echo "bin/golangci-lint")
golangci-lint: bin/golangci-lint ## Install golangci-lint (linter)

bin/golangci-lint: GITHUB  := golangci/golangci-lint
bin/golangci-lint: BIN  := golangci-lint
bin/golangci-lint: VERSION := 1.55.2
bin/golangci-lint: LATEST := $(shell curl -s https://api.github.com/repos/$(GITHUB)/releases/latest | sed -n 's/.*"tag_name": "v\([^"]*\)".*/\1/p')
bin/golangci-lint: VERSION := $(or $(VERSION),$(LATEST))
bin/golangci-lint: ARCHIVE := $(or $(ARCHIVE),$(shell echo $(BIN)-$(VERSION)-$(OSTYPE)-$(ARCH).$(EXT) | tr A-Z a-z))

bin/golangci-lint: bin
	@echo $(github_url)
	@printf "Install $(BIN)... "
	@if curl -Ls $(shell echo $(call github_url) | tr A-Z a-z) | tar -zOxf - $(shell printf $(BIN)-$(VERSION)-$(OSTYPE)-$(ARCH)/$(BIN) | tr A-Z a-z) > $@; then \
		chmod +x $@ && echo "done! $@"; \
	else \
		echo "Error: Unable to download $(BIN)"; \
		rm -f $@; \
		exit 1; \
	fi
endif

# ~~ [ tailwindcss ] ~~~ https://github.com/tailwindlabs/tailwindcss ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.PHONY: tailwindcss
ifeq (, $(shell which tailwindcss))
TAILWINDCSS := $(shell command -v tailwindcss || echo "bin/tailwindcss")
tailwindcss: bin/tailwindcss ## Install tailwindcss cli (css framework)

bin/tailwindcss: GITHUB  := tailwindlabs/tailwindcss
bin/tailwindcss: BIN  := tailwindcss
bin/tailwindcss: VERSION := 3.4.1
bin/tailwindcss: LATEST := $(shell curl -s https://api.github.com/repos/$(GITHUB)/releases/latest | sed -n 's/.*"tag_name": "v\([^"]*\)".*/\1/p')
bin/tailwindcss: VERSION := $(or $(VERSION),$(LATEST))
bin/tailwindcss: ARCHIVE := $(or $(ARCHIVE),$(shell echo $(BIN)-$(OSTYPE)-x64 | tr A-Z a-z))

bin/tailwindcss: bin
	@echo $(github_url)
	@printf "Install $(BIN)... "
	@if curl -Ls $(shell echo $(call github_url) | tr A-Z a-z) -o $@; then \
		chmod +x $@ && echo "done! $@"; \
	else \
		echo "Error: Unable to download $(BIN)"; \
		rm -f $@; \
		exit 1; \
	fi
endif
