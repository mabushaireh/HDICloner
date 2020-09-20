# HDICloner

## Overview
A tool that collect HdInisght cluster configuration and clone or prepare the script required to clone. 
This is a comamnd line tool that has the following options: 
1. Get Cluster Configuration.
2. Build Cluster from Configuration
3. Generate Make File for the creation (PowerShell, ARM templates and Action Scripts)
4. Compare two clusters and show differnces (Visual Comparison) 
5. Sync Two clusters configuration 
6. Dry Run configuration (Validate cluster configuration)

## High Level Architecture
![Artifacts/HLA.png](/Artifacts/HLA.png)

## Usage
With this PowerShell module you can run several commands such as "Get,Make,Build,Compare,Sync".

There are five cmdlets in the module; Build-HDIClonerCluster, Make-HDIClonerClusterConfig, Compare-HDIClonerClusterConfig, Get-HDIClonerClusterConfig and Sync-HDIClonerCluster; 

Example: Get the HDInsight cluster configuration with given name and Subscription ID:

Run-HDICloner -Operation Get -SourceCluster SourceClusterdnsName -SourceSubId SourceClusterSubscriptionID     

## Setup
This module is published on PowerShell Gallery (https://www.powershellgallery.com/packages/HDICloner) and can be installed using Install-Module:

Install-Module -Name HDICloner

## Output Explained
![Artifacts/HLA.png](/Artifacts/Output.png)

## Credits
