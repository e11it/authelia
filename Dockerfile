FROM node:8.7.0-alpine

WORKDIR /usr/src

COPY package.json /usr/src/package.json

RUN apk --update add --no-cache --virtual \
      .build-deps bash make g++ python && \
    npm install --production

# Bundle app source
COPY . .

RUN npm i 
RUN cd client && npm install && cd ..
# npm install -g react-scripts@3.0.1 typescript
RUN bash ./scripts/authelia-scripts-build

#COPY dist/server /usr/src/server
RUN apk del .build-deps

EXPOSE 9091

VOLUME /etc/authelia
VOLUME /var/lib/authelia

CMD ["node", "dist/server/src/index.js", "/etc/authelia/config.yml"]
