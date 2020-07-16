FROM embarkstudios/vs-build-tools:ltsc2019-2017

USER boop

# Download rustup
ADD https://win.rustup.rs  c:/temp/rustup-init.exe

ARG rust_version=stable
ENV triple x86_64-pc-windows-msvc

# Install rust with the MSVC toolchain
RUN c:/temp/rustup-init.exe -y --default-toolchain "$env:rust_version-$env:triple" --profile=minimal
RUN Remove-Item -Recurse -Force c:/temp

ENV CARGO_HOME c:/Users/boop/.cargo

RUN rustc --version
