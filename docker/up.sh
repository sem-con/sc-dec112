#!/bin/bash

docker pull semcon/sc-dec112
export WS_ENDPOINT="wss://service.dec112.at:8080/api/v1?api_key=OYD2019%23dev"; export WS_CHANNEL="dec112"; export DEC_TRIG=$(<dec112.trig); docker-compose -f docker-compose.yml up -d

export WS_ENDPOINT="ws://dec.it.esinet.io/api/v1?api_key=OYD2019%23dev"; export WS_CHANNEL="dec112"; export DEC_TRIG=$(<dec112.trig); docker-compose -f docker-compose.yml up -d
