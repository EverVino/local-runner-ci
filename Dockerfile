FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
# github actions runner version
ENV RUNNER_VERSION="2.335.1"

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    jq \
    libicu74 \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m runner

USER runner
WORKDIR /home/docker

# Download the github action runner files
RUN mkdir actions-runner && cd actions-runner && \
    curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L \
    https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

USER root

# Run the GitHub dependency script safely as root
RUN /home/docker/actions-runner/bin/installdependencies.sh

COPY start.sh /home/docker/actions-runner/start.sh
RUN chmod +x /home/docker/actions-runner/start.sh

USER runner
WORKDIR /home/docker/actions-runner

ENTRYPOINT ["./start.sh"]