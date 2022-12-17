FROM python:3.10.7-alpine3.16

LABEL maintainer="mathew.thomas@longdivision.com"
RUN apk add --update --no-cache bash bash-completion \
	libffi-dev tzdata git postgresql-client && \
	apk add --update --no-cache --virtual .tmp-build-deps \
		build-base postgresql-dev

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# RUN mkdir $HOME/.ssh
# RUN touch $HOME/.bashrc

RUN echo "alias ll='ls -alF'" >> $HOME/.bashrc \
	echo "alias la='ls -A'" >> $HOME/.bashrc \
	echo "alias l='ls -CF'" >> $HOME/.bashrc \
	echo "alias q='exit'" >> $HOME/.bashrc \
	echo "alias c='clear'" >> $HOME/.bashrc

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app/

ARG DEV=false
ENV VIRTUAL_ENV=/py
ENV PATH="${VIRTUAL_ENV}/bin:$PATH"

RUN python -m venv ${VIRTUAL_ENV}	&& \
	${VIRTUAL_ENV}/bin/pip install --upgrade pip && \
	${VIRTUAL_ENV}/bin/pip install -r /tmp/requirements.txt && \
	if [ $DEV = "true" ]; \
		then ${VIRTUAL_ENV}/bin/pip install -r /tmp/requirements.dev.txt ; \
	fi && \
	rm -rf /tmp && \
	apk del .tmp-build-deps && \
	adduser \
		-D \
		-H \
		django-user

USER django-user
EXPOSE 8000
CMD [ "bash" ]

