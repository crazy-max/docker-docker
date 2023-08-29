# syntax=docker/dockerfile:1

FROM --platform=$BUILDPLATFORM tonistiigi/xx AS xx
FROM --platform=$BUILDPLATFORM golang:alpine AS base
COPY --from=xx / /
RUN apk add --no-cache file git
WORKDIR /src

FROM base AS build
ARG TARGETPLATFORM
RUN --mount=type=bind,target=/src,rw \
    --mount=type=cache,target=/root/.cache/go-build \
    xx-go build -trimpath -ldflags "-s -w" -o "/out/app" .

FROM alpine
COPY --from=build /out/app /usr/local/bin/app
CMD [ "app" ]
