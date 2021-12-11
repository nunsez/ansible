%:
	@:
.SILENT:
.ONESHELL:
.PHONY: help app bin config db docs lib spec test tmp
.DEFAULT_GOAL = help
SHELL := /bin/bash
ARGS = $(filter-out $@, $(MAKECMDGOALS))
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

help:
	$(info TODO)

encrypt:
	ansible-vault encrypt --vault-password-file=.password $(ARGS)

view:
	ansible-vault view --vault-password-file=.password $(ARGS)

decrypt:
	ansible-vault decrypt --vault-password-file=.password $(ARGS)

test:
	ansible-playbook test.yml -i localhost,  --vault-password-file=.password

local:
	ansible-playbook env.yml -i inventory.ini --limit localhost --vault-password-file=.password

servers:
	ansible-playbook env.yml -i inventory.ini --vault-password-file=.password --limit servers -e ansible_user=$(user)

inventory:
	ansible-inventory -i inventory.ini --vault-password-file=.password --$(ARGS)

init:
	ansible-playbook init.yml -i inventory.ini --vault-password-file=.password --limit $(scope) -e ansible_user=$(user)
