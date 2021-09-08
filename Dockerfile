FROM openeuler-21.03:latest

RUN dnf -y  \
--setopt=install_weak_deps=false \
--setopt=tsflags=nodocs \
install \
git java wget tar \
&& dnf clean all

CMD [ "tail -f /dev/null" ]