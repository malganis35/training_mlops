Cao Tri DO Marvelous MLOps Training
==============================

[![Keyrus Badge](https://img.shields.io/badge/COMPANY-KEYRUS-003189?style=for-the-badge&logo=Keyrus&logoColor=00A3E0)](https://www.keyrus.com)
[![KeyrusFR Badge](https://img.shields.io/badge/COUNTRY-FR-28C6FF?style=for-the-badge&logo=Keyrus&logoColor=00A3E0)](https://www.keyrus.com)
[![KeyrusTeam Badge](https://img.shields.io/badge/TEAM-DATA--SCIENCE-FF9810?style=for-the-badge&logo=Keyrus&logoColor=00A3E0)](https://www.keyrus.com)

A short description of the project.


Project installation (Pre-requiresites)
---------------------------------------

We recommend to use ``pyenv`` for this project. If you do not have ``pyenv``, you can follow the instruction by using:

```
make help_setup
```

Alternatively, you can also use ``conda`` or ``venv``. You can check what is available for your system, by using:

```
make test_environment
```


Project installation (with pyenv)
---------------------------------

1. create a pyenv environment (``pyenv virtualenv 3.12.0 cao_tri_do_marvelous_mlops_training``) and activate it locally (``pyenv activate cao_tri_do_marvelous_mlops_training`` or ``pyenv local cao_tri_do_marvelous_mlops_training``). We easy this install by using a Makefile command:

```
make pyenv_env
```

2. install the requirements (python depedencies/packages, etc.)

```
make dev-install
```

4. run the main script with make run

```
make run
```

5. run the streamlit app

```
make run_app
```

6. run the FastAPI app

```
make run_api
```

7. (optional) clean your environment with ``pyenv virtualenv-delete cao_tri_do_marvelous_mlops_training``. We easy this install by using a Makefile command:

```
make delete_pyenv_env
```

Webservices: Streamlit & FastAPI (with docker)
---------------------------------------------

We provide also for Streamlit and FastAPI a Dockerfile and Docker Compose file.

1. You can launch the webservices with:

```
docker-compose up -d
```

The service are served by default:

- Streamlit App: http://localhost:8502
- FastAPI App: http://localhost:8601

2. You can shut down the services with:

```
docker-compose down
```

Technological Stack
-------------------
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![fastapi](https://img.shields.io/badge/FastAPI-005571?style=for-the-badge&logo=fastapi)
![docker](https://img.shields.io/badge/docker-257bd6?style=for-the-badge&logo=docker&logoColor=white)
![airflow](https://img.shields.io/badge/Apache%20Airflow-017CEE?style=for-the-badge&logo=Apache%20Airflow&logoColor=white)
![mlflow](https://img.shields.io/badge/mlflow-%23d9ead3.svg?style=for-the-badge&logo=numpy&logoColor=blue)

![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)
![GitLab](https://img.shields.io/badge/gitlab-%23181717.svg?style=for-the-badge&logo=gitlab&logoColor=white)
[![Git](https://img.shields.io/badge/Git-F05032?logo=git&logoColor=fff)](#)

![streamlit](https://img.shields.io/badge/-Streamlit-FF4B4B?style=flat&logo=streamlit&logoColor=white)
![sphinx](https://img.shields.io/badge/Sphinx-F7C942?style=flat&logo=sphinx&logoColor=white)


Project Organization
--------------------

    ├── Dockerfile            <- Dockerfile to install the project
    ├── docker-compose        <- Docker Compose to expose Streamlit and FastAPI as webservices
    ├── LICENSE               <- Open- or closed-source license if one is chosen
    ├── Makefile              <- Makefile with commands like `make run` or `make run_app`
    ├── README.md             <- The top-level README for developers using this project.
    │
    ├── data
    │   ├── external          <- Data from third party sources.
    │   ├── interim           <- Intermediate data that has been transformed.
    │   ├── processed         <- The final, canonical data sets for modeling.
    │   └── raw               <- The original, immutable data dump.
    │
    ├── docs                  <- A default Sphinx project; see sphinx-doc.org for details
    │
    ├── models                <- Trained and serialized models, model predictions, or model summaries
    │
    ├── notebooks             <- Jupyter notebooks. Naming convention is a number (for ordering),
    │                            the creator's initials, and a short `-` delimited description, e.g.
    │                            `1.0-jqp-initial-data-exploration`.
    │
    ├── pyproject.toml        <- Project configuration file with package metadata for
    │                            cao_tri_do_marvelous_mlops_training and configuration for tools like ruff
    │
    ├── references            <- Data dictionaries, manuals, and all other explanatory materials.
    │
    ├── reports               <- Generated analysis as HTML, PDF, LaTeX, etc.
    │   └── figures           <- Generated graphics and figures to be used in reporting
    │
    ├── requirements.txt      <- The requirements file for reproducing the analysis environment, e.g.
    │                            generated with `pipreqs`
    │
    ├── src                   <- Source code for use in this project.
    │   │
    │   ├──cao_tri_do_marvelous_mlops_training   <- Name of your package
    │   │   ├── __init__.py   <- Makes the package a Python module
    │   │   │
    │   │   ├── data          <- Module to extract / transform / load data
    │   │   │
    │   │   ├── features      <- Module to turn raw data into features for modeling
    │   │   │
    │   │   ├── models        <- Module to train models and then use trained models to make
    │   │   │                    predictions
    │   │   │
    │   │   ├── utils         <- Module for utility functions
    │   │   │
    │   │   └── visualization <- Module to create exploratory and results oriented visualizations
    │
    ├── .coveragerc           <- config file for pytest-coverage
    ├── .env.template         <- .env file template for credentials
    ├── .gitignore            <- Standard gitignore file for DS project
    ├── .gitlab-ci.yml        <- CI/CD for Gitlab
    └── .pre-commit-config.yaml <- pre-commit config file

--------

<p><small>Project based on the <a target="_blank" href="https://drivendata.github.io/cookiecutter-data-science/">cookiecutter data science project template</a>. #cookiecutterdatascience</small></p>
