FROM node:12

RUN mkdir -p /opt/node-server
COPY . /opt/node-server
WORKDIR /opt/node-server

RUN npm install

ENTRYPOINT ["npm", "start"]
