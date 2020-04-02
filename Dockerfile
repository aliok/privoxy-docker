FROM alpine

RUN apk add --no-cache --update privoxy
# enable for exec'ing into the container for debugging
#RUN apk add bash

RUN sed -i -e '/^listen-address/s/127.0.0.1/0.0.0.0/' \
	   -e '/^accept-intercepted-requests/s/0/1/' \
	   -e '/^enforce-blocks/s/0/1/' \
	   -e '/^#debug/s/#//' /etc/privoxy/config

RUN chmod -R 755 /etc/privoxy/
RUN chown -R 1001 /etc/privoxy

USER 1001
EXPOSE 8118

CMD ["privoxy", "--no-daemon", "/etc/privoxy/config"]
