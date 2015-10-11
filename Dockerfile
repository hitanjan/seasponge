#
# Node.js w/ Bower & Grunt Dockerfile
#
# https://github.com/digitallyseamless/docker-nodejs-bower-grunt
#

# Pull base image.
FROM ubuntu:14.04

# Setup environment
RUN apt-get update
RUN apt-get install --yes ruby ruby-dev nodejs npm
RUN npm install -g bower grunt-cli 
#RUN npm install -g yo 
#RUN npm install -g generator-angular
RUN gem install sass compass    

# Setup app
RUN mkdir -p /app
COPY . /app
WORKDIR /app

# Install app
RUN npm install
RUN bower install

# Onbuild instructions
ONBUILD RUN npm install
#ONBUILD RUN bower install
ONBUILD RUN [[ -f "Gruntfile.js" ]] && grunt build || /bin/true
ONBUILD ENV NODE_ENV production

# Define default command.
#CMD ["npm", "start"]
CMD ["bash"]

EXPOSE 9000
