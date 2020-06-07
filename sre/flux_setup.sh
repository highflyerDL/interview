#!/bin/bash
kubectl create ns flux
echo "Please input your git username:"
read GHUSER
fluxctl install \
--git-user=${GHUSER} \
--git-email=${GHUSER}@users.noreply.github.com \
--git-url=git@github.com:${GHUSER}/interview \
--git-path=namespaces,workloads \
--namespace=flux | kubectl apply -f -
kubectl -n flux rollout status deployment/flux
echo "Immediately sync your kube cluster with github..."
fluxctl sync --k8s-fwd-ns flux
