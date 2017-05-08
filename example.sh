#!/bin/bash

sudo service ssh start

[ -n "$1" ] && sudo service $1 start

