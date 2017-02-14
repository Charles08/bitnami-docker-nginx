FROM gcr.io/stacksmith-images/minideb:jessie-r9
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_IMAGE_VERSION=1.10.3-r0 \
    BITNAMI_APP_NAME=nginx

# System packages required
RUN install_packages libc6 libpcre3 libssl1.0.0 zlib1g

# Install nginx
RUN bitnami-pkg unpack nginx-1.10.3-0 --checksum f55a7ac4e3ce28c59596e2bdc21531b8cc7c5991cc84768be804534017db7c9f
RUN ln -sf /opt/bitnami/nginx/html /app

ENV PATH=/opt/bitnami/nginx/sbin:/opt/bitnami/nginx/bin:/opt/bitnami/common/bin:$PATH

COPY rootfs/ /

ENV NGINX_HTTP_PORT=80 \
    NGINX_HTTPS_PORT=443

VOLUME ["/bitnami/nginx"]

WORKDIR /app

EXPOSE 80 443

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["nami", "start", "--foreground", "nginx"]
