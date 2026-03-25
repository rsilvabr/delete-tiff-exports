# ── SETTINGS ──────────────────────────────────────────────────────
$ExportMarker  = "_EXPORT"   # name of the anchor folder to look for in the path
$TiffSubfolder = "TIFF16"    # name of the TIFF subfolder inside the anchor folder
                              # Script deletes: ...\$ExportMarker\$TiffSubfolder\

$DryRun        = $true       # true  → show what would be deleted, without deleting anything
                              # false → actually delete (IRREVERSIBLE)
# ──────────────────────────────────────────────────────────────────

$root = (Get-Location).Path

# Find all folders matching: ...\$ExportMarker\$TiffSubfolder
$targets = Get-ChildItem -Path $root -Directory -Recurse -Force -ErrorAction SilentlyContinue |
    Where-Object {
        $_.Name -ieq $TiffSubfolder -and
        $_.Parent -and $_.Parent.Name -ieq $ExportMarker -and
        -not ($_.Attributes -band [IO.FileAttributes]::ReparsePoint)
    }

# List found folders
Write-Host ""
Write-Host "Root: $root"
Write-Host "Target pattern: ...\$ExportMarker\$TiffSubfolder"
Write-Host "Folders found: $($targets.Count)"
Write-Host ""

if ($targets.Count -eq 0) {
    Write-Host "Nothing to do."
    exit
}

$targets | Sort-Object FullName | ForEach-Object { Write-Host "  $($_.FullName)" }
Write-Host ""

if ($DryRun) {
    Write-Host "DRY RUN — no files deleted. Set `$DryRun = `$false to actually delete."
    Write-Host ""
    $targets | ForEach-Object {
        Remove-Item -LiteralPath $_.FullName -Recurse -Force -WhatIf
    }
} else {
    Write-Host "DELETING — this is irreversible."
    Write-Host ""
    $targets | ForEach-Object {
        Remove-Item -LiteralPath $_.FullName -Recurse -Force
        Write-Host "Deleted: $($_.FullName)"
    }
    Write-Host ""
    Write-Host "Done. $($targets.Count) folder(s) deleted."
}
