ARG BCI_VERSION=15.6
FROM --platform=$BUILDPLATFORM registry.suse.com/bci/bci-base:${BCI_VERSION} AS build

ARG TARGETPLATFORM
ARG TARGETARCH

WORKDIR /tmp

# Define build arguments
ARG KUBECTL_VERSION_INFO

SHELL ["/bin/bash", "-c"]
RUN set -fx; versions=($KUBECTL_VERSION_INFO); \
    for i in "${!versions[@]}"; do \
        echo "The index is $i and the value is ${versions[$i]}"; \
        version=$(echo ${versions[$i]} | cut -d: -f1); \
        kubectl_url="https://dl.k8s.io/release/${version}/bin/linux/${TARGETARCH}/kubectl"; \
        kubectl_target="/tmp/kubectl${version:1}"; \
        echo "Downloading kubectl version ${version} from ${kubectl_url}"; \
        echo "Targeting ${kubectl_target}"; \
        curl -fsSL "$kubectl_url" -o "$kubectl_target"; \
        chmod 0755 "$kubectl_target"; \
    done

RUN set -fx; versions=($KUBECTL_VERSION_INFO); \
    for i in "${!versions[@]}"; do \
        version=$(echo ${versions[$i]} | cut -d: -f1); \
        arm64_sum=$(echo ${versions[$i]} | cut -d: -f2); \
        amd64_sum=$(echo ${versions[$i]} | cut -d: -f3); \
        s390x_sum=$(echo ${versions[$i]} | cut -d: -f4); \
        kubectl_target="/tmp/kubectl${version:1}"; \
        KUBE_SUM_NAME="${TARGETARCH}_sum"; \
        KUBE_SUM=${!KUBE_SUM_NAME}; \
        echo "${KUBE_SUM} ${kubectl_target}" | sha256sum -c -; \
    done

FROM ghcr.io/flavio/kuberlr:v0.5.1

COPY --from=build /tmp/kubectl* /usr/bin/

USER kuberlr
WORKDIR /home/kuberlr
ENTRYPOINT ["/bin/kubectl"]
CMD ["help"]