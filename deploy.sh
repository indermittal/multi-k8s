docker build -t indermittal/multi-client:latest -t indermittal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t indermittal/multi-server:latest -t indermittal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t indermittal/multi-worker:latest -t indermittal/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push indermittal/multi-client:latest
docker push indermittal/multi-server:latest
docker push indermittal/multi-worker:latest

docker push indermittal/multi-client:$SHA
docker push indermittal/multi-server:$SHA
docker push indermittal/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=indermittal/multi-server:$SHA
kubectl set image deployments/client-deployment client=indermittal/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=indermittal/multi-worker:$SHA