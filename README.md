# docker-windows

[![Build status](https://badge.buildkite.com/269de3d39c9cc63f88cde297c27a00774532d44625dbebe6c3.svg?branch=master)](https://buildkite.com/embark-studios/windows-images)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2FEmbarkStudios%2Fdocker-windows.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2FEmbarkStudios%2Fdocker-windows?ref=badge_shield)

Dockerfiles for :windows: + :rust: CI

## Note on Base Image

The base image used for now is `mcr.microsoft.com/windows/servercore:ltsc2019`. Eventually we would like to
use something like `mcr.microsoft.com/powershell:nanoserver-1809` instead, due to its vastly smaller size, but there are...issues.

1. The base nano server image doesn't contain robocopy, which `scoop` needs to successfully install and function, this
can be worked around by copying robocopy into system32 however.
1. The next big problem is that msiexec and other installer related pieces are also not in the nano image. I stopped
investigating nano server images at this point since it seemed like this rabbit hole could be quite deep, and this
is just trying to install the most basic stuff.

## Images

The images are ordered in from least to most complex.

### [scoop](scoop/Dockerfile)

[scoop](https://scoop.sh/) forms our base image from which all other images descend for a couple of reasons.

1. `scoop` is the leanest and most practical package manager focused on Windows that we are aware of, especially as it
has the narrower focus of "developer tools" as opposed to eg. Chocolatey
1. Installs `git` via scoop as it is assumed the image will be used for the basis of CI, and git is required if one
wants to add additional scoop buckets anyway.

### [vs-build-tools](vs-build-tools/Dockerfile)

Installs the `VS2017` build tools needed to compile C and C++ code with MSVC.

### [rust](rust/Dockerfile)

Installs `rustup` and the `rust` toolchain for the `x86_64-pc-windows-msvc` triple. It defaults to the `stable` toolchain,
but this can be overriden by specifying a build flag eg. `--build-arg "rust_version=beta"`

### [rust-extras](rust-extras/Dockerfile)

This image contains a couple of additional things that improves our Rust CI.

1. [sccache](https://github.com/mozilla/sccache) is used to accelerate our builds by minimizing compilation.
1. [cargo-make](https://github.com/sagiegurari/cargo-make) is a convenient way to script Rust CI workflows.
1. [cargo-fetcher](https://github.com/EmbarkStudios/cargo-fetcher) is used to accelerate crate fetching.
1. openssl is installed via scoop so that any crates with dependencies on openssl-sys compile correctly
1. cmake is installed via scoop due to many C/C++ sys libraries depending on it

### [buildkite](buildkite/Dockerfile)

We are currently using [Buildkite](https://buildkite.com/) as our CI/CD service, this image adds the buildkite-agent as a service inside the image so that a running container can pick up jobs. However, the default installer on Windows
requires that the token be specified prior to install, so the installation is executed via `ONBUILD`, so you must
specify the environment variables when running `docker build` against a Dockerfile that is based off the buildkite image instead.

* `buildkiteAgentToken` - Your Buildkite token used to pair your agent with your account's or org's pipelines.
* `buildkiteAgentTags` - The tags applied to the agent that determine what jobs can be scheduled on it.

See the [buildkite documentation](https://buildkite.com/docs/agent/v3/configuration) for more available environment variables.

## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2FEmbarkStudios%2Fdocker-windows.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2FEmbarkStudios%2Fdocker-windows?ref=badge_large)
