# syntax=docker/dockerfile:1.2

FROM --platform=$BUILDPLATFORM crazymax/goreleaser-xx:latest AS goreleaser-xx
FROM --platform=$BUILDPLATFORM golang:alpine AS base
COPY --from=goreleaser-xx / /
RUN apk add --no-cache file git tar
WORKDIR /src

FROM base AS build
ARG TARGETPLATFORM
RUN --mount=type=bind,target=/src,rw \
  --mount=type=cache,target=/root/.cache/go-build \
  goreleaser-xx --debug \
    --name "app" \
    --dist "/out" \
    --main="." \
    --ldflags="-s -w"

FROM alpine
COPY --from=build /usr/local/bin/app /usr/local/bin/app
CMD [ "app" ]
