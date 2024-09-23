# https://www.docker.com/blog/getting-started-with-docker-using-node-jspart-i/

# what base image we would like to use for our application
FROM node:22 AS base

# use this path as the default location for all subsequent commands
WORKDIR /app

# create user and group
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --gid 1001 --uid 1001 nextjs

# Before we can run npm install, we need to get our package.json and package-lock.json files into our images. 
# We’ll use the COPY command to do this. The COPY command takes two parameters. The first parameter tells 
# Docker what file(s) you would like to copy into the image. The second parameter tells Docker where you want 
# that file(s) to be copied to. We’ll copy the package.json and package-lock.json file into our working 
# directory – /app.
RUN mkdir -p /app/mysite
RUN chown nextjs:nodejs /app/mysite

FROM base AS builder
WORKDIR /app/mysite

COPY --chown=nextjs:nodejs nextjs-microsite/app app

COPY --chown=nextjs:nodejs nextjs-microsite/next-env.d.ts next-env.d.ts
COPY --chown=nextjs:nodejs nextjs-microsite/next.config.js next.config.js
COPY --chown=nextjs:nodejs nextjs-microsite/package-lock.json package-lock.json
COPY --chown=nextjs:nodejs nextjs-microsite/package.json package.json
COPY --chown=nextjs:nodejs nextjs-microsite/tsconfig.json tsconfig.json

# Once we have our package.json files inside the image, we can use the RUN command to execute the command npm install. 
# This works exactly the same as if we were running npm install locally on our machine but this time these node 
# modules will be installed into the node_modules directory inside our image.

RUN npm install
RUN npm i wrangler -g

# wrangler shows permission error if it run as other users
#RUN chown -R nextjs:nodejs node_modules
#USER nextjs
