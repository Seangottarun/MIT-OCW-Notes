#!/bin/bash

pidwait () {
    # first argument is a pid for the process to wait for
    wait "$1"
    ls
}
