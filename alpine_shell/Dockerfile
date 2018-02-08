FROM alpine_base
RUN apk update \
&& apk add zsh zsh-vcs openssh-client \
&& rm -rf /var/cache/apk/* \
&& adduser -D coredumb
USER coredumb
CMD zsh -i
