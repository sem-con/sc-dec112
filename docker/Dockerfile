FROM semcon/sc-base
MAINTAINER "Christoph Fabianek" christoph@ownyourdata.eu

# RUN gem install specific_install faye-websocket && \
# 	gem specific_install https://github.com/tansengming/eliza-rb.git

RUN gem install faye-websocket
	
COPY . .
RUN bundle install

CMD ["./script/run.sh"]

EXPOSE 3000 3000