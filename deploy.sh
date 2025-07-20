docker build -t alfa2beta/multi-client:latest -t alfa2beta/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alfa2beta/multi-server:latest -t alfa2beta/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alfa2beta/multi-worker:latest -t alfa2beta/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alfa2beta/multi-client:latest
docker push alfa2beta/multi-server:latest
docker push alfa2beta/multi-worker:latest

docker push alfa2beta/multi-client:$SHA
docker push alfa2beta/multi-server:$SHA
docker push alfa2beta/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/server-deployment server=alfa2beta/multi-server:$SHA
kubectl set image deployment/client-deployment client=alfa2beta/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=alfa2beta/multi-worker:$SHA