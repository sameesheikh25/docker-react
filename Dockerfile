FROM node:20-alpine AS builder

WORKDIR /app

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

FROM nginx

#This port is not be used by local machine, if we deploy to EBS, it'll look for this
# command when the container starts. The EBS will map directly automatically to this port
EXPOSE 80 

COPY --from=builder /app/build /usr/share/nginx/html
