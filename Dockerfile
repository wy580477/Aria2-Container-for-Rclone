FROM alpine:latest

COPY ./content /.aria2allinoneworkdir/

ARG MODE=build

ENV PASSWORD=password
ENV PUID=0
ENV PGID=0
ENV TZ=UTC
ENV RPC_PORT=6800
ENV ARIA_IPV6=false
ENV BT_PORT=51413
ENV LANGUAGE=en
ENV POST_MODE=move
ENV AUTO_DRIVE_NAME=true
ENV CLEAN_UNFINISHED_FAILED_TASK_FILES=true
ENV TZ=UTC
ENV RCLONE_ADDR=http://localhost:56802

RUN apk add --no-cache curl jq aria2 bash findutils su-exec tzdata \
    && chmod +x /.aria2allinoneworkdir/aria2/*.sh /.aria2allinoneworkdir/*.sh

VOLUME /mnt/data /mnt/config

LABEL org.opencontainers.image.authors="wy580477@outlook.com"
LABEL org.label-schema.name="Aria2-AIO-Container"
LABEL org.label-schema.description="Aria2 container with Rclone auto-upload function & more"
LABEL org.label-schema.vcs-url="https://github.com/wy580477/Aria2-AIO-Container/"

ENTRYPOINT ["sh","-c","/.aria2allinoneworkdir/entrypoint.sh"]
