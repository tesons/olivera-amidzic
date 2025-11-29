FROM jekyll/jekyll:latest
WORKDIR /site
RUN gem install webrick
COPY . /site
EXPOSE 4000
CMD ["jekyll", "serve", "--watch", "--host", "0.0.0.0"]
