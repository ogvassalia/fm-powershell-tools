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

	New-Item $newFileName | Out-Null
	[int]$lineCnt = 0
	[int]$contentChanged = 0

	foreach ($line in Get-Content $fileName)
	{
		$lineCnt++
		
		if ($line.StartsWith("//FixCodeStyle.ps1:"))
		{
			continue;
		}
	    
		[int]$indentLen = $line.length - $line.Trim().length
		[int]$indentLenDiff = (($indentLen / 4) * 4)
		
		if ($indentLen -lt 4 -and $indentLen -gt 0) {
		    Write-Host -BackgroundColor Yellow -ForegroundColor Red "Error: Wrong indentation at line:" $lineCnt "    " $fileName
			
			Exit 0
		}
		
		if ($indentLen -ne $indentLenDiff) {
		    Write-Host "Error: Wrong indentation at line: " $lineCnt $fileName
			
			Exit 0
		}
		
		if ($contentChanged -eq 0 -and $line -ne $line.TrimEnd()) {
			$contentChanged = 1
		}
		
		Add-Content -Path $newFileName $line.TrimEnd()
	}
	
    [string]$content = "//FixCodeStyle.ps1: Last time analyzed " + ([System.DateTime]::Now.ToString("yyyy-MM-dd HH:mm:ss"))
	
	Add-Content -Path $newFileName $content
	
	if ($contentChanged -eq 1) {
		Write-Host "Content changed: " $fileName
	}
	
	return $newFileName
}

if ($PSBoundParameters.Count -eq 1) {
	Write-Host "Fixing: " $dirNameOrFileName
	
	fix($dirNameOrFileName)
	
	Remove-Item -Force $dirNameOrFileName
	
	Exit 0
}

if ($PSBoundParameters.Count -eq 2) {
	foreach ($fileName in Get-ChildItem -Path $dirNameOrFileName -Include *.$ext -Recurse)
	{
		if (Test-Path $fileName.FullName -PathType Container)
		{
			Write-Host $fileName.FullName "is a directory"
			continue;
		}
	
		[string]$newFileName = fix($fileName.FullName)

		Move-Item -Force $newFileName $fileName.FullName
	}
	
	Exit 0
}

Help
