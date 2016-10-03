FROM alpine:3.4

# ALPINE DEV + GHC
RUN echo "https://s3-us-west-2.amazonaws.com/alpine-ghc/8.0" >> /etc/apk/repositories
ADD https://raw.githubusercontent.com/mitchty/alpine-ghc/master/mitch.tishmack%40gmail.com-55881c97.rsa.pub \
    /etc/apk/keys/mitch.tishmack@gmail.com-55881c97.rsa.pub
RUN apk update
RUN apk add alpine-sdk linux-headers musl-dev gmp-dev zlib-dev ghc git

# FIX https://bugs.launchpad.net/ubuntu/+source/gcc-4.4/+bug/640734
WORKDIR /usr/lib/gcc/x86_64-alpine-linux-musl/5.3.0/
RUN cp crtbeginT.o crtbeginT.o.orig
RUN cp crtbeginS.o crtbeginT.o

# BOOTSTRAP
ADD https://github.com/commercialhaskell/stack/releases/download/v1.2.0/stack-1.2.0-linux-x86_64-static.tar.gz /tmp/stack.tar.gz
WORKDIR /tmp
RUN tar xf /tmp/stack.tar.gz stack-1.2.0-linux-x86_64-static/stack
RUN mv /tmp/stack-1.2.0-linux-x86_64-static/stack /usr/local/bin/stack

# STACK
WORKDIR /usr/local/src/ec2-split-objs-bug
RUN /usr/local/bin/stack --jobs $(grep -c processor /proc/cpuinfo) install
