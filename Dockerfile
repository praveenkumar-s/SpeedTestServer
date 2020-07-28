FROM ubuntu:16.04

RUN apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository ppa:jonathonf/python-3.6


RUN apt-get install -y build-essential python3.6 python3.6-dev python3-pip python3.6-venv
RUN apt-get install -y git

# update pip
RUN python3.6 -m pip install pip --upgrade
RUN python3.6 -m pip install wheel
RUN apt-get install gnupg1 apt-transport-https dirmngr
RUN export INSTALL_KEY=379CE192D401AB61
RUN export DEB_DISTRO=$(lsb_release -sc)
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $INSTALL_KEY
RUN echo "deb https://ookla.bintray.com/debian ${DEB_DISTRO} main" | sudo tee  /etc/apt/sources.list.d/speedtest.list
RUN apt-get update
RUN apt-get install speedtest
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt 
EXPOSE 8080 
ENTRYPOINT [ "python" ] 
CMD [ "app.py" ] 
