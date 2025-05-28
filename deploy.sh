docker build -t maximeleblanc/multi-client:latest -t maximeleblanc/multi-client:$SHA -f ./client/Dockerfile client
docker build -t maximeleblanc/multi-server:latest -t maximeleblanc/multi-server:$SHA -f ./server/Dockerfile server
docker build -t maximeleblanc/multi-worker:latest -t maximeleblanc/multi-worker:$SHA -f ./worker/Dockerfile worker
docker push maximeleblanc/multi-client:latest
docker push maximeleblanc/multi-server:latest
docker push maximeleblanc/multi-worker:latest
docker push maximeleblanc/multi-client:$SHA
docker push maximeleblanc/multi-server:$SHA
docker push maximeleblanc/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=maximeleblanc/multi-server:$SHA
kubectl set image deployments/client-deployment client=maximeleblanc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=maximeleblanc/multi-worker:$SHA