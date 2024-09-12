$SCRIPTDIR = $PSScriptRoot
$PARENTDIR = (Get-Item $SCRIPTDIR ).parent.FullName
$SOURCEDIR = "${PARENTDIR}\source"
$BUILDDIR = "$($PARENTDIR)\build\"
if (-Not (Test-Path "$($BUILDDIR)" -PathType Container))
{
  New-Item "$($BUILDDIR)" -ItemType Directory
  if (-Not (Test-Path "$($BUILDDIR)" -PathType Container))
  {
    Exit 255
  }
}
Set-Location "$($SOURCEDIR)"
& '.\pyenv_nuitka_setup.ps1' || Exit 254
& '.\nuitka_compile.ps1' || Exit 253
if (-Not (Test-Path "$($SOURCEDIR)\mapimage.exe" -PathType Leaf))
{
  Exit 254
}
Move-Item -Path "$($SOURCEDIR)\mapimage.exe" "$($BUILDDIR)\am_mapimage.exe" || Exit 253
Exit 0