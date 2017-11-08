FROM node:9.1.0

LABEL name="margaret_web"
LABEL version="1.0.0"
LABEL maintainer="strattadb@gmail.com"

USER node

# Create and change current directory.
WORKDIR /usr/src/app

# Install dependencies.
COPY package.json yarn.lock ./
RUN yarn

# Bundle app source.
COPY . .

EXPOSE 8090
CMD ["yarn", "start"]