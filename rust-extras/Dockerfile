# escape=`

ARG rust_version=stable
FROM embarkstudios/rust:ltsc2019-2017-${rust_version}

# Install sccache, using our fork for now as it has not had a new release with
# some changes we require, particularly regarding GCS support, once a release
# is made we can install it via scoop instead
RUN cargo install sccache --no-default-features --features=gcs

COPY install-cargo-fetcher.ps1 temp/install-cargo-fetcher.ps1
RUN ./temp/install-cargo-fetcher.ps1 -version "0.7.0"

# Install more dependencies
# * `cmake` because C/C++ code :(
RUN scoop install cmake

# Cleanup all our temporary files
RUN Remove-Item -Recurse -Force ./temp
# Cleanup cargo directories
RUN Remove-Item -Recurse -Force ${CARGO_HOME}\\git
RUN Remove-Item -Recurse -Force ${CARGO_HOME}\\registry