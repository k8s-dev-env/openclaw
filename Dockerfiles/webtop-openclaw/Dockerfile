ARG WEBTOP_VERSION
FROM lscr.io/linuxserver/webtop:${WEBTOP_VERSION}

ARG OPENCLAW_VERSION
ENV OPENCLAW_VERSION=${OPENCLAW_VERSION}

### install openclaw ###
RUN curl -fsSL https://openclaw.ai/install.sh | bash -s -- --no-onboard