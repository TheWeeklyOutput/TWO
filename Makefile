#
#Use development settings for running django dev server.
export DJANGO_SETTINGS_MODULE=backend.settings_dev

ifeq (run-django,$(firstword $(MAKECMDGOALS)))
  PORT := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(PORT):;@:)
endif

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
	npm install --production

# Installs development requirements.
dev: venv
	$(VENV_PIP_PATH) install -r requirements.txt
	$(VENV_PIP_PATH) install -r requirements-dev.txt
	npm install

fixtures: 
	$(VENV_PYTHON_PATH) ./manage.py loaddata category
	$(VENV_PYTHON_PATH) ./manage.py loaddata author

# create super user
superuser: venv
	$(VENV_PYTHON_PATH) ./manage.py createsuperuser

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

# Creates migrations and migrates database.
# This step depends on `make dev`, however dependency is excluded to speed up dev server startup.
migrate: venv
	$(VENV_PYTHON_PATH) ./manage.py makemigrations generator
	$(VENV_PYTHON_PATH) ./manage.py makemigrations corpora

	$(VENV_PYTHON_PATH) ./manage.py makemigrations
	$(VENV_PYTHON_PATH) ./manage.py migrate

# Builds files for distribution which will be placed in /static/dist
build: prod migrate venv
	npm run build
	$(VENV_PYTHON_PATH) ./manage.py collectstatic


# Cleans up folder by removing virtual environment, node modules and generated files.
clean:
	rm -rf $(VENV_PATH)
	rm -rf node_modules
	rm -rf static/dist

# Run linter
lint:
	@npm run lint --silent
