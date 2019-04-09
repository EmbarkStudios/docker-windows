$all = @(
    "--quiet",
    "--wait",
    "--norestart",
    "--nocache",
    "--installPath", "C:/buildtools",
    "--add", "Microsoft.VisualStudio.Workload.VCTools;includeRecommended",
    "--add", "Microsoft.VisualStudio.Workload.MSBuildTools"
)

c:/temp/vs_buildtools.exe $all
