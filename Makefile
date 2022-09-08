STYLUA=stylua
STYLUA_FLAGS=--config-path .stylua.toml

format:
	$(STYLUA) $(STYLUA_FLAGS) .

.PHONY: format
