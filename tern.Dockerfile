FROM golang:1.16.3 as build

ADD . /go/src
WORKDIR /go/src

RUN go get -u github.com/jackc/tern

FROM alpine as runtime
ENV PGHOST=localhost
ENV PGDATABASE=PUT_YOUR_SECRET_HERE
ENV PGUSER=PUT_YOUR_SECRET_HERE
ENV PGPASSWORD=PUT_YOUR_SECRET_HERE
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
COPY --from=build /go/bin/tern /
RUN mkdir -p /migrations
COPY --from=build /go/src/migrations/* /migrations

CMD ./tern migrate -m ./migrations
