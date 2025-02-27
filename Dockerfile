FROM httpd:latest
WORKDIR /usr/local/apache2/htdocs/
RUN rm -rf ./*
COPY . .
EXPOSE 80
CMD ["httpd", "-D", "FOREGROUND"]
