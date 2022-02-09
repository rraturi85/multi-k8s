docker build -t rraturi85/multi-client:latest -t rraturi85/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rraturi85/multi-server:latest -t rraturi85/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rraturi85/multi-worker:latest -t rraturi85/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rraturi85/multi-client:latest
docker push rraturi85/multi-server:latest
docker push rraturi85/multi-worker:latest

docker push rraturi85/multi-client:$SHA
docker push rraturi85/multi-server:$SHA
docker push rraturi85/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rraturi85/multi-server$SHA
kubectl set image deployments/client-deployment client=rraturi85/multi-client$SHA
kubectl set image deployments/worker-deployment worker=rraturi85/multi-worker$SHA