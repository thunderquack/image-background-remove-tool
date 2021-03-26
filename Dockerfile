FROM python:3.8.8

LABEL Author=ty@pidor.de

RUN apt-get update -y && \
    apt-get install

RUN apt-get install -y libwxgtk3.0-dev libwxgtk3.0-gtk3-dev libuchardet-dev \
                        libarchive-dev libxerces-c-dev libspdlog-dev libssh-dev \
                        libsmbclient-dev libnfs-dev

RUN wget https://github.com/unxed/far2l-deb/raw/master/far2l_2.2%7Eubuntu18.04_amd64.deb

RUN dpkg -i far2l_2.2~ubuntu18.04_amd64.deb >> /dev/null

COPY ./app /app

RUN pip3 install -r /app/requirements.txt --no-cache-dir

WORKDIR /app

RUN cd tools && python setup.py

WORKDIR /web

ENTRYPOINT [ "python3" ]

CMD [ "web.py" ]