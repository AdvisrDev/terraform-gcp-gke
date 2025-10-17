FROM golang:alpine

USER root
ENV GO111MODULE=on

ARG GOLANGCI_LINT_VERSION=v1.35.2
ARG GOPLS_VERSION=v0.6.4
ARG DELVE_VERSION=v1.5.0
ARG GOMODIFYTAGS_VERSION=v1.13.0
ARG GOPLAY_VERSION=v1.0.0
ARG GOTESTS_VERSION=v1.5.3
ARG STATICCHECK_VERSION=2020.2.1

# Instalar bash y utilidades básicas
RUN apk upgrade --no-cache && \
  apk add --no-cache --progress \
  git build-base findutils make bat exa coreutils wget curl bash \
  binutils jq sudo g++ py3-pip yq nodejs npm shadow

# Crear usuario no-root con bash como shell y permitir sudo sin contraseña
RUN useradd -m -s /bin/bash devuser && \
  echo "devuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Instalar golangci-lint
RUN wget -qO- https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /usr/local/bin -d ${GOLANGCI_LINT_VERSION}

# Instalar utilidades Go
RUN go install golang.org/x/tools/gopls@${GOPLS_VERSION} && \
  go install github.com/ramya-rao-a/go-outline@latest && \
  go install golang.org/x/tools/cmd/guru@latest && \
  go install golang.org/x/tools/cmd/gorename@latest && \
  go install github.com/go-delve/delve/cmd/dlv@${DELVE_VERSION} && \
  go install github.com/fatih/gomodifytags@${GOMODIFYTAGS_VERSION} && \
  go install github.com/haya14busa/goplay/cmd/goplay@${GOPLAY_VERSION} && \
  go install github.com/cweill/gotests/...@${GOTESTS_VERSION} && \
  go install github.com/davidrjenni/reftools/cmd/fillstruct@latest && \
  go install mvdan.cc/gofumpt@latest && \
  go install github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest && \
  go install github.com/cuonglm/gocmt@latest && \
  go install github.com/go-task/task/v3/cmd/task@latest && \
  go install github.com/terraform-linters/tflint@latest && \
  go install github.com/zricethezav/gitleaks/v8@latest && \
  go install github.com/terraform-docs/terraform-docs@v0.20.0 && \
  rm -rf $GOPATH/pkg/* $GOPATH/src/* /root/.cache/go-build

RUN go env -w GOPRIVATE=github.com/crizstian

# Instalar tfenv y configurar para devuser
RUN git clone --depth=1 https://github.com/tfutils/tfenv.git /home/devuser/.tfenv && \
  chown -R devuser:devuser /home/devuser/.tfenv && \
  echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> /home/devuser/.profile && \
  ln -s /home/devuser/.tfenv/bin/* /usr/local/bin && \
  tfenv install latest && \
  tfenv use latest

# Instalar kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl && \
  chmod +x kubectl && \
  mv kubectl /usr/local/bin/kubectl && \
  kubectl version --client

# Instalar Google Cloud SDK
RUN curl -sSL https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz -o /tmp/google-cloud-sdk.tar.gz && \
  mkdir -p /usr/local/gcloud && \
  tar -C /usr/local/gcloud -xzf /tmp/google-cloud-sdk.tar.gz && \
  /usr/local/gcloud/google-cloud-sdk/install.sh --quiet && \
  rm /tmp/google-cloud-sdk.tar.gz

ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

RUN gcloud components install gke-gcloud-auth-plugin --quiet

# Instalar paquetes npm globales (ejecuta como root)
RUN npm install -g @anthropic-ai/claude-code

# Crear workspace y permisos
RUN mkdir -p /workspace && chown -R devuser:devuser /workspace

USER devuser
WORKDIR /workspace

# El usuario 'devuser' tendrá bash por defecto y sudo sin pedir contraseña
CMD [ "bash" ]
