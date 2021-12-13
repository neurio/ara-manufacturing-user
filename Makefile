.DEFAULT: help
help:
	@echo "make setup"
	@echo "prepare production environment"

.PHONY: setup build
setup:
	@echo "running setup"
	sudo apt-get -y install python3.5 python3-pip
	python3 -m pip install virtualenv
	
	@aws codeartifact login \
		--tool pip \
		--domain ara-manufacturing \
		--domain-owner 693131387182 \
		--repository ara-manufacturing \

	@pip install ara-manufacturing
	@echo "setup complete"