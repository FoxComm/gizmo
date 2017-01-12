FLYWAY=flyway -configFile=sql/flyway.conf -locations=filesystem:sql/

# Buildkite highlighting
RED = \033[33m
NO_COLOR = \033[0m
baseheader = @echo "---$(1)$(RED)$(2)$(NO_COLOR)"
header = $(call baseheader, $(1), gizmo)

glide:
	glide install

migrate:
	$(FLYWAY) migrate

reset:
	dropdb --if-exists gizmo
	dropuser --if-exists gizmo
	createuser -s gizmo
	createdb gizmo

test: 
	$(call header, Testing)
	make glide
	make reset
	make migrate
	go run examples/simple.go
	go run examples/sku.go

.PHONY: migrate reset test