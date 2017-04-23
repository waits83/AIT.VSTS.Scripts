
$ScriptPath = Split-Path $MyInvocation.InvocationName
. "$ScriptPath\TestObjectsFactory.ps1" 
. "$ScriptPath\AddTestSuitesByRequirements.ps1" 

#credentials with token (VSTS)
$Username ="xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
$Token = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

#Url to VSTS
$baseUrl = "https://xxxxxx.visualstudio.com/Entwicklung"


#Test Testsuite creation
$JSON = CreateTestSuiteJson "RequirementTestSuite" "" "" "256"
#echo $JSON
$PlanId = 358

#Test Testplancreation
#$JSON = CreateTestplanJson "MeinNeuerTestplan" "Meine Beschreibung" "Entwicklung\HOLZ"

#Start cmdlet 
$queryId ="7dc10225-e47f-467d-8835-c15d82b030bd"
$result = GetRequirementIdsByQuery $queryId $baseUrl $Username $Token -Verbose
echo $result.workItems


$testsuites = GetTestsuites  $PlanId $baseUrl $Username $Token -Verbose
echo $testsuites.value.requirementId

#CleanTestplan $PlanId $baseUrl $Username $Token -Verbose
#ForEach($workitem in $result.workItems)
#{
# $JSON = CreateTestSuiteJson "RequirementTestSuite" "" "" $workitem.id
# AddTestSuitesByRequirements $PlanId $JSON $baseUrl $Username $Token -Verbose
#}

#AddTestSuitesByRequirements $PlanId $JSON $baseUrl $Username $Token -Verbose
#& CreateTestPlan $JSON $baseUrl $Username $Token -Verbose



