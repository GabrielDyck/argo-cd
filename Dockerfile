FROM golang:1.16-alpine as build
WORKDIR /root/go/src/github.com/GabrielDyck/argo-hello-world

COPY go.mod .
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build

FROM alpine:latest
WORKDIR /home/argo
EXPOSE 9290
COPY --from=build /root/go/src/github.com/GabrielDyck/argo-hello-world/argo-hello-world .

CMD ["/home/argo/argo-hello-world"]
