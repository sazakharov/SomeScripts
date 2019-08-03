# Author: Sergey A Zakharov
# The script takes files from SourcePath compares with DestinationPath,
# if there are matching files, it packs matching files from DestinationPath
# into a 7z archive in the BackupPath folder (file name is <date>_<time>.7z).
# Then it copies the files from SourcePath to DestinationPath
# PS: 7zip must be installed in the system, indicate the path to it in the variable $7zip

$BackupPath = "D:\SomeBackupPath"
$SourcePath="C:\Some\Source\Path"
$DestinationPath="C:\Some\Destionation\Path"
$7zip="C:\Program Files\7-Zip\7z.exe"

$SourceFiles = ( Get-ChildItem $SourcePath -Recurse | where {$_.Mode -notlike 'd*'} | foreach {$_.FullName.Replace("$SourcePath\","") } )

$DestinationFiles = ( Get-ChildItem $DestinationPath -Recurse | where {$_.Mode -notlike 'd*'} | foreach {$_.FullName.Replace("$DestinationPath\","") } )

$ToPackFiles = @()

$SourceFiles | foreach { if ($DestinationFiles -match "^"+ $_.Replace("\","\\") +"$") { $ToPackFiles += $_ } }

cd $DestinationPath

if ($ToPackFiles) { $ToPackFiles | & $7zip a -mx9 ("$BackupPath\"+(Get-Date -Format "yyyy-MM-dd_HHmmss")+".7z") }

Copy-Item "$SourcePath\*" -Recurse $DestinationPath -Force -PassThru | foreach { Write-Host $_.F
ullName }