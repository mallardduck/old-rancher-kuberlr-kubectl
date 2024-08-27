KUBECTL27_VERSION := v1.27.16
KUBECTL27_SUM_arm64 ?= $(shell curl -L "https://dl.k8s.io/release/$(KUBECTL27_VERSION)/bin/linux/arm64/kubectl.sha256")
KUBECTL27_SUM_amd64 ?= $(shell curl -L "https://dl.k8s.io/release/$(KUBECTL27_VERSION)/bin/linux/amd64/kubectl.sha256")
KUBECTL27_SUM_s390x ?= $(shell curl -L "https://dl.k8s.io/release/$(KUBECTL27_VERSION)/bin/linux/s390x/kubectl.sha256")

KUBECTL28_VERSION := v1.28.13
KUBECTL28_SUM_arm64 ?= $(shell curl -L "https://dl.k8s.io/release/$(KUBECTL28_VERSION)/bin/linux/arm64/kubectl.sha256")
KUBECTL28_SUM_amd64 ?= $(shell curl -L "https://dl.k8s.io/release/$(KUBECTL28_VERSION)/bin/linux/amd64/kubectl.sha256")
KUBECTL28_SUM_s390x ?= $(shell curl -L "https://dl.k8s.io/release/$(KUBECTL28_VERSION)/bin/linux/s390x/kubectl.sha256")

KUBECTL29_VERSION := v1.29.8
KUBECTL29_SUM_arm64 ?= $(shell curl -L "https://dl.k8s.io/release/$(KUBECTL29_VERSION)/bin/linux/arm64/kubectl.sha256")
KUBECTL29_SUM_amd64 ?= $(shell curl -L "https://dl.k8s.io/release/$(KUBECTL29_VERSION)/bin/linux/amd64/kubectl.sha256")
KUBECTL29_SUM_s390x ?= $(shell curl -L "https://dl.k8s.io/release/$(KUBECTL29_VERSION)/bin/linux/s390x/kubectl.sha256")

KUBECTL30_VERSION := v1.30.4
KUBECTL30_SUM_arm64 ?= $(shell curl -L "https://dl.k8s.io/release/$(KUBECTL30_VERSION)/bin/linux/arm64/kubectl.sha256")
KUBECTL30_SUM_amd64 ?= $(shell curl -L "https://dl.k8s.io/release/$(KUBECTL30_VERSION)/bin/linux/amd64/kubectl.sha256")
KUBECTL30_SUM_s390x ?= $(shell curl -L "https://dl.k8s.io/release/$(KUBECTL30_VERSION)/bin/linux/s390x/kubectl.sha256")

KUBECTL27 := "$(KUBECTL27_VERSION):$(KUBECTL27_SUM_arm64):$(KUBECTL27_SUM_amd64):$(KUBECTL27_SUM_s390x)"
KUBECTL28 := "$(KUBECTL28_VERSION):$(KUBECTL28_SUM_arm64):$(KUBECTL28_SUM_amd64):$(KUBECTL28_SUM_s390x)"
KUBECTL29 := "$(KUBECTL29_VERSION):$(KUBECTL29_SUM_arm64):$(KUBECTL29_SUM_amd64):$(KUBECTL29_SUM_s390x)"
KUBECTL30 := "$(KUBECTL30_VERSION):$(KUBECTL30_SUM_arm64):$(KUBECTL30_SUM_amd64):$(KUBECTL30_SUM_s390x)"

KUBECTL_VERSION_INFO := "$(KUBECTL27) $(KUBECTL28) $(KUBECTL29) $(KUBECTL30)"

# Reduces the code duplication on Makefile by keeping all args into a single variable.
IMAGE_ARGS := --build-arg KUBECTL_VERSION_INFO=$(KUBECTL_VERSION_INFO)