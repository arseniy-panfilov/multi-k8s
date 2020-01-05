docker build -t arseniypanfilov/multi-client:latest -t arseniypanfilov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arseniypanfilov/multi-server:latest -t arseniypanfilov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arseniypanfilov/multi-worker:latest -t arseniypanfilov/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arseniypanfilov/multi-client:latest
docker push arseniypanfilov/multi-server:latest
docker push arseniypanfilov/multi-worker:latest

docker push arseniypanfilov/multi-client:$SHA
docker push arseniypanfilov/multi-server:$SHA
docker push arseniypanfilov/multi-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/server-deployment server=arseniypanfilov/multi-server:$SHA
kubectl set image deployments/client-deployment client=arseniypanfilov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arseniypaniflov/multi-worker:$SHA
