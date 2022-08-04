FROM hub.lumigame.com/base/playwright:v1.24.0-focal

ARG user=test
ARG home=/home/$user
WORKDIR $home
		   
# Install node_modules
RUN apt-get update
RUN apt-get install build-essential -y
COPY package.json $home/package.json
RUN npm i cross-var --location=global
RUN npm install
RUN npx browserslist@latest --update-db
