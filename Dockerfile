FROM swift:5.1

WORKDIR /package

COPY . ./

RUN apt-get update
RUN apt-get install -y libssl-dev libicu-dev
RUN swift package resolve
RUN swift package clean

CMD ["swift", "test"]
