FROM node

RUN mkdir -p /root/.ssh
ADD ~/.ssh/id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

RUN mkdir /src

RUN npm install forever -g --silent

WORKDIR /src
ADD . /src/
RUN npm install --silent

EXPOSE 3000

CMD forever --minUptime 100 bin/www  -o out.log -e err.log
