#!/bin/sh
tc qdisc add dev enp1s0 root tbf rate 1000mbit burst 1mb limit 10mb