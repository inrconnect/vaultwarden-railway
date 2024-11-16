FROM vaultwarden/server:latest

ARG PORT
ENV ROCKET_PORT ${PORT}

EXPOSE ${PORT}

# Support for generating Argon2 PCH string ADMIN_TOKEN dynamically at startup
CMD bash -c '
    if [ -n "$VAULTWARDEN_ADMIN_PASSWORD" ]; then
        echo "[INFO] Generating ADMIN_TOKEN from VAULTWARDEN_ADMIN_PASSWORD..."
        export ADMIN_TOKEN=$(echo "$VAULTWARDEN_ADMIN_PASSWORD" | /vaultwarden hash)
    fi
    if [ -z "$DATABASE_URL" ]; then
        echo "[ERROR] DATABASE_URL is not set. Exiting..."
        exit 1
    fi
    echo "[INFO] Starting Vaultwarden..."
    ./start.sh
'
