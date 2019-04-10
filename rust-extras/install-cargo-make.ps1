param(
    [string]$version = $(throw "-version is required.")
)

# We could alternatively also just do a cargo install <sccache-repo>
$name = "cargo-make-v$version-x86_64-pc-windows-msvc"

Invoke-WebRequest -Uri "https://github.com/sagiegurari/cargo-make/releases/download/$version/$name.zip" -OutFile ./temp/archive.zip

7z e ./temp/archive.zip "-o$env:CARGO_HOME/bin" "cargo-make.exe"
