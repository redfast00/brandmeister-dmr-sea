#
# callrec builder
#
FROM golang AS callrecbuilder

WORKDIR /go
RUN go get github.com/BrandMeister/callrec
RUN go build github.com/BrandMeister/callrec


#
# MD380 builder
#
FROM debian:stretch AS md380builder

RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential gcc-arm-linux-gnueabi unzip curl libc6-armel-cross libc6-dev-armel-cross ca-certificates python

WORKDIR /md380tools
COPY src/md380tools .

WORKDIR /md380tools/emulator
RUN make md380-emu

#
# Running container
#

FROM ruby:2.7-buster

RUN apt-get update && apt-get install -y --no-install-recommends \
      sox \
      wget \
      mplayer \
      python \
      python3 \
      python-pip python-setuptools python-dev python-wheel \
      qemu-user \
      libopus-dev \
      nano

RUN pip install bitarray bitstring
RUN gem install mumble-ruby

WORKDIR /app
COPY --from=callrecbuilder /go/callrec .
COPY --from=md380builder /md380tools/emulator/md380-emu .

COPY src .
RUN mkdir -p app/config

CMD ./start.sh
