ARG CHAOTIC_BASE=chaotic-base:latest
FROM ${CHAOTIC_BASE} as toda
FROM hyperledger/besu:25.12.0
# Install dependencies - works for both Ubuntu and Alpine
RUN (apt-get update && apt-get install -y libfuse2 && apt-get clean) || (apk add --no-cache gcompat libgcc fuse) || true
COPY --from=toda /usr/local/bin/toda /usr/local/bin/toda