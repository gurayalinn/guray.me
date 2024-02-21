# Build.
ARG BUILDPLATFORM=${BUILDPLATFORM:-amd64}
FROM --platform=${BUILDPLATFORM} golang:1.22-bookworm AS build

LABEL maintainer="Guray ALIN <info [at] guray.me>"
LABEL description="Dockerfile for building and running the Go projects."

ARG GITHUB_TOKEN=${GITHUB_TOKEN}
ARG GITHUB_EMAIL=${GITHUB_EMAIL}
ARG GITHUB_USER=${GITHUB_USER}
ARG GITHUB_REPO=${GITHUB_REPO}
ARG VERSION=${VERSION}

# Go build environment variables.
ENV GOVERSION=1.22
ENV PORT=${PORT}
ENV VERSION=${VERSION}
ENV GO111MODULE=on
ENV CGO_ENABLED=0
ENV GOPROXY="https://proxy.golang.org,direct"
ENV GOSUMDB="sum.golang.org"
ENV GOPATH=/go
ENV GOCACHE=/go/cache
ENV GOBIN=/go/bin
ENV PATH=$PATH:/go/bin

# Set environment variables.
ENV DEBIAN_FRONTEND=noninteractive \
	TZ=America/New_York \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=en_US.UTF-8 \
	HOME=/app \
	USER=root

USER root
# Install dependencies.
RUN apt-get update && apt-get install -qqy --no-install-recommends \
	ca-certificates \
	curl \
	wget \
	git \
	make \
	gnupg \
	tzdata \
	locales \
	&& apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Set timezone and locale.
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
	&& /usr/sbin/update-locale $LANG $LC_ALL $LANGUAGE \
	&& echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.UTF-8 \
	&& dpkg-reconfigure -f Noninteractive locales tzdata

# Build.
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .

RUN make check
RUN APP_VERSION=${VERSION#v} \
	CGO_ENABLED=${CGO_ENABLED} \
	GO111MODULE=${GO111MODULE} \
	go build -trimpath -ldflags "-s -w -X main.version=$APP_VERSION" -o ./entrypoint ./cmd/server/main.go

# ------------------------------------------------------------------------------

# Runtime.
FROM gcr.io/distroless/static-debian12 AS runtime
WORKDIR /
COPY --from=build /app/entrypoint /entrypoint
COPY --from=build /app/assets /assets
EXPOSE ${PORT}
USER nonroot:nonroot
ENTRYPOINT ["./entrypoint"]
# HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD ["/entrypoint", "-healthcheck"]
