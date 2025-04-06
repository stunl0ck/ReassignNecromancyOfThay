# PowerShell script to package the mod's .pak file into a versioned .zip archive for publishing.

param(
    [Parameter(Mandatory=$true)]
    [int]$Major,

    [Parameter(Mandatory=$true)]
    [int]$Minor,

    [Parameter(Mandatory=$true)]
    [int]$Revision,

    [Parameter(Mandatory=$true)]
    [int]$Build
)

# --- Configuration ---
$PakDirectory = Join-Path -Path $PSScriptRoot -ChildPath "PAK"
$ModName = "ReassignNecromancyOfThay" # Base name for PAK and ZIP
# ---------------------

# --- Main Execution ---

Write-Host "Starting publishing process for version $Major.$Minor.$Revision.$Build..."
Write-Host "Script Root (`$PSScriptRoot): $PSScriptRoot"
Write-Host "PAK Directory (`$PakDirectory): $PakDirectory"


# Construct Version String
$VersionString = "{0}.{1}.{2}.{3}" -f $Major, $Minor, $Revision, $Build
Write-Host "Mod Name: $ModName"
Write-Host "Version: $VersionString"

# Define Paths
$SourcePakPath = Join-Path -Path $PakDirectory -ChildPath "$ModName.pak"
$ZipFileName = "{0}_v{1}.zip" -f $ModName, $VersionString
$OutputZipPath = Join-Path -Path $PSScriptRoot -ChildPath $ZipFileName

Write-Host "Source PAK Path (`$SourcePakPath): $SourcePakPath"
Write-Host "Output ZIP Path (`$OutputZipPath): $OutputZipPath"

# Check if source .pak exists
if (-not (Test-Path $SourcePakPath)) {
    Write-Error ".pak file not found at $SourcePakPath. Please run build.ps1 first."
    exit 1
} else {
    Write-Host "Source .pak file found."
}

# Remove existing zip file if it exists
if (Test-Path $OutputZipPath) {
    Write-Host "Removing existing zip file: $OutputZipPath" -ForegroundColor Yellow
    Remove-Item -Path $OutputZipPath -Force
} else {
    Write-Host "No existing zip file found at $OutputZipPath."
}

# Create the zip archive
Write-Host "Creating zip archive using Compress-Archive..." -ForegroundColor Cyan
Write-Host "Compressing: $SourcePakPath"
Write-Host "To: $OutputZipPath"

try {
    Compress-Archive -Path $SourcePakPath -DestinationPath $OutputZipPath -CompressionLevel Optimal -ErrorAction Stop
    Write-Host "Successfully created zip archive!" -ForegroundColor Green
} catch {
    Write-Error "Failed to create zip archive: $($_.Exception.Message)"
    exit 1
}

Write-Host "Publishing process finished." 