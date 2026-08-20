# Galaga container image
# the game is 100% static files (html, css, js + images), so all that we need is a tiny web server
# to hand those files to the browser. nginx will be our solution.

# we pin a specific, small 'alpine' base image for reproducible, lean builds. 

FROM nginx:1.27-alpine

# remove the default nginx welcome page so nothing stale is served.
RUN rm -rf /usr/share/nginx/html/*

# copy our web server config into place
COPY nginx.conf /etc/nginx/conf.d/default.conf

# copy the game files into nginx's web root
COPY game/ /usr/share/nginx/html/

# nginx inside this container listens on port 80.
# you still choose the HOST port with -p when you run it (e.g. 8080:80)
EXPOSE 80

# run nginx in the foreground so the container stays alive and Docker/K8s
# can manage its lifecycle correctly
CMD ["nginx", "-g", "daemon off;"]