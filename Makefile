# Source for a good Python Makefile: https://gist.github.com/genyrosk/2a6e893ee72fa2737a6df243f6520a6d

#################################################################################
# GLOBALS                                                                       #
#################################################################################

PROJECT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PROJECT_NAME = cao_tri_do_marvelous_mlops_training
PACKAGE_NAME = cao_tri_do_marvelous_mlops_training
PYTHON_INTERPRETER = python3
PYTHON_VERSION = 3.12.0
PORT_STREAMLIT = 8502
PORT_FASTAPI = 8601

#################################################################################
# PROJECT RULES                                                                 #
#################################################################################
.PHONY: run_app run

## Run the demo app
run_app:
	@echo "$(ccso)--> Run the demo app$(ccend)"
	cd app && streamlit run app_demo.py --server.port=$(PORT_STREAMLIT)

## Run the script demo
run:
	@echo "$(ccso)--> Run the Script demo$(ccend)"
	cd src && python main_script.py

## Run FastAPI server
run_api:
	@echo "$(ccso)--> Run the FastAPI Service$(ccend)"
	@echo "See the API at: http://localhost:$(PORT_FASTAPI)/docs"
	uvicorn app.api_demo:app --port $(PORT_FASTAPI) --host 0.0.0.0 --reload

#################################################################################
# COMMANDS (INSTALL / SETUP)                                                    #
#################################################################################
.PHONY: dev-install prod-install

## Install Python Dependencies (Dev)
dev-install: test_environment
	@echo "$(ccso)--> Install Python Dependencies (Dev)$(ccend)"
	$(PYTHON_INTERPRETER) -m pip install uv
	$(PYTHON_INTERPRETER) -m uv pip install -U pip setuptools wheel
	$(PYTHON_INTERPRETER) -m uv pip install --upgrade pip
	$(PYTHON_INTERPRETER) -m uv pip install -e ".[dev]"
	@pre-commit install

## Install Python Dependencies (Prod)
prod-install: test_environment
	@echo "$(ccso)--> Install Python Dependencies (Dev)$(ccend)"
	$(PYTHON_INTERPRETER) -m pip install uv
	$(PYTHON_INTERPRETER) -m uv pip install -U pip setuptools wheel
	$(PYTHON_INTERPRETER) -m uv pip install --upgrade pip
	$(PYTHON_INTERPRETER) -m uv pip install .

## Install Sphinx Dependencies (Documentation)
doc-install:
	@echo "$(ccso)--> Install Sphinx Documentation Dependencies (Dev)$(ccend)"
	$(PYTHON_INTERPRETER) -m uv pip install -r docs/cao_tri_do_marvelous_mlops_training/requirements.txt

#################################################################################
# COMMANDS (CODE QUALITY)                                                       #
#################################################################################
.PHONY: qa_lines_count test pc

## Code quality: count nb lines in each *.py files
qa_lines_count:
	@echo "$(ccso)--> Count the number of lines in each *.py script$(ccend)"
	@find ./ -name '*.py' -exec  wc -l {} \; | sort -n| awk \
        '{printf "%4s %s\n", $$1, $$2}{s+=$$0}END{print s}'
	@echo ''

## Run unit test and coverage
test:
	@echo "$(ccso)--> Run unit test and coverage$(ccend)"
	@pytest --cov src/$(PACKAGE_NAME) --cov-report=html:_artifact/coverage_re --cov-report=term-missing --cov-config=.coveragerc
	@echo "Note: you can open the HTML report with: open _artifact/coverage_re/index.html"
	@echo

## Run pre-commit hooks
pc:
	@echo "$(ccso)--> Run pre-commit rules$(ccend)"
	@pre-commit run --all-files

#################################################################################
# UTILITIES                                                                 #
#################################################################################
.PHONY: pipreqs generate_docs create-env-template

## Generate a requirements-tmp.txt file from the src/ folder
pipreqs:
	@echo "$(ccso)--> Generate a requirements-tmp.txt file from the src/ folder$(ccend)"
	@pipreqs src/ --savepath requirements-tmp.txt
	@echo "List of the standard packages used in the code"
	@cat requirements-tmp.txt

## Auto-generate the rst file for the Sphinx documentation
generate_docs:
	@echo "$(ccso)--> Generate the RST file for the Sphinx documentation$(ccend)"
	$(PYTHON_INTERPRETER) -m uv pip install sphinx
	sphinx-apidoc -o ./docs/source_code src/
	@echo "RST files are available at: ./docs/source_code"

# Create the .env-template from .env
create-env-template: $(ENV_FILE)
	@echo "$(ccso)--> Create the template file $(TEMPLATE_FILE) from $(ENV_FILE)$(ccend)"
	@awk -F'=' '{print $$1"=\"\""}' $(ENV_FILE) > $(TEMPLATE_FILE)
	@echo "Fichier $(TEMPLATE_FILE) créé avec succès"

#################################################################################
# Self Documenting Commands                                                     #
#################################################################################
.PHONY: help_setup

