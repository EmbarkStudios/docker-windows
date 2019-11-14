param(
    [string]$version = $(throw "-version is required."),
    [string]$repo = "EmbarkStudios/cargo-fetcher"
)

$name = "cargo-fetcher-$version-x86_64-pc-windows-msvc"

Invoke-WebRequest -Uri "https://github.com/$repo/releases/download/$version/$name.tar.gz" -OutFile ./temp/archive.tar.gz

# 7z apparently can't decompress and extract in one execution...why even
7z e "-o./temp" ./temp/archive.tar.gz
7z e "-o./temp" "./temp/$name.tar"
ls ./temp

# Place cargo-fetcher in $HOME/.cargo/bin as it's in $PATH
mv ./temp/cargo-fetcher.exe $env:CARGO_HOME/bin
