# escape=`
ARG rust_version=stable
FROM embarkstudios/rust:ltsc2019-2017-${rust_version}

USER ${user}

RUN Write-Host "$env:UserName"

RUN cargo install --git https://github.com/mozilla/sccache --rev f50207525810c12f9dbad2b9e92892d055b1b38a --features gcs --no-default-features

COPY install-cargo-fetcher.ps1 temp/install-cargo-fetcher.ps1
RUN ./temp/install-cargo-fetcher.ps1 -version "0.8.0"

# Install more dependencies
# * `cmake` because C/C++ code :(
RUN scoop install cmake

# Cleanup all our temporary files
RUN Remove-Item -Recurse -Force ./temp
# Cleanup cargo directories
RUN if (Test-Path -Path "$env:CARGO_HOME/git") { Remove-Item "$env:CARGO_HOME/git" -Recurse -Force }
RUN if (Test-Path -Path "$env:CARGO_HOME/registry") { Remove-Item "$env:CARGO_HOME/registry" -Recurse -Force }
