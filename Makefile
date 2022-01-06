.DEFAULT: help
help:
	@echo "make setup - prepare production environment"
	@echo "make install - install nrf-jlink programming command line tools. This will also run setup as prerequisite."
	@echo "make clean - clean up environment and remove all installed packages"


.PHONY: setup
setup:
	@echo "running setup"
	sudo apt-get -y install python3.8 python3-pip
	python3 -m pip install virtualenv
	sudo apt install wget
	sudo apt-get install unzip

	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
	
	wget https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/10-15-1/nrf-command-line-tools-10.15.1_Linux-amd64.zip

	@aws configure

	@aws codeartifact login \
		--tool pip \
		--domain ara-manufacturing \
		--domain-owner 693131387182 \
		--repository ara-manufacturing \

	@echo "setup complete"

.PHONY: install
install: setup
	@pip install ara-manufacturing
	sudo mkdir -p ./nrf-command-line-tools-10-15-1-linux-amd64/
	sudo unzip nrf-command-line-tools-10.15.1_Linux-amd64.zip -d ./nrf-command-line-tools-10-15-1-linux-amd64/
	sudo dpkg -i nrf-command-line-tools-10-15-1-linux-amd64/JLink_Linux_V758b_x86_64.deb
	sudo apt-get install -f
	sudo dpkg -i nrf-command-line-tools-10-15-1-linux-amd64/nrf-command-line-tools_10.15.1_amd64.deb
	sudo apt-get install -f

.PHONY: clean
clean:
	sudo rm -rf nrf-command-line-tools-10-15-1-linux-amd64/
	sudo rm -f nrf-command-line-tools-10.15.1_Linux-amd64.zip
	sudo apt-get purge virtualenv wget unzip
	sudo rm awscliv2.zip
	sudo rm -rf aws
	sudo rm -rf /usr/local/aws-cli
	sudo rm /usr/local/bin/aws
	sudo rm /usr/local/bin/aws_completer
