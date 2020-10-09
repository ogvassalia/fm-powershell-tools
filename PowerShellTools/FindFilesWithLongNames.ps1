Param(
	[string]$dir,
	[int]$expectedLen
)

function Help {
	Write-Host -ForegroundColor Yellow "Error: AppId and Expiration date are mandatory"
	Write-Host
	Write-Host "Usage: Generate-License.ps1 WASTEAPP yyyyMMdd"
	Write-Host
	Write-Host "Application Ids: " $appIds
	Write-Host
}

if (!$PSBoundParameters.ContainsKey('dir')) {
	Help

	Exit 0
}

if (!$PSBoundParameters.ContainsKey('expectedLen')) {
	$expectedLen = "YYYYMMDDHHmmss0_99.99-FMRMS-9999-9.cs".Length;
}

foreach ($file in (Get-ChildItem -Path $dir -Exclude *.Designer.cs -Filter *.cs -Recurse -ErrorAction SilentlyContinue -Force)) {
	if ($file.Name.Length -gt $expectedLen) {
		Write-Host $file.FullName
		
		[string]$newName = $file.Name.Replace("trigger", "trg").Replace("Distance", "Dstnc").Replace("Duration", "Dur").Replace("workZone", "wz").Replace("WorkZone", "WZ").Replace("GeoZone", "GZ").Replace("user", "usr").Replace("User", "Usr").Replace("division", "div").Replace("Division", "Div").Replace("transaction", "trns").Replace("billing", "blng").Replace("Double", "Dbl").Replace("Delete", "Del").Replace("Group", "Grp").Replace("Building", "Bldg").Replace("Category", "Ctgr").Replace("Audit", "Adt").Replace("System", "Sstm").Replace("Complaint", "Cmpl").Replace("Source", "Src").Replace("Subscription", "Sub").Replace("Suspension", "Susp").Replace("ExtendedReference", "Xref").Replace("activity", "act").Replace("Activity", "Act").Replace("workflow", "Wf").Replace("WorkFlow", "Wf").Replace("workFlow", "wf").Replace("Workflow", "Wf").Replace("Constraint", "Ctrnt").Replace("Manual", "Mnl").Replace("operator", "oprtr").Replace("Operator", "Oprtr").Replace("update", "upd").Replace("Update", "Upd").Replace("Message", "Msg").Replace("view", "vw").Replace("View", "Vw").Replace("mesaurement", "msr").Replace("Mesaurement", "Msr").Replace("street-section", "ss").Replace("length", "len").Replace("Length", "Len").Replace("Drop", "Drp").Replace("drop", "drp").Replace("execution", "ex").Replace("Execution", "Ex").Replace("extra", "ex").Replace("Extra", "Ex").Replace("Stop", "St").Replace("stop", "st").Replace("state", "st").Replace("State", "St").Replace("sequence", "seq").Replace("Sequence", "Seq").Replace("Assignment", "Asn").Replace("assignment", "asn").Replace("Column", "clmn").Replace("modify", "mdf").Replace("Type", "tp").Replace("type", "tp").Replace("Path", "pth").Replace("path", "pth").Replace("Code", "Cd").Replace("code", "cd").Replace("Modify", "Mdf").Replace("Implementation", "Impl").Replace("vehicle_position_batch", "vpb").Replace("vehicle_file_detail", "vfd").Replace("ncc_matching_result", "ncc_mr").Replace("Columns", "Clmns").Replace("columns", "clmns").Replace("unique_id", "uid").Replace("index", "idx").Replace("Index", "Idx").Replace("workzone", "wz").Replace("table", "tbl").Replace("lication_id", "locId").Replace("inspection", "insp").Replace("message", "msg").Replace("Streetsweep", "ss").Replace("streetsweep", "ss").Replace("summary", "smr").Replace("unique", "u").Replace("Service", "Srv").Replace("service", "srv").Replace("shedule", "shdl").Replace("Container", "Cnt").Replace("container", "cnt").Replace("Customer", "Cst").Replace("customer", "cst").Replace("Location", "Loc").Replace("location", "loc").Replace("column", "clmn").Replace("delete", "del").Replace("identity", "idt").Replace("streetSection", "ss").Replace("Remove", "Rm").Replace("remove", "rm").Replace("Schedule", "Schdl").Replace("schedule", "schdl").Replace("subscription", "sub").Replace("Creation", "crt").Replace("Create", "crt").Replace("create", "crt").Replace("cascade", "cscd").Replace("Dispatch", "Disp").Replace("dispatch", "disp").Replace("Route", "rt").Replace("route", "rt").Replace("Unique", "U").Replace("result", "rst").Replace("Result", "Rst").Replace("facility", "fclt").Replace("Facility", "Fclt").Replace("Capacity", "Cpct").Replace("capacity", "cpct").Replace("Controller", "Ctrl").Replace("controller", "ctrl").Replace("Localization", "Loc").Replace("localization", "loc").Replace("Temporary", "Tmp").Replace("Modified", "Mdfd").Replace("Table", "Tbl").Replace("Frequency", "Freq").Replace("Material", "Mtrl")
		Write-Host "   New file name : " $newName.Replace(".cs", "")
		Write-Host "   New class name: " $newName.Replace("-", "").Replace(".cs", "")
	}
}
