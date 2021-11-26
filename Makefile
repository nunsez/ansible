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

main: install-requirements
	ansible-playbook localhost.yml -i inventory.ini --vault-password-file=.password


%:
	@:
.PHONY: app bin config db docs lib spec test tmp
