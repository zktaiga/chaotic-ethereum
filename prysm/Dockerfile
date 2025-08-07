ARG CHAOTIC_BASE=chaotic-base:latest
FROM ${CHAOTIC_BASE} as toda

# Install dependencies in Alpine then copy to final image
FROM alpine:latest as deps
RUN apk add --no-cache gcompat libgcc fuse

FROM gcr.io/prysmaticlabs/prysm/beacon-chain:v6.0.4
COPY --from=deps /usr/lib/libgcc_s.so.1 /usr/lib/
COPY --from=deps /usr/lib/libfuse.so.2 /usr/lib/
COPY --from=deps /lib/ld-musl-x86_64.so.1 /lib/
COPY --from=toda /usr/local/bin/toda /usr/local/bin/toda