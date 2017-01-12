FLYWAY=flyway -configFile=sql/flyway.conf -locations=filesystem:sql/

migrate:
	$(FLYWAY) migrate

reset:
	dropdb --if-exists gizmo
	dropuser --if-exists gizmo
	createuser -s gizmo
	createdb gizmo

test: reset migrate
	go run examples/simple.go
	go run examples/sku.go

.PHONY: migrate reset test