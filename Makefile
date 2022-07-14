# Set this to any non-empty string to enable unoptimized
# build w/ debugging features.
debug ?=

ifdef debug
$(info debug is $(debug))
	release := 
	profile := debug
else
	release := --release
	debug := release
endif

CARGO_TARGET_DIR ?= targets
export CARGO_TARGET_DIR  # 'cargo' is sensitive to this env. var. value.

bin:
	mkdir -p $@

$(CARGO_TARGET_DIR):
	mkdir -p $@

.PHONY: build
build: bin $(CARGO_TARGET_DIR)
build:
	cargo build $(release)
	cp $(CARGO_TARGET_DIR)/$(profile)/device-worker-rs/ bin/device-worker-rs$(if $(debug),.debug,)

.PHONY: clean
clean:
	rm -rf bin
	if [[ "$(CARGO_TARGET_DIR)" == "targets" ]]; then rm -rf targets; fi
	$(MAKE) -C docs clean
