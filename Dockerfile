FROM golang:1.20.4-alpine

WORKDIR /app

COPY go.mod go.sum ./

RUN --mount=type=secret,id=netrc,dst=/etc/secrets/.netrc \
    cp /etc/secrets/.netrc ~/ &&\
    export GOPRIVATE=buf.build/gen/go &&\
    go mod download

COPY server ./server

RUN go build -o ./main server/main.go

EXPOSE 8081

CMD ["./main"]
