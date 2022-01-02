### https://github.com/theasp/docker-novnc
FROM theasp/novnc
RUN apt-get --allow-releaseinfo-change update && \
    apt-get install -y dosbox mtools  && \
    rm -rfv /var/lib/apt/lists/*

# Turbo Pascal images and masm 6.15, manually installed
COPY ./tp7/*.img /tmp/
COPY ./masm615 /tmp/masm

RUN mkdir /tmp/tpsetup /dosbox && \
    for i in /tmp/*.img; do echo $i; mcopy -m -i $i :: /tmp/tpsetup; done && \
    mv /tmp/tpsetup /dosbox/ && mv /tmp/masm /dosbox/

ENV RUN_XTERM=no
ENV DISPLAY_WIDTH=1024
ENV DISPLAY_HEIGHT=768

# supervisor configuration for dosbox
COPY ./conf.d/dosbox.conf /app/conf.d/

# dosbox configuration, default taken from first run of container and then
# modified autoexec for our purposes
COPY ./conf.d/dosbox-0.74-2.conf /root/.dosbox/

# mount point for pascal code
VOLUME /app/src
