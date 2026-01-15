ARG CHAOTIC_BASE=chaotic-base:latest
FROM ${CHAOTIC_BASE} as toda
FROM ethereum/client-go:v1.16.8
# Install minimal dependencies for Toda binary
RUN (apt-get update && apt-get install -y libfuse2 && apt-get clean) || (apk add --no-cache gcompat libgcc fuse) || true
COPY --from=toda /usr/local/bin/toda /usr/local/bin/toda