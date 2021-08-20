#!/bin/bash

set -euo pipefail

case "$(hostname)" in
  worker-0)
    ip route add 10.200.1.0/24 via 10.240.0.21
    ip route add 10.200.2.0/24 via 10.240.0.22
    ;;
  worker-1)
    ip route add 10.200.0.0/24 via 10.240.0.20
    ip route add 10.200.2.0/24 via 10.240.0.22
    ;;
  worker-2)
    ip route add 10.200.0.0/24 via 10.240.0.20
    ip route add 10.200.1.0/24 via 10.240.0.21
    ;;
  *)
    ip route add 10.200.0.0/24 via 10.240.0.20
    ip route add 10.200.1.0/24 via 10.240.0.21
    ip route add 10.200.2.0/24 via 10.240.0.22
    ;;
esac
