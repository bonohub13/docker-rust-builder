
rust-builder() {
    git clone https://github.com/bonohub13/docker-rust-builder /tmp/docker-rust-builder \
        && rm -rf /tmp/docker-rust-builder/.git \
            /tmp/docker-rust-builder/LICENSE \
            /tmp/docker-rust-builder/README.md \
            /tmp/docker-rust-builder/setup.sh \
        && cp -r /tmp/docker-rust-builder/* ./ \
        && rm -rf /tmp/docker-rust-builder

    return $?
}
