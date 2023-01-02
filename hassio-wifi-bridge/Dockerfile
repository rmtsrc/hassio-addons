ARG BUILD_FROM
FROM $BUILD_FROM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV LANG C.UTF-8

RUN apk add --update --no-cache bash jq iw hostapd networkmanager networkmanager-cli net-tools sudo openssh-client

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
