default: lint

.Phony: lint
lint:
	npx eslint --fix .

.Phony: install
install:
	npm install
