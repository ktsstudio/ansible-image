FROM alpine:3.16.2
#FROM lexauw/ansible-alpine # версия alpine устарела обновления конетйнера в докер хабе не было 3 года на момент редактирования
# ####################################################################################################################
ENV ANSIBLE_VERSION=10.4.0

RUN set -xe \
    && apk add --no-cache --progress python3 openssl bash libintl gettext \
       ca-certificates git openssh sshpass py3-pip \
    && apk --update add --virtual build-dependencies \
       python3-dev libffi-dev openssl-dev build-base \
    && pip3 install --upgrade pip \
    && pip3 install ansible==${ANSIBLE_VERSION} boto3 \
    && apk del build-dependencies \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /etc/ansible \
    && echo -e "[local]\nlocalhost ansible_connection=local" > \
      /etc/ansible/hosts \
    && cp /usr/bin/envsubst /usr/local/bin/envsubst

# ####################################################################################################################


RUN pip3 install requests python-gitlab python-dotenv


WORKDIR /ansible