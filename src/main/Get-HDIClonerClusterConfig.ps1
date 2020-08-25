
<#PSScriptInfo

.VERSION 1.0.0.7

.GUID ba60be59-a510-4ca2-a15d-34cbb83ed089

.AUTHOR Mahmood Abushaireh

.COMPANYNAME 

.COPYRIGHT 

.TAGS Azure 'Azure Automation'

.LICENSEURI 

.PROJECTURI http://mabushaireh.info/posts/about-register-selfdestructiveazresource

.ICONURI 

.EXTERNALMODULEDEPENDENCIES Az

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES
[1.0.0.6]       2020-06-24 Rename TicketNumber to RefNumber and make it [optional]
                2020-06-24 Make subscription ID [optinoal] if not passed default subscription is assumed
[1.0.0.7]       2020-06-29 Add help Message to the params
                2020-06-29 Add validation for -DeleteAfterDays, should positive integer and a maximum of 30 days.
                2020-06-29 Add validation for DeleteAfterTimeOfDay, should be positive and from 0 to 23 hours
[-VERSION]      2020-07-02 Add -Force to Expand-Archive to save over existing runbook

#>

<#
.Synopsis
    Schedule a cleanup job for the provided Azure Resources.
.DESCRIPTION
    Automatically delete Azure Resource at a given time date
       
.EXAMPLE
    Register-SelfDestructiveResource --ResourceId "Resource Id" -RefNumber "Ref Number"
    #Note: Refnumber is not to link the resource to an internal record, could be a workitem id if you are working on a project
    
.EXAMPLE
    Register-SelfDestructiveResource -ResourceName "Resource Name" -ResrourceGroup "Resource Group" -DeleteAfterDays 3 DeleteAfterTimeOfDay 19
.LINK
    http://mabushaireh.info/posts/about-register-selfdestructiveazresource
#>