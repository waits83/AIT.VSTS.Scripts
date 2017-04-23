#Start cmdlet 
$ScriptPath = Split-Path $MyInvocation.InvocationName
& "$ScriptPath\TeamAssignment\Relate-VstsIteration.ps1"

#GET Iterations


		$iterationUri = "https://xxxxxx.visualstudio.com/Entwicklung/2D/_apis/work/teamsettings/iterations?`$timeframe=current&api-version=v2.0-preview"

		
			#credentials with token (VSTS)
			$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("xxxxxxxx@xxx.xx:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")))
			$iterationList = Invoke-RestMethod -Uri $iterationUri -Method Get -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -ErrorAction Stop
		echo $iterationList

