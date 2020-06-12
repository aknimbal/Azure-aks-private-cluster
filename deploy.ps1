#Requires -Version 3.0

Connect-AzureRmAccount

# Variables
#-----------------------------------------------------------
$ResourceGroupName = "inspirepocrg"
$ResourceGroupLocation = "eastus"

# Create the resource group only when it doesn't already exist

Write-Output '', 'Checking and creating resourcess needed for setup'

if ((Get-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -ErrorAction SilentlyContinue) -eq $null) {
    Write-Output '', 'Creating Resource Group - ', @($ResourceGroupName)
    New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force -ErrorAction Stop
    Write-Output '', @($ResourceGroupName), ' Resource Group created' 	
}

Write-Output '', 'Starting ARM deployment of services. This might take a while'

New-AzureRMResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile ./azuredeploy.json -TemplateParameterFile ./azuredeploy.parameters.json -DeploymentDebugLogLevel All