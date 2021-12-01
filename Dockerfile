FROM kalilinux/kali-rolling

COPY packages.txt /tmp/
RUN echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" > /etc/apt/sources.list && \
   apt-get -y update && apt-get -y dist-upgrade && \
   cat /tmp/packages.txt | DEBIAN_FRONTEND=noninteractive xargs apt-get -y install && \
   apt-get -y autoremove && apt-get -y clean && \
   rm -rf /tmp/packages.txt && rm -rf /var/lib/apt/lists/* 

#COPY ./archivos /root
#COPY archivos/.zshrc /root/.zshrc
CMD ["/bin/zsh"]

RUN adduser --home /home/test test
RUN usermod -aG sudo test
RUN chsh -s /bin/zsh test
RUN echo "test:test" | chpasswd

USER test

COPY ./archivos /home/test
COPY archivos/.zshrc /home/test/.zshrc
WORKDIR /home/test
