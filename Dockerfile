FROM nixos/nix:latest AS builder

COPY . /tmp/nixos-homepage
WORKDIR /tmp/nixos-homepage

RUN nix \
    --extra-experimental-features "nix-command flakes" \
    --option filter-syscalls false \
    build

FROM nginx
COPY --from=builder /tmp/nixos-homepage/result/ /usr/share/nginx/html
EXPOSE 80
