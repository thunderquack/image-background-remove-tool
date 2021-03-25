FROM python:latest

LABEL Author=ty@pidor.de

RUN apt-get update -y && \
    apt-get install

COPY ./requirements.txt /app/requirements.txt

WORKDIR /

RUN pip3 install -r /app/requirements.txt

COPY . /app

ENTRYPOINT [ "python3" ]

CMD [ "app/app.py" ]