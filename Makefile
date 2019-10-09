#!make
DEST := dist
arch = x64
platform = darwin
APPS := Maconomy Messenger sr
maconomy_version := v1.0.0
messenger_version := v1.0.0
sverigesradio_version := v1.0.0

EXECUTABLES = nativefier tar
K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell command -v $(exec)),some string,$(error "No command '$(exec)' in PATH")))

.PHONY: default
default: 
	@printf "Please run with a target : make <TARGET> \nAvailable targets: ${APPS}"

.PHONY: clean
clean: 
	rm -rf $(DEST)

.PHONY: Maconomy
Maconomy: clean
	$(eval archive := "$(DEST)/$@-$(maconomy_version)-$(platform)-$(arch).tgz")
	nativefier --name "$@" --app-version $(maconomy_version) \
				--arch $(arch) --platform $(platform) \
				"https://me71619-iaccess.deltekfirst.com/maconomy" \
				$(DEST)
	tar -zcvf $(archive) -C $(DEST) .
	@echo "The application was built, see archive $(archive)"

.PHONY: Messenger
Messenger: clean
	$(eval archive := "$(DEST)/$@-$(messenger_version)-$(platform)-$(arch).tgz")
	nativefier --name "$@" --app-version $(messenger_version) \
				--arch $(arch) --platform $(platform) \
				"https://www.messenger.com" \
				$(DEST)
	tar -zcvf $(archive) -C $(DEST) .
	@echo "The application was built, see archive $(archive)"

.PHONY: sr
sr: clean
	$(eval archive := "$(DEST)/$@-$(messenger_version)-$(platform)-$(arch).tgz")
	nativefier --name "$@" --app-version $(messenger_version) \
				--arch $(arch) --platform $(platform) \
				"https://sverigesradio.se/" \
				$(DEST)
	tar -zcvf $(archive) -C $(DEST) .
	@echo "The application was built, see archive $(archive)"

