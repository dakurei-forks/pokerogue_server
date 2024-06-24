ARG GO_VERSION=1.22

# ---------------------------------------------

FROM alpine as timezoner

RUN apk update && \
    apk --no-cache add tzdata

# ---------------------------------------------

FROM golang:${GO_VERSION}-alpine AS builder

WORKDIR /src

COPY ./go.mod /src/
COPY ./go.sum /src/

RUN go mod download && \
    go mod verify

COPY . /src/

RUN CGO_ENABLED=0 go build -o rogueserver

RUN chmod +x /src/rogueserver

# ---------------------------------------------

FROM scratch

WORKDIR /app

COPY --from=timezoner /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /src/rogueserver .
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

EXPOSE 8001

ENV TZ Europe/Paris

ENTRYPOINT ["./rogueserver"]
