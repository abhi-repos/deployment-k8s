#!/bin/bash -
set -o nounset
BASE=$(cd "$(dirname "$0")" && pwd)
pushd "${BASE}"
for i in $(kubectl get pods -n kube-system | grep nginx-ingress | awk '{print $1}')
do
  echo "will kill ${i}"
  kubectl delete "pod/${i}" -n kube-system

  echo "Waiting 30 seconds for new pod to come up before killing next old pod..."
  sleep 30
done