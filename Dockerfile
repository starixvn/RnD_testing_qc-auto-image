FROM ubuntu:18.04

ARG user=test
ARG home=/home/$user
WORKDIR $home


# Install Node.js, Yarn and required dependencies
RUN apt-get update \
  && apt-get install -y curl gnupg build-essential \
  && curl --silent --location https://deb.nodesource.com/setup_14.x | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get remove -y --purge cmdtest \
  && apt-get update \
  && apt-get install -y nodejs yarn \
  # remove useless files from the current layer
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/lib/apt/lists.d/* \
  && apt-get autoremove \
  && apt-get clean \
  && apt-get autoclean

# Install dependencies  
RUN apt-get update \
  && apt-get install -y libglib2.0-0\
           libnss3\
           libnspr4\
           libatk1.0-0\
           libatk-bridge2.0-0\
           libcups2\
           libdbus-1-3\
           libxcb1\
           libdrm2\
           libxkbcommon0\
           libx11-6\
           libxcomposite1\
           libxdamage1\
           libxext6\
           libxfixes3\
           libxrandr2\
           libgbm1\
           libgtk-3-0\
           libpango-1.0-0\
           libcairo2\
           libgdk-pixbuf2.0-0\
           libasound2\
           libatspi2.0-0 \
           libxshmfence1 \
           libgles2 \
           xvfb 
		   
# Install node_modules
COPY package.json $home/package.json
RUN npm install
RUN npx browserslist@latest --update-db
RUN npm audit fix

