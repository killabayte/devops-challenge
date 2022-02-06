FROM golang:1.16.3 as build

ADD . /go/src/devops-challenge
WORKDIR /go/src/devops-challenge

RUN go mod download &&\
    go build -o write-hello ./cmd/write-hello/main.go

FROM alpine as runtime
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
COPY --from=build /go/src/devops-challenge/write-hello /

CMD ./write-hello
