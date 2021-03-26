FROM python:3.8.8

LABEL Author=ty@pidor.de

RUN apt-get update -y && \
    apt-get install

RUN pip3 install pywebview==3.2 --no-cache-dir

RUN pip3 install numpy==1.18.2 --no-cache-dir

RUN pip3 install tqdm==4.43.0 --no-cache-dir

RUN pip3 install opencv_contrib_python==4.5.1.48 --no-cache-dir

RUN pip3 install scipy==1.6.2 --no-cache-dir

RUN pip3 install torch==1.8.0 --no-cache-dir

RUN pip3 install torchvision==0.9.0 --no-cache-dir

RUN pip3 install gluoncv==0.7.0 --no-cache-dir

RUN pip3 install gdown==3.11.1 --no-cache-dir

RUN pip3 install scikit_image==0.18.1 --no-cache-dir

RUN pip3 install Pillow==7.2.0 --no-cache-dir

RUN pip3 install mxnet==1.6.0 --no-cache-dir

RUN pip3 install flask==1.1.2 --no-cache-dir

RUN pip3 install tensorflow==2.4.1 --no-cache-dir

#RUN pip3 install -r /app/requirements.txt --no-cache-dir

COPY ./app /app

WORKDIR /app

RUN cd tools && python setup.py

ENTRYPOINT [ "python3" ]

CMD [ "app/app.py" ]