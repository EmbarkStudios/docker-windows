# escape=`
ARG org=embarkstudios
FROM ${org}/rust:1909-2017-${rust_version}

RUN cargo install --git https://github.com/mozilla/sccache --rev f50207525810c12f9dbad2b9e92892d055b1b38a --features gcs --no-default-features

COPY install-cargo-fetcher.ps1 temp/install-cargo-fetcher.ps1
RUN ./temp/install-cargo-fetcher.ps1 -version "0.8.0"

# Install clippy and wasm target so they can be run on windows too
RUN rustup target add wasm32-unknown-unknown
RUN rustup component add clippy

# Install more dependencies
# `cmake` because C/C++ code :(
# `ninja` is needed to avoid long paths when building eg. shaderc
# `python` because shaderc and cranelift
# `llvm` because we use LLD for faster linking
# `gow` bash and other utils
# `innosetup` for building the installer
# `gcloud` for downloading/uploading the signed/unsigned installer
RUN scoop bucket add extras
RUN scoop install cmake python ninja llvm busybox inno-setup gcloud curl

# Cleanup all our temporary files
RUN Remove-Item -Recurse -Force ./temp
# Cleanup cargo directories
RUN if (Test-Path -Path "$env:CARGO_HOME/git") { Remove-Item "$env:CARGO_HOME/git" -Recurse -Force }
RUN if (Test-Path -Path "$env:CARGO_HOME/registry") { Remove-Item "$env:CARGO_HOME/registry" -Recurse -Force }
