FROM node:8.7.0-alpine AS build

WORKDIR /usr/src

# Bundle app source
COPY . .

RUN apk --update add --no-cache --virtual \
      .build-deps bash make g++ python && \
    npm install --production

RUN npm i 
RUN cd client && npm install && cd ..
# npm install -g react-scripts@3.0.1 typescript
RUN bash ./scripts/authelia-scripts-build

#COPY dist/server /usr/src/server
RUN apk del .build-deps

FROM node:8.7.0-alpine
EXPOSE 9091
VOLUME /etc/authelia
VOLUME /var/lib/authelia
WORKDIR /usr/src
COPY --from=build /usr/src/node_modules node_modules
COPY --from=build /usr/src/dist/server server

CMD ["node", "server/src/index.js", "/etc/authelia/config.yml"]
