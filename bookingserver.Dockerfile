FROM golang:1.16.3 as build

ADD . /go/src/devops-challenge
WORKDIR /go/src/devops-challenge

RUN go mod download &&\
    go build -o booking-server ./cmd/booking-server/main.go

FROM alpine as runtime
ENV POSTGRES_HOST=localhost
ENV POSTGRES_PORT=5432
ENV POSTGRES_DB=PUT_YOUR_SECRET_HERE
ENV POSTGRES_USER=PUT_YOUR_SECRET_HERE
ENV POSTGRES_PASSWORD=PUT_YOUR_SECRET_HERE
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
COPY --from=build /go/src/devops-challenge/booking-server /

CMD ./booking-server
