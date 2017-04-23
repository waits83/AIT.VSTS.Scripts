#Mit den Funktionen können die verschiedenen Jsonobjekte erstellt werden,
# die für die REST Api des Tfs benötigt werden

#Jsonobjekt für Testpläne
function CreateTestplanJson
{
    param (
		[Parameter(Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[String]$Name, 
		[Parameter(Mandatory=$false)]
		[ValidateNotNullOrEmpty()]
		[String] $Description,
		[Parameter(Mandatory=$false)]
		[ValidateNotNullOrEmpty()]
		[string]$Area
	)
    process
    {
        $body = @{  
            name= $name; 
            description= $description; 
            area=@{name=$area}
            }

            
        return $body | convertto-json
    }
}



#Test suite Json
# {
#  "suiteType": {
#    enum { StaticTestSuite, DynamicTestSuite, RequirementTestSuite }
#    },
#  "name": { string },
#  "queryString": { string },
# "requirementIds": [
#   "id": {int}
#  ]
# }
function CreateTestSuiteJson
{
    param (
		[Parameter(Mandatory=$true)]
		[ValidateSet('StaticTestSuite','DynamicTestSuite','RequirementTestSuite')]
		[String]$SuiteType, 
		[Parameter(Mandatory=$false)]
		[String]$Name,
		[Parameter(Mandatory=$false)]
		[String]$QueryString,
		[Parameter(Mandatory=$false)]
		[int[]]$requirementIds
	)
    process
    {
        $body = @{  
            suiteType= $SuiteType; 
            name= $Name; 
            queryString=$QueryString;
            requirementIds=$requirementIds;
            }

            
        return $body | convertto-json
    }
}