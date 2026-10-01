#!/usr/bin/env bash

_detect_gpu() {
    [[ -n "${gpus+x}" ]] && return 0
    gpus=$(lspci | grep -i 'VGA\|3D\|Display' || true)
    has_nvidia=false; has_amd=false; has_intel=false
    grep -qi nvidia        <<<"$gpus" && has_nvidia=true
    grep -qi 'amd\|radeon' <<<"$gpus" && has_amd=true
    grep -qi intel         <<<"$gpus" && has_intel=true
    return 0
}
