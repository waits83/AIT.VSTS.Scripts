# This Function adds Testsuites to existing Testplan
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
#num { DynamicTestSuite, StaticTestSuite, RequirementTestSuite }
# TeamUrl is the url to the project
function AddTestSuitesByRequirements{
    	param (
        [Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[Int]$PlanId, 
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
	        Write-Verbose "Create new Testsuite"
		    $query = "/_apis/test/plans/$($PlanId)/suites/$($PlanId + 1)?api-version=v2.0-preview"
		    $addIturl = $ProjectUrl.AbsoluteUri + $query
    		$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $Username,$Token)))

		    #Get no Error, if is fail
		    $result = Invoke-RestMethod -Method Post -ContentType "application/json" -Uri $addIturl -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Body $jsonBody            
	    }

}

function GetRequirementIdsByQuery
{
       param (
        [Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[string]$QueryId,
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
	        Write-Verbose "Run Query Number: $QueryId"
		    $query = "/_apis/wit/wiql/$($QueryId)?api-version=v2.0-preview"
		    $addIturl = $ProjectUrl.AbsoluteUri + $query
    		$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $Username,$Token)))

		    #Get no Error, if is fail
		    $result = Invoke-RestMethod -Method Get -ContentType "application/json" -Uri $addIturl -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}           

            return $result
	    }

}

#Returns all Suites from a Testplan
function GetTestsuites
{
       param (
        [Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[Int]$PlanId, 
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
    Write-Verbose "Start Cleaning Testplan $PlanId"
            $query = "/_apis/test/plans/$($PlanId)/suites?api-version=v2.0-preview"
		    $addIturl = $ProjectUrl.AbsoluteUri + $query
    		$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $Username,$Token)))

		    #Get no Error, if is fail
		    $result = Invoke-RestMethod -Method get -ContentType "application/json" -Uri $addIturl -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}           
            Write-Verbose $result
            return $result
            
	    }
}

#Entfernt all Testsuites aus einem Testplan
function CleanTestplan
{
       param (
        [Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[Int]$PlanId, 
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
            Write-Verbose "Start Cleaning Testplan $PlanId"
            $query = "/_apis/test/plans/$($PlanId)/suites?api-version=v2.0-preview"
		    $addIturl = $ProjectUrl.AbsoluteUri + $query
    		$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $Username,$Token)))

		    #Get all Testsuites from Testplan
            $result = GetTestsuites $PlanId $ProjectUrl $Username $Token

            Write-Verbose "Current Testsuites in the plan: $result"

            ForEach($suite in $result.value)
            {
                #Ignore Testplans Default Suite
                if($suite.id -ne $PlanId + 1)
                {
                     $query = "/_apis/test/plans/$($PlanId)/suites/$($suite.id)?api-version=v2.0-preview"
		             $addIturl = $ProjectUrl.AbsoluteUri + $query
    		         $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $Username,$Token)))
                     Write-Verbose "Delete Suite $($suite.id)"
		             
                     #Get no Error, if is fail
		             $result = Invoke-RestMethod -Method Delete -ContentType "application/json" -Uri $addIturl -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}           
                }
            }
	    }

}
