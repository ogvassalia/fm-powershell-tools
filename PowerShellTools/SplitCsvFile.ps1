Param(
	[string]$inputDir,
	[string]$ouputDir,
	[int]$expectedRowNbr
)

function Help {
	Write-Host -ForegroundColor Yellow "Error: inputDir is mandatory"
	Write-Host
	Write-Host "Usage: inputDir <path> ouputDir <path> expectedRowNbr"
	Write-Host
	Write-Host
}

if (!$PSBoundParameters.ContainsKey('inputDir')) {
	Help

	Exit 0
}

if (!$PSBoundParameters.ContainsKey('$expectedRowNbr')) {
	$expectedRowNbr = 5000;
}

if (!$PSBoundParameters.ContainsKey('$ouputDir')) {
	$ouputDir = $inputDir;
}

Write-Host "ExpectedRowNbr: " $expectedRowNbr

[int]$fileSeq = 1;

foreach ($file in (Get-ChildItem -Path $inputDir -Filter *.csv -ErrorAction SilentlyContinue -Force)) {
	Write-Host "Start processing: " $file.Name

	[int]$lineCnt = 0;
	[string]$newFileName = $ouputDir + "\" + $fileSeq + "-" + $file.Name

	Write-Host "Start writing to: " $newFileName

	New-Item $newFileName | Out-Null

	foreach($line in Get-Content $file) {
		$lineCnt = $lineCnt + 1;

		if ($lineCnt -gt $expectedRowNbr) {
			$lineCnt = 0;
			$fileSeq = $fileSeq + 1;
			$newFileName = $ouputDir + "\" + $fileSeq + "-" + $file.Name

			Write-Host "Start writing to: " $newFileName

			New-Item $newFileName | Out-Null
		}

		Add-Content -Value $line -Path $newFileName
	}
}