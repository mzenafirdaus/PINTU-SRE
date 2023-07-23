FROM node:16-alpine

ENV TZ UTC
WORKDIR /app

RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone

RUN apk update && \
    apk -f upgrade &&\
    apk add tini \
        curl \
        openssl \
        ca-certificates \
        bzip2

COPY --chown=node:node . .

USER node
EXPOSE 3001

ENTRYPOINT ["/sbin/tini", "--"]
CMD [ "node", "dist/index.js" ]
