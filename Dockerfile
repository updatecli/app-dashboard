# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM nginx:stable-alpine
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY docker/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

# Dynamic labels are defined from the goreleaser configuration ".goreleaser.yaml"
LABEL org.opencontainers.image.authors="Olivier Vernin<me@olblak.com>"
LABEL org.opencontainers.image.title="Updatemonitor-ui"
LABEL org.opencontainers.image.description="The Updatemonitor UI"
LABEL org.opencontainers.image.source https://github.com/updatecli/app-dashboard


EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
