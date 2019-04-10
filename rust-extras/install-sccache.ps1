param(
    [string]$version = $env:SCCACHE_VERSION,
    [string]$repo = $env:SCCACHE_REPO
)

# We could alternatively also just do a cargo install <sccache-repo>
$name = "sccache-$version-x86_64-pc-windows-msvc"

Invoke-WebRequest -Uri "https://github.com/$repo/releases/download/$version/$name.tar.gz" -OutFile ./temp/archive.tar.gz

# 7z apparently can't decompress and extract in one execution...why even
7z e "-o./temp" ./temp/archive.tar.gz
7z e "-o./temp" "./temp/$name.tar"
ls ./temp

# Place sccache in $HOME/.cargo/bin as it's in $PATH
mv ./temp/sccache.exe $env:CARGO_HOME/bin
