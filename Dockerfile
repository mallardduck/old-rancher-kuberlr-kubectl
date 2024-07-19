FROM registry.suse.com/bci/bci-base:15.6 AS build

ARG TARGETPLATFORM
ARG KUBERLR_RELEASE

RUN mkdir /work-tmp
WORKDIR /work-tmp
RUN set -x \
 && export ARCHIVE_NAME="kuberlr_${KUBERLR_RELEASE:1}_linux_amd64" \
 && curl -fsSLO https://github.com/flavio/kuberlr/releases/download/${KUBERLR_RELEASE}/${ARCHIVE_NAME}.tar.gz \
 && tar -xvzf ${ARCHIVE_NAME}.tar.gz \
 && mkdir /work-tmp/bin \
 && chmod +x ${ARCHIVE_NAME}/kuberlr \
 && mv ${ARCHIVE_NAME}/kuberlr /work-tmp/bin/kuberlr
RUN useradd -u 1000 -U -m kuberlr
RUN cd /work-tmp/bin && ln -s ./kuberlr ./kubectl

RUN echo 'kuberlr:x:1000:1000:kuberlr,,,:/home/kuberlr:/bin/bash' > /etc/passwd && \
    echo 'kuberlr:x:1000:' > /etc/group && \
    mkdir /home/kuberlr/.bin && \
    mkdir /home/kuberlr/.kube && \
    mkdir /home/kuberlr/.kuberlr && \
    touch /home/kuberlr/.kuberlr/kuberlr.conf && \
    echo "AllowDownload = false" >> /home/kuberlr/.kuberlr/kuberlr.conf && \
    echo 'SystemPath = "/home/kuberlr/.bin"' >> /home/kuberlr/.kuberlr/kuberlr.conf && \
    echo "Timeout = 6" >> /home/kuberlr/.kuberlr/kuberlr.conf && \
    chown -R 1000:1000 /home/kuberlr && \
    chmod 700 /run

FROM scratch
COPY --chown=root --from=build /work-tmp/bin /bin
COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /etc/group /etc/group
COPY --from=build /var/lib/ca-certificates /var/lib/ca-certificates
COPY --from=build /etc/ssl /etc/ssl
COPY --from=build --chmod=1777 /tmp /tmp
COPY --from=build /home /home
USER kuberlr
ENTRYPOINT ["/bin/kuberlr"]
CMD ["help"]