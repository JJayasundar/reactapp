# Stage 1

FROM tiangolo/node-frontend:10 AS build-semi

WORKDIR /pkg

COPY package*.json /pkg/

RUN npm install

COPY ./ /pkg/

RUN npm run build

# Stage 2

FROM nginx:1.15

COPY --from=build-semi /pkg/build/ /usr/share/nginx/html

COPY --from=build-semi /nginx.conf /etc/nginx/conf.d/default.conf
