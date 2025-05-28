docker build -t maximeleblanc/multi-client-k8s:latest -t maximeleblanc/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t maximeleblanc/multi-server-k8s:latest -t maximeleblanc/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t maximeleblanc/multi-worker-k8s:latest -t maximeleblanc/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push maximeleblanc/multi-client-k8s:latest
docker push maximeleblanc/multi-server-k8s:latest
docker push maximeleblanc/multi-worker-k8s:latest

docker push maximeleblanc/multi-client-k8s:$SHA
docker push maximeleblanc/multi-server-k8s:$SHA
docker push maximeleblanc/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=maximeleblanc/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=maximeleblanc/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=maximeleblanc/multi-worker-k8s:$SHA