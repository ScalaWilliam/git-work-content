FROM fedora:24

WORKDIR /opt/gw
RUN dnf -y update && dnf clean all
RUN dnf -y install make sudo wget procps-ng gcc gcc-c++ tar
ADD ./Makefile ./

RUN wget --quiet https://github.com/emcrisostomo/fswatch/releases/download/1.9.3/fswatch-1.9.3.tar.gz && \
  tar zxf fswatch-1.9.3.tar.gz && cd fswatch-1.9.3 && ./configure && make && make install && cd ..

RUN yum -y install saxon parallel npm nodejs
RUN npm install -g browser-sync

RUN make fedora-setup

RUN echo "#!/bin/bash" >> /opt/run.sh
RUN echo "cd /opt/gw" >> /opt/run.sh
RUN echo "make browser-sync-no-open &" >> /opt/run.sh
RUN echo "make watch" >> /opt/run.sh
RUN chmod +x /opt/run.sh

EXPOSE 3000
EXPOSE 3001

CMD ["/usr/bin/bash", "/opt/run.sh"]
