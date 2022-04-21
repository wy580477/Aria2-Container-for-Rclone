FROM alpine:latest

COPY ./content /workdir/

ARG MODE=build

ENV USER=admin
ENV PASSWORD=password
ENV PUID=0
ENV PGID=0
ENV POST_MODE=move_remote
ENV AUTO_DRIVE_NAME=true
ENV TZ=UTC
ENV RCLONE_ADDR=http://localhost:56802

RUN apk add --no-cache curl jq aria2 bash findutils su-exec tzdata \
    && chmod +x /workdir/aria2/*.sh /workdir/*.sh

VOLUME /mnt/data /mnt/config

LABEL org.opencontainers.image.authors="wy580477@outlook.com"
LABEL org.label-schema.name="Aria2-AIO-Container"
LABEL org.label-schema.description="Aria2 container with Rclone auto-upload function & more"
LABEL org.label-schema.vcs-url="https://github.com/wy580477/Aria2-AIO-Container/"

ENTRYPOINT ["sh","/workdir/entrypoint.sh"]
