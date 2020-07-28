FROM python:alpine3.7 

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
