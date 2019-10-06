FROM swift:4.1

WORKDIR /package

COPY . ./

#RUN apt-get update
#RUN apt-get install -y libssl-dev
RUN swift package resolve
RUN swift package clean

CMD ["swift", "test"]
