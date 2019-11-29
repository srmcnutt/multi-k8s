docker build -t smcnutt/multi-client:lastest -t smcnutt/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t smcnutt/multi-server:latest -t smcnutt/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t smcnutt/multi-worker:latest -t smcnutt/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push smcnutt/multi-client:latest
docker push smcnutt/multi-server:latest
docker push smcnutt/multi-worker:latest
docker push smcnutt/multi-client:$SHA
docker push smcnutt/multi-server:$SHA
docker push smcnutt/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=smcnutt/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=smcnutt/multi-worker:$SHA
kubectl set image deployments/client-deployment client=smcnutt/multi-client:$SHA