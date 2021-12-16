# syntax=docker/dockerfile:1.2

FROM golang:alpine AS build
WORKDIR /src
RUN --mount=type=bind,target=/src \
  --mount=type=cache,target=/root/.cache/go-build \
  go build -ldflags "-s -w" -o /usr/bin/app .

FROM alpine
COPY --from=build /usr/bin/app /usr/bin/app
CMD [ "app" ]
