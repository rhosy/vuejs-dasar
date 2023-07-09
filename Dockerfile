FROM node:lts-alpine as builder
WORKDIR /app

COPY package*.json .

RUN npm install

COPY . /app

RUN npm run build

# Production container
FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx/nginx.conf /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]