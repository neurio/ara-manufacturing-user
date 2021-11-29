REPO_NAME = ara-manufacturing-script
PROJECT = project
AWS_PROFILE := default

.PHONY: setup
setup:
	@aws codeartifact login \
		--tool pip \
		--repository ara-manufacturing \
		--domain ara-manufacturing \
		--domain-owner 693131387182 \
		--profile ${AWS_PROFILE}

authentication:
	@echo "AWS Credentials Needed"

package-installer:
	&& cd /ara-manufacturing-script \
	&& pip install ara-manufacturing-script \
