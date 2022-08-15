FROM hub.lumigame.com/base/playwright:v1.24.0-focal

ARG user=test
ARG home=/home/$user
WORKDIR $home
		   
# Install node_modules
RUN apt-get update
COPY package*json $home/ 
COPY ./ $home/
RUN npm install
RUN npm init playwright@latest
RUN npx browserslist@latest --update-db
