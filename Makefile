EXTENSION_NAME = LaunchDarkly
PREFIX = ld
EXTENSIONS_PATH = build/extensions

GOOGLE_CLOUD_PROJECT_ID = gauche-links

GCLOUD_BASE=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
APP_SERVER=$(GCLOUD_BASE)/bin/dev_appserver.py

HOST = https://eg.example.com/
GAUCHE_LINKS = $(GOPATH)/bin/gauche-links

VERSION = 1.0.0.0

HOST = http://localhost:8080/

ICON_PATH = images/favicon.png

run: build-extensions
	$(APP_SERVER) app.yaml

deploy: build-extensions
	gcloud app deploy --project ${GOOGLE_CLOUD_PROJECT_ID}

build-extensions:
	mkdir -p $(EXTENSIONS_PATH)
	-rm $(EXTENSIONS_PATH)/*.crx $(EXTENSIONS_PATH)/*.xpi
	go install github.com/launchdarkly/gauche-links/...
	$(GAUCHE_LINKS) -extensions -extensions-path $(EXTENSIONS_PATH) -prefix $(PREFIX) -icon $(ICON_PATH) -version $(VERSION) -host $(HOST)

.PHONY: build-extensions deploy run
