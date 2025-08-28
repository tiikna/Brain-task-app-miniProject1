FROM public.ecr.aws/docker/library/node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci --production || npm install
COPY . .
RUN npm run build

FROM public.ecr.aws/nginx/nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
