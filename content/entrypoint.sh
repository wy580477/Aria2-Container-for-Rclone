#!/bin/sh

# Dummy run for building image
if [ "${MODE}" = "build" ]; then
       sleep infinity
fi

if [ "${PUID}" != "0" ]; then
       mkdir -p /mnt/data/downloads /mnt/data/finished 2>/dev/null
       chown -R ${PUID}:${PGID} /workdir /mnt/config 2>/dev/null
       chown ${PUID}:${PGID} /mnt/data /mnt/data/downloads /mnt/data/finished
fi

# Configure aria2
if [ ! -d "/mnt/config/aria2" ]; then
       mkdir -p /mnt/config/aria2
       cp /workdir/aria2/*.conf /mnt/config/aria2/
       cp /workdir/aria2/*.dat /mnt/config/aria2/
       cp /workdir/aria2/tracker.sh /mnt/config/aria2/
fi

if [ ! -f "/mnt/config/aria2/aria2.session" ]; then
       touch /mnt/config/aria2/aria2.session
fi

cp /mnt/config/aria2/aria2.conf /workdir/aria2.conf
sed -i "s|^rpc-secret=.*|rpc-secret=${PASSWORD}|g" /workdir/aria2.conf

if [ "${AUTO_DRIVE_NAME}" = "true" ]; then
       DRIVE_NAME_AUTO="$(sed -n '1p' /mnt/config/rclone.conf | sed "s/\[//g" | sed "s/\]//g")"
       sed -i "s|^drive-name=.*|drive-name=${DRIVE_NAME_AUTO}|g" /mnt/config/aria2/script.conf
fi

if [ "${POST_MODE}" = "copy_remote_first" ]; then
       sed -i "s|^on-bt-download-complete=/workdir/aria2/.*.sh|on-bt-download-complete=/workdir/aria2/"${POST_MODE}".sh|g" /workdir/aria2.conf
       sed -i "s|^on-download-complete=/workdir/aria2/.*.sh|on-download-complete=/workdir/aria2/copy_remote_other.sh|g" /workdir/aria2.conf
elif [ "${POST_MODE}" = "dummy" ]; then
       sed -i "s|^on-bt-download-complete=/workdir/aria2/.*.sh|on-bt-download-complete=/workdir/aria2/clean.sh|g" /workdir/aria2.conf
       sed -i "s|^on-download-complete=/workdir/aria2/.*.sh|on-download-complete=/workdir/aria2/clean.sh|g" /workdir/aria2.conf
elif [ "${POST_MODE}" = "custom" ]; then
       :
else
       sed -i "s|^on-download-complete=/workdir/aria2/.*.sh|on-download-complete=/workdir/aria2/"${POST_MODE}".sh|g" /workdir/aria2.conf
       sed -i "s|^on-bt-download-complete=/workdir/aria2/.*.sh|on-bt-download-complete=/workdir/aria2/clean.sh|g" /workdir/aria2.conf
fi

# Run aria2
exec su-exec ${PUID}:${PGID} aria2c --conf-path="/workdir/aria2.conf" \
--enable-rpc \
--rpc-listen-port=${RPC_PORT} $@
