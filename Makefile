.DEFAULT: help
help:
	@echo "make setup - prepare production environment"
	@echo "make install - install nrf-jlink programming command line tools. This will also run setup as prerequisite."
	@echo "make clean - clean up environment and remove all installed packages"


.PHONY: setup
setup:
	@echo "[MAKE] Running Setup..."
	sudo apt-get -y install python3.8 python3-pip unzip
	sudo apt install wget

	wget -N --timestamping https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
	unzip -n awscli-exe-linux-x86_64.zip
	sudo ./aws/install --update
	
	wget -N --timestamping https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/10-15-1/nrf-command-line-tools-10.15.1_Linux-amd64.zip

	aws configure get aws_access_key_id --profile ara_production_user >> /dev/null || aws configure --profile ara_production_user

	@echo "[MAKE] Setup Complete!"

.PHONY: authenticate_pip
authenticate_pip:
	@aws codeartifact login \
		--tool pip \
		--domain ara-manufacturing \
		--domain-owner 693131387182 \
		--repository ara-manufacturing \
		--profile ara_production_user

.PHONY: install
install: setup authenticate_pip
	@pip install --upgrade ara-manufacturing
	sudo mkdir -p ./nrf-command-line-tools-10-15-1-linux-amd64/
	sudo unzip -n nrf-command-line-tools-10.15.1_Linux-amd64.zip -d ./nrf-command-line-tools-10-15-1-linux-amd64/
	sudo dpkg -i nrf-command-line-tools-10-15-1-linux-amd64/JLink_Linux_V758b_x86_64.deb
	sudo apt-get install -f
	sudo dpkg -i nrf-command-line-tools-10-15-1-linux-amd64/nrf-command-line-tools_10.15.1_amd64.deb
	sudo apt-get install -f

.PHONY: clean
clean:
	sudo rm -rf nrf-command-line-tools-10-15-1-linux-amd64/
	sudo rm -f nrf-command-line-tools-10.15.1_Linux-amd64.zip
	sudo apt-get purge wget unzip -y
	sudo rm awscliv2.zip
	sudo rm -rf aws
	sudo rm -rf /usr/local/aws-cli
	sudo rm /usr/local/bin/aws
	sudo rm /usr/local/bin/aws_completer
