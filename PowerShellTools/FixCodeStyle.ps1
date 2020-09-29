Param(
	[string]$dirNameOrFileName,
	[string]$ext
)

function Help {
	Write-Host -ForegroundColor Yellow "Error: path to directory is mandatory"
	Write-Host
	Write-Host "Usage: FixCodeStyle.ps1 (<dir path> <file extension>) | (file name)"
	Write-Host
}

function fix {
	param ($fileName)
	[string]$newFileName = $fileName + ".fix"

	if (Test-Path $newFileName)
	{
		Remove-Item -Path $newFileName
	}

	New-Item $newFileName

	foreach ($line in Get-Content $fileName)
	{
		if ($line.StartsWith("//FixCodeStyle.ps1: analyzed"))
		{
			continue;
		}
	
		Add-Content -Path $newFileName $line.TrimEnd()
	}

	Add-Content -Path $newFileName "//FixCodeStyle.ps1: analyzed"
	
	return $newFileName
}

if ($PSBoundParameters.length -eq 1) {
	Write-Host "Fixing: " $dirNameOrFileName
	
	fix($dirNameOrFileName)
	
	Remove-Item -Force $dirNameOrFileName
	
	Exit 0
}

if ($PSBoundParameters.length -eq 2) {
	foreach ($fileName in Get-ChildItem -Path $dirNameOrFileName -Include *.$ext -Recurse)
	{
		[string]$newFileName = fix($fileName.FullName)

		Move-Item -Force $newFileName $fileName.FullName
	}
	
	Exit 0
}

Help
