FROM node:alpine

WORKDIR /app

COPY package*.json ./

RUN npm ci

Run npm install -g @angular/cli

COPY . .

RUN npm run build --configuration=production

FROM nginx:latest

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /ap/dist/karim-portfolio/browser /usr/share/nginx/html

EXPOSE 80