## Initial setup to follow
help_setup:
	@echo "$(ccso)--> Initial setup to follow$(ccend)"
	@echo "1. (optional) install pyenv if not already installed: curl https://pyenv.run | bash"
	@echo "2. (recommanded) test to see what python virtual environment manager is present in your system: make test_environment"
	@echo "3. create a pyenv environment with pyenv virtualenv system cao_tri_do_marvelous_mlops_training"
	@echo "4. activate your local environment with pyenv activate cao_tri_do_marvelous_mlops_training"
	@echo "**Note**: you can install step 3 and 4 using: make pyenv_env"
	@echo "5. install the requirements using: make dev-install"
	@echo "6. run the app using: make run (script) or make run_app (streamlit app)"
	@echo "7. (optional) clean your environment using: pyenv virtualenv-delete cao_tri_do_marvelous_mlops_training"
	@echo

.DEFAULT_GOAL := help

# Inspired by <http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>
# sed script explained:
# /^##/:
# 	* save line in hold space
# 	* purge line
# 	* Loop:
# 		* append newline + line to hold space
# 		* go to next line
# 		* if line starts with doc comment, strip comment character off and loop
# 	* remove target prerequisites
# 	* append hold space (+ newline) to line
# 	* replace newline plus comments by `---`
# 	* print line
# Separate expressions are necessary because labels cannot be delimited by
# semicolon; see <http://stackoverflow.com/a/11799865/1968>
.PHONY: help
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) = Darwin && echo '--no-init --raw-control-chars')
	@echo

#################################################################################
# ENV CHECK & CONFIGURATION                                                     #
#################################################################################

# Colors for echos
ccend=$(shell tput sgr0)
ccbold=$(shell tput bold)
ccgreen=$(shell tput setaf 2)
ccred=$(shell tput setaf 1)
ccso=$(shell tput smso)

# Check if Anaconda is present in the system
ifeq (,$(shell which conda))
HAS_CONDA=False
else
HAS_CONDA=True
endif

# Check if Pyenv is present in the system
ifeq (,$(shell which pyenv))
HAS_PYENV=False
else
HAS_PYENV=True
endif

# Check if Poetry is present in the system
ifeq (,$(shell which poetry))
HAS_POETRY=False
else
HAS_POETRY=True
endif

# Check if the current directory if a git repo
IS_GIT_REPO := $(shell git rev-parse --is-inside-work-tree 2>/dev/null)

#################################################################################
# COMMANDS (GENERAL)                                                            #
#################################################################################

## Delete all compiled Python files
clean:
	@echo "$(ccso)--> Delete all compiled Python files$(ccend)"
	find . -type f -name "*.py[co]" -delete
	find . -type d -name "__pycache__" -delete

## Test python environment is setup correctly
test_environment:
	@echo "$(ccso)--> Test the local virtual env systems available$(ccend)"
ifeq (True,$(HAS_CONDA))
	@echo ">>> Conda is $(ccgreen)available$(ccend)"
else
	@echo ">>> Conda is $(ccred)not available$(ccend)"
endif
ifeq (True,$(HAS_PYENV))
	@echo ">>> Pyenv is $(ccgreen)available$(ccend)"
else
	@echo ">>> Pyenv is $(ccred)not available$(ccend)"
endif
ifeq (True,$(HAS_POETRY))
	@echo ">>> Poetry is $(ccgreen)available$(ccend)"
else
	@echo ">>> Poetry is $(ccred)not available$(ccend)"
endif

conda_env:
	@echo "$(ccso)--> Set up python interpreter environment (conda)$(ccend)"
ifeq (True,$(HAS_CONDA))
		@echo ">>> Detected conda, creating conda environment."
ifeq (3,$(findstring 3,$(PYTHON_INTERPRETER)))
	conda create --name $(PROJECT_NAME) python=3
else
	conda create --name $(PROJECT_NAME) python=2.7
endif
		@echo ">>> New conda env created. Activate with:\nsource activate $(PROJECT_NAME)"
else
	@echo ">>> No virtualenv packages installed. Please install one above first"
endif

## Set up python interpreter environment (pyenv)
pyenv_env:
	@echo "$(ccso)--> Set up python interpreter environment (pyenv)$(ccend)"
ifeq (True,$(HAS_PYENV))
	@echo ">>> Detected pyenv, creating pyenv environment."
	pyenv virtualenv $(PYTHON_VERSION) $(PROJECT_NAME)
	@echo ">>> New pyenv created. Activate with: pyenv activate $(PROJECT_NAME)"
	pyenv local $(PROJECT_NAME)
	@echo ">>> By default, the pyenv is activated in the local folder"
else
	@echo ">>> No virtualenv packages installed. Please install one above first"
endif

## Delete pyenv environment
delete_pyenv_env:
	@echo "$(ccso)--> Delete pyenv environment$(ccend)"
	pyenv virtualenv-delete $(PROJECT_NAME)

#################################################################################
# COMMANDS (DATA SETUP)                                                         #
#################################################################################
.PHONY: data sync_data_to_s3 sync_data_from_s3

## Make Dataset
data:
	@echo "$(ccso)--> Make / Download the Dataset$(ccend)"
	@cd src/cao_tri_do_marvelous_mlops_training/data && python make_dataset.py ../../../data/raw ../../../data/processed
