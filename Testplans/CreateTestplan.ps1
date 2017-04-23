# This Function creates a new Testplan
# You need to have enough right to be allowed to create testplans in VSTS or tfs
# JsonBody needs json formatted Testplandata
# {
#  "name": {string},
#  "description": {string},
#  "area": {"name" : string},
#  "iteration": {string},
#  "startDate": {DateTime},
#  "endDate": {DateTime}
# }
# TeamUrl is the url to the project
function CreateTestplan{
    	param (
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[String]$JsonBody, 
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[Uri] $ProjectUrl,
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[string]$Username,
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[string]$Token
	)


    process{
	        Write-Verbose "Create new Testplan"
		    $query = "/_apis/test/plans?api-version=v2.0-preview"
		    $addIturl = $ProjectUrl.AbsoluteUri + $query
    		$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $Username,$Token)))

		    #Get no Error, if is fail
		    $result = Invoke-RestMethod -Method Post -ContentType "application/json" -Uri $addIturl -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Body $jsonBody
            
	    }

}