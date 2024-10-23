run:
	uv run uvicorn main:app --host 0.0.0.0 --port 8002 --reload --loop uvloop

metrics:
	curl http://localhost:8002/metrics

load_test:
	./load_test.sh

build:
	docker build -t fastapi-scale:latest .

docker_run:
	docker run -p 8002:8002 fastapi-scale:latest ash -c "uv run uvicorn main:app --host 0.0.0.0 --port 8002 --loop uvloop --timeout-keep-alive 3600"

kube_forward:
	kubectl port-forward svc/fastapi-scale-app 8002:80 -n fastapi

kube_forward_prometheus:
	kubectl port-forward -n monitoring svc/prometheus-server 9090:80

deploy:
	kubectl apply -f kubernetes/manifests/deployment.yaml -n fastapi
	kubectl rollout restart deployment fastapi-scale-app -n fastapi

build_and_deploy:
	make build
	make deploy
