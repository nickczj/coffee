FROM node:18-alpine

WORKDIR /app

RUN apk update && apk upgrade
RUN apk add git
RUN npm install -g pnpm

COPY ["package.json", "pnpm-lock.yaml", "./"]

RUN pnpm install

COPY . .

ENV PATH ./node_modules/.bin/:$PATH