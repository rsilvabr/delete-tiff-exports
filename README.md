# delete_tiff_exports.ps1

Recursively finds and deletes TIFF export folders matching a configurable path pattern.

⚠️ **This script permanently deletes files. Always run with `$DryRun = $true` first.**

---

## What it does

Searches recursively from the current folder for directories matching:
```
...\<ExportMarker>\<TiffSubfolder>\
```

Default pattern: `..._EXPORT\TIFF16\`

This matches the standard Capture One `_EXPORT` folder structure. Only folders at
exactly this depth are matched — other folders are not affected.


---

## Disclaimer

These tools were made for my personal workflow (with the help of Claude). Use at your own risk — I am not responsible for any issues you may encounter.
If you choose to use it and find any errors/bugs, please let me know.

---

## Usage

1. Open PowerShell 7 in the root folder of your photo archive
2. Edit `$ExportMarker` and `$TiffSubfolder` at the top if needed
3. Run with `$DryRun = $true` (default) to preview what would be deleted
4. When satisfied, set `$DryRun = $false` and run again to delete

```powershell
# Preview (safe)
.\delete_tiff_exports.ps1

# Actually delete — edit $DryRun = $false in the script first
.\delete_tiff_exports.ps1
```

---

## Settings

```powershell
$ExportMarker  = "_EXPORT"   # anchor folder name to look for in the path
$TiffSubfolder = "TIFF16"    # TIFF subfolder name inside the anchor
$DryRun        = $true       # true = preview only | false = delete (irreversible)
```

---

## Example

With default settings, running from `F:\2024`:

```
F:\2024\Session_A\_EXPORT\TIFF16\   ← deleted ✓
F:\2024\Session_B\_EXPORT\TIFF16\   ← deleted ✓
F:\2024\Session_B\_EXPORT\16B_JXL\  ← not touched
F:\2024\Session_B\RAW\              ← not touched
```

---

## Disclaimer

This script permanently deletes files and folders. Make sure your JXL conversions
are complete and verified before running. No recovery is possible after deletion.
