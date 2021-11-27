ARGS = $(filter-out $@, $(MAKECMDGOALS))
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

encrypt:
	ansible-vault encrypt --vault-password-file=.password $(ARGS)

view:
	ansible-vault view --vault-password-file=.password $(ARGS)

decrypt:
	ansible-vault decrypt --vault-password-file=.password $(ARGS)

test:
	ansible-playbook test.yml -i localhost, -e ansible_connection=local --vault-password-file=.password

local: install-requirements
	ansible-playbook playbook.yml -i inventory.ini --limit localhost --vault-password-file=.password

servers:
	ansible-playbook playbook.yml -i inventory.ini --limit servers --vault-password-file=.password

%:
	@:
.PHONY: app bin config db docs lib spec test tmp
