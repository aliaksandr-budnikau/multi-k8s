docker build -t alexanderbudnikov/multi-client:latest -t alexanderbudnikov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexanderbudnikov/multi-server:latest -t alexanderbudnikov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexanderbudnikov/multi-worker:latest -t alexanderbudnikov/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alexanderbudnikov/multi-client:latest
docker push alexanderbudnikov/multi-server:latest
docker push alexanderbudnikov/multi-worker:latest

docker push alexanderbudnikov/multi-client:$SHA
docker push alexanderbudnikov/multi-server:$SHA
docker push alexanderbudnikov/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alexanderbudnikov/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexanderbudnikov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexanderbudnikov/multi-worker:$SHA


