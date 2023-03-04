FROM python:3.10

ARG ROOT_PATH
ENV ROOT_PATH ${ROOT_PATH}
ENV BE_PORT ${BE_PORT}
ENV BE_PATH ${BE_PATH}

WORKDIR /backend

COPY ./backend/requirements.txt /backend/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /backend/requirements.txt
RUN pip install --no-cache-dir --upgrade attrs
RUN pip install --no-cache-dir --upgrade python-dateutil

COPY ./backend /backend

CMD ./run.sh
