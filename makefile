dc=docker-compose -f docker-compose.yml $(1)
dc-run=$(call dc, run --rm web $(1))

usage:
	@echo "Available targets:"
	@echo "  * setup        		  - Initiates everything (building images, installing gems, creating db and migrating"
	@echo "  * build        		  - Build image"
	@echo "  * bundle       		  - Install missing gems"
	@echo "  * dev          		  - Fires a shell inside your container"
	@echo "  * up           		  - Runs the development server"
	@echo "  * tear-down    		  - Removes all the containers and tears down the setup"
	@echo "  * stop         		  - Stops the server"
	@echo "  * test         		  - Runs tests"
	@echo "  * lint         		  - Runs rubocop linters"
	@echo "  * console         		- Fires up rails console"

# With db
setup: build bundle

build:
	$(call dc, build)
bundle:
	$(call dc-run, bundle install)
dev:
	$(call dc-run, ash)
up:
	$(call dc, up)
tear-down:
	$(call dc, down)
stop:
	$(call dc, stop)
test:
	$(call dc-run, bundle exec rspec)
lint:
	$(call dc-run, bundle exec rubocop)
console:
	$(call dc-run, bundle exec rails console)

