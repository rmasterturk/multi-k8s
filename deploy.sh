docker build -t unaldeniz/multi-client:latest -t unaldeniz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t unaldeniz/multi-server:latest -t unaldeniz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t unaldeniz/multi-worker:latest -t unaldeniz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push unaldeniz/multi-client:latest
docker push unaldeniz/multi-server:latest
docker push unaldeniz/multi-worker:latest

docker push unaldeniz/multi-client:latest:$SHA
docker push unaldeniz/multi-server:latest:$SHA
docker push unaldeniz/multi-worker:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=unaldeniz/multi-server:$SHA
kubectl set image deployments/client-deployment client=unaldeniz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=unaldeniz/multi-worker:$SHA


