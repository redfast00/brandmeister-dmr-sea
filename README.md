# Brandmeister bridge to mumble

Stream Brandmeister DMR calls using the Simple External Application
terminal protocol. This connects a BrandMeister
DMR talkgroup to a Mumble bot user, enableing
people to listen to a DMR talkgroup without a
radio.

Mumble is a free, open source, low latency, high
quality voice chat application. It can handle
massive amounts of concurrent users.

See [this blogpost](https://redfast00.github.io/05-06-2020/building-a-brandmeister-dmr-bridge.html) for a writeup.

## What's the difference between this and dmr-brandmeister?

This uses the Simple External Applications protocol, dmr-brandmeister uses the Open DMR protocol. For bridging purposes, the administrators have asked to use the Simple External Applications protocol instead of the protocol meant for running hotspots.

## Can I also talk in Mumble and have the bridge send it to the Brandmeister network?

No: this is too easy to misconfigure so that unlicensed users could transmit, possibly breaking some laws while doing so.

## Setup

The setup is considerably easier than my other software stack that uses the Open DMR protocol [dmr-brandmeister](https://github.com/redfast00/dmr-brandmeister):

1. Copy the config file from `config/config_example.json` to `config/config.json` and fill in the required information. Note that you will have to ask the Brandmeister administrator of your country for a Simple External Application.
2. Build the docker container with `./build.sh`
3. Start the docker container with `./start.sh`

## Software used

- the tool that talks to the BrandMeister network was adapted from [callrec](https://github.com/BrandMeister/callrec)
- `decode49to70.py` is adapted from [dmr_utils](https://github.com/n0mjs710/dmr_utils/)
- the AMBE-decoder from the MD380-project

## Legal (I'm not a lawyer)

The AMBE codec is [still under patent until 2023-11-07](https://patents.google.com/patent/EP1420390B1/en). This means that using the AMBE decoder/encoder might not be legal where you live.

In my country (Belgium), the rights coming from patents don't apply for actions in the
private sphere that are non-commercial ([source](https://economie.fgov.be/nl/themas/intellectuele-eigendom/octrooien/beperkingen-en-uitzonderingen)).
There are also laws prohibiting
from doing any commercial actions on the amateur
radio bands. The code that handles the AMBE
encoding and decoding is also not in this
repository: it is in the
[md380 tools](https://github.com/travisgoodspeed/md380tools) repository. In this repository, I am
only talking about how to use the md380 software, which
is protected under free speech (I think, again,
  I'm not a lawyer).

If you want to be absolutely sure you're not
infringing any patents, use an AMBE decoder USB
dongle.
