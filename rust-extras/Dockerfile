# escape=`

ARG rust_version=stable
FROM embarkstudios/rust:ltsc2019-2017-${rust_version}

COPY install-sccache.ps1 temp/install-sccache.ps1
COPY install-cargo-make.ps1 temp/install-cargo-make.ps1

# Install sccache, using our fork for now as it has not had a new release with
# some changes we require, particularly regarding GCS support, once a release
# is made we can install it via scoop instead
RUN ./temp/install-sccache.ps1 -version "0.2.21" -repo "Jake-Shadle/sccache"

# Install cargo-make from its GH release rather than cargo install
RUN ./temp/install-cargo-make.ps1 -version "0.21.0"

# Install openssl headers and libs and set OPENSSL_DIR so it is
# picked up by openssl-sys
RUN scoop install openssl
ENV OPENSSL_DIR="c:/users/containeradministrator/scoop/apps/openssl/current"

# Install more dependencies
# * `cmake` because C/C++ code :(
RUN scoop install cmake

# Cleanup all our temporary files
RUN Remove-Item -Recurse -Force ./temp
