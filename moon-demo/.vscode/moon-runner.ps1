param(
  [string]$Action = "run",
  [string]$Pkg = "cmd/main"
)

$currentDir = Get-Location
$projectRoot = $currentDir

while (-not (Test-Path (Join-Path $projectRoot "moon.mod.json"))) {
  $parent = Split-Path $projectRoot -Parent
  if ($parent -eq $projectRoot) {
    Write-Error "Cannot find moon.mod.json in any parent directory"
    exit 1
  }
  $projectRoot = $parent
}

Set-Location $projectRoot

switch ($Action) {
  "test" { moon test }
  "check" { moon check }
  "build" { moon build }
  default { moon run $Pkg }
}
