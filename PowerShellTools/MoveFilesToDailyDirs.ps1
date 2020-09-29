#
# Script.ps1
#
param([string]$sourceDir, [string]$destDir)

if (!$sourceDir)
{
	Write-Host -ForegroundColor Yellow "Source directory should be specified"

	Exit -1
}

if (!$destDir)
{
	Write-Host -ForegroundColor Yellow "Destination directory should be specified"

	Exit -1
}

[string]$destDirMovies = $destDir + "\Movies"
[string]$destDirPhotos = $destDir + "\Photos"

foreach ($file in Get-ChildItem -File $sourceDir)
{
	[DateTime]$fileDate = $file.creationTime

	if ($fileDate -gt $file.lastWriteTime)
	{
		$fileDate = $file.lastWriteTime
	}

	[string]$fileName = ([string]$file.Name).ToLower();
	[string]$dailyFolder = [string]::Format("\{0:D4}\{1:D2}\{2:D2}",  $fileDate.Year,  $fileDate.Month,  $fileDate.Day)
	[string]$fullDestDirMovies = $destDirMovies + $dailyFolder
	[string]$fullDestDirPhotos = $destDirPhotos + $dailyFolder
	[string]$fullDestDir = ""

	if ($fileName.EndsWith(".jpg"))
	{
		$fullDestDir = $fullDestDirPhotos
	}
	elseif ($fileName.EndsWith(".mov") -or $fileName.EndsWith(".mp4"))
	{
		$fullDestDir = $fullDestDirMovies
	}
	else
	{
		Write-Host -ForegroundColor Yellow "Ignoring file" $file.Name

		continue;
	}

	#New-Item -ItemType Directory -Force -Path $fullDestDir

	Write-Host -ForegroundColor White "Start moving file" $file.FullName "to" $fullDestDir
	
	#Move-Item -Path $file.FullName -Destination $fullDestDir
}