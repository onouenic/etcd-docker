# --- ESTÁGIO 1: Builder ---
FROM alpine:latest AS builder

COPY initial-config.sh /tmp/
RUN chmod +x /tmp/initial-config.sh

# --- ESTÁGIO 2: Imagem Final ---
# FROM docker.io/bitnamilegacy/etcd:3.6
FROM public.ecr.aws/bitnami/etcd:3.6.8

COPY --from=builder /tmp/initial-config.sh /opt/bitnami/scripts/initial-config.sh
