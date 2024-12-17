#!/usr/bin/zsh

wg set wg0 peer $1  allowed-ips $2/32
