
# Use development settings for running django dev server.
ifeq ($(PRODUCTION),true)
	export DJANGO_SETTINGS_MODULE=backend.settings
else
	export DJANGO_SETTINGS_MODULE=backend.settings_dev
endif

# args
ifeq (run-django,$(firstword $(MAKECMDGOALS)))
  PORT := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(PORT):;@:)
endif

ifeq (management,$(firstword $(MAKECMDGOALS)))
  SUBCMD := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(SUBCMD):;@:)
endif

# virtualenv
VENV_PATH = .env
VENV_ACTIVATE_PATH = $(VENV_PATH)/bin/activate
VENV_PIP_PATH = $(VENV_PATH)/bin/pip
VENV_PYTHON_PATH = $(VENV_PATH)/bin/python

venv:
	test -d $(VENV_PATH) || virtualenv $(VENV_PATH) --python=python3
	touch $(VENV_ACTIVATE_PATH)

# Initializes virtual environment with basic requirements.
prod: venv
	$(VENV_PIP_PATH) install -Ur requirements.txt
	rm -rf node_modules/

	npm install --production

# Installs development requirements.
dev: venv
	$(VENV_PIP_PATH) install -r requirements.txt
	$(VENV_PIP_PATH) install -r requirements-dev.txt
	rm -rf node_modules/
	npm install

# Django Management
management: venv
	$(VENV_PYTHON_PATH) ./manage.py $(SUBCMD)

ping-google: venv
	$(VENV_PYTHON_PATH) ./manage.py ping_google

fixtures: venv
	$(VENV_PYTHON_PATH) ./manage.py loaddata site
	$(VENV_PYTHON_PATH) ./manage.py loaddata outlet
	$(VENV_PYTHON_PATH) ./manage.py loaddata contenttype
	$(VENV_PYTHON_PATH) ./manage.py loaddata category
	$(VENV_PYTHON_PATH) ./manage.py loaddata author
	$(VENV_PYTHON_PATH) ./manage.py loaddata corpus
	$(VENV_PYTHON_PATH) ./manage.py loaddata generateddocument

# Creates migrations and migrates database.
migrate: venv
	$(VENV_PYTHON_PATH) ./manage.py makemigrations
	$(VENV_PYTHON_PATH) ./manage.py makemigrations corpora

	$(VENV_PYTHON_PATH) ./manage.py migrate

# run syncdb
syncdb: venv
	$(VENV_PYTHON_PATH) ./manage.py migrate --run-syncdb

db-backup:
	- mkdir .db_backups
	mv db.sqlite3 .db_backups/$(shell date +'%y.%m.%d-%H:%M:%S').sqlite3
	@echo "Database Backup: .db_backups/$(shell date +'%y.%m.%d-%H:%M:%S').sqlite3"

new-db:
	@echo "All data in db.sqlite3 will be lost."
	@read -p "Press any key to continue or Ctrl + C to abort." fake;

	make db-backup
	rm -f db.sqlite3

	make syncdb
	make migrate
	make fixtures
	make superuser

# create super user
superuser: venv
	$(VENV_PYTHON_PATH) ./manage.py createsuperuser

# git
pull:
	bash scripts/pull.sh

commit:
	bash scripts/commit.sh

push:
	bash scripts/push.sh

commitpush: commit push

# Runs development server.
# This step depends on `make dev`, however dependency is excluded to speed up dev server startup.
run-dev: venv
	npm run dev & $(VENV_PYTHON_PATH) ./manage.py runserver

#run-npm run-django
run-npm: venv
	npm run dev

run-django: venv
	$(VENV_PYTHON_PATH) ./manage.py runserver 0.0.0.0:$(PORT)

# Builds files for distribution which will be placed in /static/dist
build: prod migrate venv
	npm run build
	$(VENV_PYTHON_PATH) ./manage.py collectstatic --noinput

# Cleans up folder by removing virtual environment, node modules and generated files.
clean-deps:
	rm -rf $(VENV_PATH)
	rm -rf node_modules
	rm -rf static/dist
# Clears migrations
clean-migrations:
	rm -rf backend/corpora/migrations/*
# Run linter
lint:
	@npm run lint --silent
