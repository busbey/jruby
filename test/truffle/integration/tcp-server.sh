#!/usr/bin/env bash

set -e

source test/truffle/integration/common/test_server.sh.inc
ruby -X+T test/truffle/integration/tcp-server/tcp-server.rb & test_server
