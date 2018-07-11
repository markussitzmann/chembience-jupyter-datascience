#!/bin/bash
set -e

if ! id "app" >/dev/null 2>&1; then
    groupadd -g $CHEMBIENCE_GID app && \
        useradd --shell /bin/bash -u $CHEMBIENCE_UID -g $CHEMBIENCE_GID -o -c "" -M app
fi

export PYTHONPATH=/home/app:/share:$PYTHONPATH

if [ ! -d "/home/app/.local/share/jupyter/kernels" ]; then
    mkdir -p /home/app/.local/share/jupyter/kernels
    cp -r /root/.local/share/jupyter/kernels/* /home/app/.local/share/jupyter/kernels
fi

touch /home/app/jupyter.log
chown app.app -R /home/app/

exec "$@"

