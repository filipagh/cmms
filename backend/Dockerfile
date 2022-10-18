FROM python:3.9

ARG ROOT_PATH
ENV ROOT_PATH ${ROOT_PATH}
ENV BE_PORT ${BE_PORT}

WORKDIR /backend

COPY ./requirements.txt /backend/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /backend/requirements.txt
RUN pip install --no-cache-dir --upgrade attrs
RUN pip install --no-cache-dir --upgrade python-dateutil

COPY . /backend

CMD ./run.sh
