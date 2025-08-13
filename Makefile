.PHONY: build
build:
	flatpak run org.flatpak.Builder --force-clean --user --install --install-deps-from=flathub --ccache --mirror-screenshots-url=https://dl.flathub.org/media/ --repo=repo builddir community.awakenedpoetrade.AwakenedPoETrade.yml	

.PHONY: update-sources
update-sources:
	@bash update-sources.sh

.PHONY: run
run:
	flatpak run community.awakenedpoetrade.AwakenedPoETrade

.PHONY: debug
debug:
	flatpak run --devel --command=bash community.awakenedpoetrade.AwakenedPoETrade
