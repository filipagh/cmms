# Install Operating system and dependencies
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

#RUN #flutter doctor -v

# Copy files to container and build
COPY ./build/web /build/web
COPY  ./server/server.sh ./build/web/server.sh
COPY  ./server/server.py ./build/web/server.py

# Record the exposed port
EXPOSE 22222

RUN ["chmod", "+x", "./build/web/server.sh"]
ENTRYPOINT [ "./build/web/server.sh"]



