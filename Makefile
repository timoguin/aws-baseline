VENV_DIR := .venv
VENV_CMD := poetry run

.PHONY: all venv build serve deploy

all: venv build

venv: $(VENV_DIR)

$(VENV_DIR):
	@echo "Creating Python virtual environment"
	@python3 -m venv $(VENV_DIR)
	poetry install 
	@echo
	@echo "A Python virtual environment has been created in the \".venv/\" directory."
	@echo "To activate it, run the \"poetry shell\" command."

build:
	$(VENV_CMD) mkdocs build

serve:
	$(VENV_CMD) mkdocs serve

deploy:
	$(VENV_CMD) mkdocs gh-deploy
