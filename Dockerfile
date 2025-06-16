# --- ESTÁGIO 1: Builder ---
FROM alpine:latest AS builder

COPY initial-config.sh /tmp/
RUN chmod +x /tmp/initial-config.sh

# --- ESTÁGIO 2: Imagem Final ---
FROM docker.io/bitnami/etcd:3.5

COPY --from=builder /tmp/initial-config.sh /opt/bitnami/scripts/initial-config.sh
