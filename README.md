# hello_django_api

My template for Django API projects using [Django Rest Framework](https://www.django-rest-framework.org/) \
and [Postgres](https://www.postgresql.org/) all running under [Docker](https://www.docker.com/).

## Setting up a new project

### Copy all these files into your new project folder

### Make the main project `app` directory

```bash
mkdir app
```

### Build the `web` service.

```bash
docker-compose build web
```

### Create the main project app

```bash
docker-compose run --rm web sh -c "/py/bin/django-admin startproject app ."
```

### Run the `flake8` linter

```bash
docker-compose run --rm web sh -c "flake8"; docker-compose down
```

### Run unit tests

```bash
docker-compose run --rm web sh -c "python manage.py test"; docker-compose down
```

