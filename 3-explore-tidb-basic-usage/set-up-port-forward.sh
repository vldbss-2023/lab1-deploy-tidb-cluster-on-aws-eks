#! /bin/bash

trap "exit" INT TERM ERR
trap "kill 0" EXIT

kubectl port-forward svc/basic-tidb 4000:4000 &
kubectl port-forward svc/basic-tidb-dashboard-exposed 12333:12333 &
kubectl port-forward svc/basic-grafana 3000:3000 &

wait
