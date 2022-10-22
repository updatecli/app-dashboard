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

# Dynamic labels are defined from the goreleaser configuration ".goreleaser.yaml"
LABEL org.opencontainers.image.authors="Olivier Vernin<me@olblak.com>, Damien DUPORTAL <damien.duportal@gmail.com>"
LABEL org.opencontainers.image.title="Updatecli"
LABEL org.opencontainers.image.description="The Updatefactory frontend"

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
