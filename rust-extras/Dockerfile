FROM embarkstudios/rust:ltsc2019-1.33.0

COPY install-sccache.ps1 temp/install-sccache.ps1

# Install sccache, using our fork for now as it has not had a new release with
# some changes we require, particularly regarding GCS support, once a release
# is made we can install it via scoop instead
RUN ./temp/install-sccache.ps1 -version "0.2.21" -repo "Jake-Shadle/sccache"

# Install cargo-make via cargo for now
RUN ./temp/install-cargo-make.ps1 -version "0.17.1"

# Cleanup all our temporary files
RUN Remove-Item -Recurse -Force ./temp
