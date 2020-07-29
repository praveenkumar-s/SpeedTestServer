FROM python:alpine3.7


 RUN apk update
 RUN apk add speedtest-cli
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt 
EXPOSE 8080 
ENTRYPOINT [ "python" ] 
CMD [ "app.py" ] 
