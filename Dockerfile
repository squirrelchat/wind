FROM rust:1.50-alpine AS build
RUN apk add build-base

WORKDIR /opt/wind
COPY . /opt/wind

RUN cargo build --release
RUN strip ./target/release/wind

FROM alpine:latest

WORKDIR /usr/src/wind
COPY --from=build /opt/wind/target/release/wind /usr/src/wind/wind

CMD [ "wind" ]

EXPOSE 3030
