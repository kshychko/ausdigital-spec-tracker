FROM node

RUN \
  apt-get update && \
  apt-get install -y ruby

# basics
RUN apt-get install -y openssl

# install RVM, Ruby, and Bundler
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.0"
RUN /bin/bash -l -c "gem install jekyll"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN mkdir -p /root/.ssh

ADD id_rsa /root/.ssh/id_rsa

RUN chmod 700 /root/.ssh/id_rsa

RUN mkdir /src

RUN npm install forever -g --silent

WORKDIR /src
ADD . /src/
RUN npm install --silent

EXPOSE 3000

CMD forever --minUptime 100 bin/www  -o out.log -e err.log
