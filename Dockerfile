FROM python:3.7

MAINTAINER ty@pidor.de

RUN apt-get update

RUN apt-get install -y libwxgtk3.0-dev libwxgtk3.0-gtk3-dev libuchardet-dev \
                        libarchive-dev libxerces-c-dev libspdlog-dev libssh-dev \
                        libsmbclient-dev libnfs-dev libpcre3-dev wget

RUN wget https://github.com/unxed/far2l-deb/raw/master/far2l_2.2%7Eubuntu18.04_amd64.deb

RUN dpkg -i far2l_2.2~ubuntu18.04_amd64.deb >> /dev/null

RUN apt update && apt upgrade -y

RUN pip3 install --upgrade pip

COPY ./app/requirements.txt /app/requirements.txt

RUN pip3 install -r /app/requirements.txt --no-cache-dir

COPY ./app /app

RUN cd /app/tools && python setup.py

WORKDIR /app

RUN pip3 install flask

ENTRYPOINT [ "python3" ]

CMD [ "/web/web.py" ]