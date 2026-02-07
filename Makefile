all: compile build

.PHONY: build
build:
	docker build -t kubeflow/docs-agent-server-https server-https/
	docker build -t kubeflow/docs-agent-server server/

.PHONY: compile
compile:
	cd pipelines && python3 -m pip install -r requirements.txt
	python3 kubeflow-pipeline.py

.PHONY: test
test:
	pytest

.PHONY: lint
lint:
	flake8 .

.PHONY: clean
clean:
	rm -rf pipelines/github_rag_pipeline.yaml
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

