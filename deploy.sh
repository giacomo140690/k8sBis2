docker build -t giacomopetru/multi-client:latest -t giacomopetru/multi-client$SHA -f ./client/Dockerfile ./client
docker build -t giacomopetru/multi-server:latest -t giacomopetru/multi-server$SHA -f ./server/Dockerfile ./server
docker build -t giacomopetru/multi-worker:latest -t giacomopetru/multi-worker$SHA -f ./worker/Dockerfile ./worker

docker push giacomopetru/multi-client:latest
docker push giacomopetru/multi-server:latest
docker push giacomopetru/multi-worker:latest

docker push giacomopetru/multi-client:$SHA
docker push giacomopetru/multi-server:$SHA
docker push giacomopetru/multi-worker:$SHA

kubectl apply -f k8sBis
kubectl set image deployments/server-deployments server=giacomopetru/multi-server:$SHA
kubectl set image deployments/client-deployments client=giacomopetru/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=giacomopetru/multi-worker:$SHA
