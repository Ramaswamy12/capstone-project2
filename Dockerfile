FROM node:14 AS build
WORKDIR /app 
RUN npm install
CMD npm start
COPY . .
RUN npm run build
EXPOSE 3000
CMD ["npm", "start"]

FROM nginx:latest
COPY --from=build /app/build /usr/share/nginx/html

