FROM embarkstudios/vs-build-tools:ltsc2019-2017

# Download rustup
ADD https://win.rustup.rs c:/temp/rustup-init.exe

ARG rust_version=stable
ENV triple x86_64-pc-windows-msvc

# Install rust with the MSVC toolchain
RUN c:/temp/rustup-init.exe -y --default-toolchain %rust_version%-%triple%

ENV CARGO_HOME "%USERPROFILE%\\.cargo\\bin"

RUN powershell -command "Remove-Item -Recurse -Force c:/temp"
