FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl git bash tini \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash hermes
USER hermes
WORKDIR /home/hermes
ENV PATH=/home/hermes/.local/bin:$PATH
ENV HERMES_HOME=/home/hermes/.hermes

RUN curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash -s -- --skip-browser

ENTRYPOINT ["/usr/bin/tini","--"]
CMD ["bash","-lc","hermes gateway"]
