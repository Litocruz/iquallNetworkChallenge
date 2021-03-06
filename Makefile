
.PHONY: help

INVENTORY_FILE = inventory.yml

help: ## Print this help.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

default: up


install: ## Corre ansible
	ansible-playbook -i $(INVENTORY_FILE) playbooks/all.yml -K

monitor: ## Corre ansible
	ansible-playbook -i $(INVENTORY_FILE) playbooks/grafana.yml -K
