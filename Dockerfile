FROM mitchty/alpine-ghc:latest

RUN apk update && apk add musl-dev gmp-dev zlib-dev git gcc
WORKDIR /usr/local/src/ec2-split-objs-bug
