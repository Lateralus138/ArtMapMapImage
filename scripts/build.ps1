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
& '.\pyenv_nuitka_setup.ps1' | Exit 254
& '.\nuitka_compile.ps1' | Exit 253
# MSBuild /p:Configuration=Release /p:Platform=x86
# if (-Not (Test-Path "$($SOURCEDIR)\Release\am_closest.exe" -PathType Leaf))
# {
#   Exit 252
# }
# Move-Item -Path "$($SOURCEDIR)\Release\am_closest.exe" "$($BUILDDIR86)\am_closest-x86.exe"
# MSBuild /p:Configuration=Release /p:Platform=x64
# if (-Not (Test-Path "$($SOURCEDIR)\x64\Release\am_closest.exe" -PathType Leaf))
# {
#   Exit 251
# }
# Move-Item -Path "$($SOURCEDIR)\x64\Release\am_closest.exe" "$($BUILDDIR64)\am_closest-x64.exe"
