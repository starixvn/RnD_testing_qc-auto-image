FROM hub.lumigame.com/base/playwright:v1.24.0-focal

ARG user=test
ARG home=/home/$user
WORKDIR $home
		   
# Install node_modules
RUN apt-get update
COPY package.json ./ 
RUN npm install
COPY . /
RUN npm init playwright@latest
RUN npx browserslist@latest --update-db
