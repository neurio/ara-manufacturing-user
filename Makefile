REPO_NAME = ara-manufacturing-script
PROJECT = project
AWS_PROFILE := default

TMPDIR := $(shell mktemp -d awscli-temp-XXXXXXXX)
BINDIR := $(HOME)/bin
INSTALLDIR := $(HOME)/.local/lib/aws-cli


.PHONY: setup
setup: 
	$(TMPDIR)/aws
	mkdir -p $(BINDIR) $(INSTALLDIR)
	$(TMPDIR)/aws/install --bin-dir $(BINDIR) --install-dir $(INSTALLDIR)
	-rm -rf $(TMPDIR)

	$(TMPDIR)/aws
	$(TMPDIR)/aws/install --bin-dir $(BINDIR) --install-dir $(INSTALLDIR) --update
	-rm -rf $(TMPDIR)
	
	@aws codeartifact login \
		--tool pip \
		--domain ara-manufacturing \
		--domain-owner 693131387182 \
		--repository ara-manufacturing \

.PHONY: build
package-installer:
	&& cd /ara-manufacturing-script \
	&& pip install ara-manufacturing-script \
